import argparse
import json
from datetime import datetime
from typing import Optional, Dict, Any

from rucio.client.didclient import DIDClient
from rucio.common.exception import DataIdentifierNotFound, RucioException

did_client = DIDClient()

def parse_did(did_str: str):
    did_str = did_str.strip()
    if not did_str or did_str.startswith("#"):
        return None
    if ":" not in did_str:
        raise ValueError(f"Invalid DID (missing ':'): {did_str}")
    scope, name = did_str.split(":", 1)
    scope = scope.strip()
    name = name.strip()
    if not scope or not name:
        raise ValueError(f"Invalid DID (empty scope/name): {did_str}")
    return scope, name

def fmt_dt(dt):
    if not dt:
        return None
    if isinstance(dt, datetime):
        return dt.isoformat()
    try:
        return str(dt)
    except Exception:
        return None

def collect_content(dc: DIDClient, scope: str, name: str):
    """Return a list of dicts (scope, name, type) for direct content."""
    items = []
    try:
        for item in dc.list_content(scope=scope, name=name):
            itype = item.get("type") or item.get("did_type") or "UNKNOWN"
            items.append({"scope": item["scope"], "name": item["name"], "type": itype})
    except DataIdentifierNotFound:
        return []
    return items

def collect_rules(dc: DIDClient, scope: str, name: str):
    """Return a list of rules for the DID with selected fields."""
    rules = []
    try:
        iterator = dc.list_did_rules(scope=scope, name=name)
    except Exception:
        return rules
    for r in iterator:
        rules.append({
            "id": r.get("id"),
            "account": r.get("account"),
            "rse_expression": r.get("rse_expression"),
            "state": r.get("state"),
            "copies": r.get("copies"),
            "created_at": fmt_dt(r.get("created_at")),
            "expires_at": fmt_dt(r.get("expires_at")),
            "locks_ok_cnt": r.get("locks_ok_cnt"),
            "locks_replicating_cnt": r.get("locks_replicating_cnt"),
            "locks_stuck_cnt": r.get("locks_stuck_cnt"),
        })
    return rules
def build_did_report(scope: str, name: str) -> Optional[Dict[str, Any]]:
    """Create a structured JSON-able dict for a single DID (with direct content and rules)."""
    try:
        did_info = did_client.get_did(scope=scope, name=name)
        did_type = did_info.get("type", "UNKNOWN")
    except DataIdentifierNotFound:
        # Return a sentinel entry if you want to record missing DIDs, or return None to skip
        return {
            "did": f"{scope}:{name}",
            "scope": scope,
            "name": name,
            "error": "DataIdentifierNotFound"
        }
    except RucioException as e:
        return {
            "did": f"{scope}:{name}",
            "scope": scope,
            "name": name,
            "error": f"RucioException: {e}"
        }

    content = collect_content(did_client, scope, name)
    content_entries = []
    for c in content:
        child_rules = collect_rules(did_client, scope=c["scope"], name=c["name"])
        content_entries.append({
            "scope": c["scope"],
            "name": c["name"],
            "type": c["type"],
            "rules": child_rules
        })

    return {
        "did": f"{scope}:{name}",
        "scope": scope,
        "name": name,
        "type": did_type,
        "content_count_direct": len(content_entries),
        "content": content_entries
    }

def process_dids(input_path: str, output_path: str):
    # Read all DID lines
    with open(input_path, "r") as f:
        did_lines = [ln.strip() for ln in f if ln.strip() and not ln.strip().startswith("#")]

    all_reports = []  # <--- accumulate every DID’s dict here

    for idx, ln in enumerate(did_lines, start=1):
        try:
            parsed = parse_did(ln)
            if not parsed:
                continue
            scope, name = parsed
        except ValueError as e:
            print(f"[{idx}] Skipping invalid line: {e}")
            continue

        header = f"DID: {scope}:{name}"
        print("=" * len(header))
        print(header)
        print("=" * len(header))

        report = build_did_report(scope, name)
        if report is None:
            # If you prefer to include an explicit error entry, handle above in build_did_report
            print(f"  [!] Skipping {scope}:{name} (no report built).")
            continue

        # Optional console feedback
        if "error" in report:
            print(f"  [!] {report['error']}")
        else:
            print(f"  Type: {report['type']}")
            print(f"  Content count (direct): {report['content_count_direct']}")

        all_reports.append(report)

    # Write ONE JSON array with all DIDs
    with open(output_path, "w", encoding="utf-8") as out:
        json.dump(all_reports, out, indent=2, ensure_ascii=False)

    print(f"\n[✓] JSON report with {len(all_reports)} DID(s) written to {output_path}")

def main():
    parser = argparse.ArgumentParser(
        description="Read a list of DIDs, gather direct content + rules for each, and write a JSON report."
    )
    parser.add_argument(
        "-i", "--input", required=True,
        help="Path to text file with one DID per line (format: scope:name). Lines starting with # are ignored."
    )
    parser.add_argument(
        "-o", "--output", required=True,
        help="Path to output JSON file."
    )
    args = parser.parse_args()
    process_dids(args.input, args.output)

if __name__ == "__main__":
    main()

