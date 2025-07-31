import argparse
import matplotlib.pyplot as plt
from datetime import datetime
import os

def parse_event_file(filepath):
    times = []
    counts = []
    with open(filepath, 'r') as f:
        for line in f:
            if " - " in line and "events" in line:
                try:
                    time_str, rest = line.strip().split(" - ")
                    count = int(rest.split()[0])
                    time = datetime.fromisoformat(time_str)
                    times.append(time)
                    counts.append(count)
                except Exception as e:
                    print(f"[!] Failed to parse line in {filepath}: {line.strip()} ({e})")
    return times, counts

def plot_rates(filepaths, labels=None, output=None):
    plt.figure(figsize=(12, 6))
    for i, path in enumerate(filepaths):
        label = labels[i] if labels else os.path.basename(path)
        times, counts = parse_event_file(path)
        if times and counts:
            plt.plot(times, counts, marker='', label=label)
        else:
            print(f"[!] No valid data found in {path}, skipping...")

    plt.xlabel("Time")
    plt.ylabel("File per minute")
    plt.title("File Rate Comparison")
    plt.legend()
    plt.grid(True)
    plt.tight_layout()

    if output:
        plt.savefig(output)
        print(f"[✓] Plot saved to {output}")
    else:
        plt.show()

def main():
    parser = argparse.ArgumentParser(description="Plot event rates from multiple files.")
    parser.add_argument("files", nargs='+', help="Paths to event rate text files.")
    parser.add_argument("--labels", nargs='*', help="Optional custom labels for each file.")
    parser.add_argument("--output", help="Optional path to save plot image (e.g., output.png)")
    args = parser.parse_args()

    if args.labels and len(args.labels) != len(args.files):
        print("[✗] Number of labels must match number of files.")
        return

    plot_rates(args.files, args.labels, args.output)

if __name__ == "__main__":
    main()

