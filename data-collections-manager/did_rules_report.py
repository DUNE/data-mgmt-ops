import argparse
from datetime import datetime

from rucio.client.didclient import DIDClient
from rucio.client.ruleclient import RuleClient
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
        return "-"
    # dt can be a datetime or string depending on client; normalize
    if isinstance(dt, datetime):
        return dt.isoformat()
    try:
        return str(dt)
    except Exception:
        return "-"

def collect_content(dc: DIDClient, scope: str, name: str):
    """Return a list of dicts (scope, name, type) for direct content."""
    items = []
    try:
        for item in dc.list_content(scope=scope, name=name):
            # item keys often include: scope, name, did_type or type
            itype = item.get("type") or item.get("did_type") or "UNKNOWN"
            items.append({"scope": item["scope"], "name": item["name"], "type": itype})
    except DataIdentifierNotFound:
        # No content or DID not found handled at caller
        return []
    return items

def collect_rules(dc: DIDClient, scope: str, name: str):
    """
    Return a list of rules for the DID with selected fields.
    Compatible with Rucio clients that don't have list_did_rules.
    """
    rules = []
    iterator = None
    iterator = dc.list_did_rules(scope = scope, name=name)
    for r in iterator:
        print(r.get('id'))
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

def process_dids(input_path: str, output_path: str):

    lines_out = []
    with open(input_path, "r") as f:
        did_lines = [ln.strip() for ln in f if ln.strip() and not ln.strip().startswith("#")]

    for idx, ln in enumerate(did_lines, start=1):
        try:
            parsed = parse_did(ln)
            if not parsed:
                continue
            scope, name = parsed
        except ValueError as e:
            msg = f"[{idx}] Skipping invalid line: {e}"
            print(msg)
            lines_out.append(msg)
            continue

        header = f"DID: {scope}:{name}"
        print("=" * len(header))
        print(header)
        print("=" * len(header))

        lines_out.append("")
        lines_out.append(header)
        lines_out.append("-" * len(header))

        try:
            did_info = did_client.get_did(scope=scope, name=name)
            did_type = did_info.get("type", "UNKNOWN")
        except DataIdentifierNotFound:
            msg = f"  [!] DID not found: {scope}:{name}"
            print(msg)
            lines_out.append(msg)
            continue
        except RucioException as e:
            msg = f"  [!] Error fetching DID info for {scope}:{name}: {e}"
            print(msg)
            lines_out.append(msg)
            continue

        print(f"  Type: {did_type}")
        lines_out.append(f"  Type: {did_type}")

        # Content (direct children)
        content = collect_content(did_client, scope, name)
        print(f"  Content count (direct): {len(content)}")
        lines_out.append(f"  Content count (direct): {len(content)}")
        if content:
            lines_out.append("  Content (scope:name, type):")
            for c in content:
                line = f"    - {c['scope']}:{c['name']} , {c['type']}"
                print(line)
                lines_out.append(line)
                rules = collect_rules(did_client, scope=c['scope'], name=c['name'])
                if rules:
                    lines_out.append("  Rules:")
                for r in rules:
                    rlines = [
                    f"    - id={r['id']}",
                    f"      account={r['account']}",
                    f"      rse_expression={r['rse_expression']}",
                    f"      state={r['state']}, copies={r['copies']}",
                    f"      created_at={r['created_at']}, expires_at={r['expires_at']}",
                    f"      locks_ok={r['locks_ok_cnt']}, replicating={r['locks_replicating_cnt']}, stuck={r['locks_stuck_cnt']}",
                    ]
                    for rl in rlines:
                        print(rl)
                        lines_out.append(rl)

    with open(output_path, "w") as out:
        out.write("\n".join(lines_out) + "\n")

    print(f"\n[✓] Report written to {output_path}")

def main():
    parser = argparse.ArgumentParser(
        description="Read a list of DIDs, show direct content and list Rucio rules for each, and write a report."
    )
    parser.add_argument(
        "-i", "--input", required=True,
        help="Path to text file with one DID per line (format: scope:name). Lines starting with # are ignored."
    )
    parser.add_argument(
        "-o", "--output", required=True,
        help="Path to output text file where the report will be written."
    )
    args = parser.parse_args()
    process_dids(args.input, args.output)

if __name__ == "__main__":
    main()

