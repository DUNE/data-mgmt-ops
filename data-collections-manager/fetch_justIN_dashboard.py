import argparse
import requests
import json
import os
from datetime import datetime
from collections import Counter

def fetch_justIN(workflow_id: int, event_type: str):
    
    url = (
        "https://dunejustin.fnal.gov/dashboard/"
        f"?method=download-events&event_type_name={event_type}&workflow_id={workflow_id}"
        f"&stage_id=&file_did=&jobsub_id=&jobscript_exit=&site_name=&entry_name=&rse_name=&format=json"
    )
    
    '''
    url = (
        "https://justin.dune.hep.ac.uk/dashboard/"
        f"?method=download-events&event_type_name={event_type}&workflow_id={workflow_id}"
        f"&stage_id=&file_did=&jobsub_id=&jobscript_exit=&site_name=&entry_name=&rse_name=&format=json"
    )
    '''
    print(f"[INFO] Fetching events from: {url}")
    response = requests.get(url)
    response.raise_for_status()
    return response.json()

def calculate_rate(events):
    """
    Calculates the event rate per minute.
    Assumes events is a list of dicts with 'event_time' field in ISO 8601 format.
    """
    time_bins = []

    for event in events:
        timestamp = event.get("event_time")
        if timestamp:
            dt = datetime.fromisoformat(timestamp)
            time_bins.append(dt.replace(second=0, microsecond=0))

    counts = Counter(time_bins)

    sorted_bins = sorted(counts.items())
    rate_lines = []
    for t, count in sorted_bins:
        rate_lines.append(f"{t.isoformat()} - {count} events")

    total_events = len(time_bins)
    if not time_bins:
        return [], "\n[!] No valid 'create_time' values found. Cannot compute rate.\n"
    duration_minutes = max(1, (max(time_bins) - min(time_bins)).total_seconds() / 60)
    avg_rate = total_events / duration_minutes

    summary = f"\nTotal events: {total_events}\nTime span: {duration_minutes:.1f} min\nAverage rate: {avg_rate:.2f} events/min\n"

    return rate_lines, summary

def main():
    parser = argparse.ArgumentParser(description="Fetch justIN event data and calculate event rate.")
    parser.add_argument('--workflow', type=int, required=True, help="Workflow ID from DUNE dashboard.")
    parser.add_argument('--event_type', type=str, required=True, help="Event type, e.g. FILE_ALLOCATED")
    parser.add_argument('--output', type=str, default="event_rate.txt", help="Output file to write rate info.")
    args = parser.parse_args()
    # Build JSON path with same basename as output (replace extension with .json)
    base, _ = os.path.splitext(args.output)
    json_path = base + ".json"

    try:
        data = fetch_justIN(args.workflow, args.event_type)
        events = data if isinstance(data, list) else data.get("data", [])
        if not events:
            print("[!] No events found.")
            return

        # Save raw JSON payload
        with open(json_path, "w") as jf:
            json.dump(data, jf, indent=2, ensure_ascii=False)
        print(f"[✓] JSON saved to {json_path}")

        rate_lines, summary = calculate_rate(events)

        with open(args.output, "w") as f:
            f.write(f"# Event Rate for workflow={args.workflow}, event_type={args.event_type}\n")
            f.write("\n".join(rate_lines))
            f.write("\n" + summary)

        print(f"[✓] Results written to {args.output}")

    except Exception as e:
        print(f"[✗] Error: {e}")

if __name__ == "__main__":
    main()

