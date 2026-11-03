#!/usr/bin/env python3
"""
Convert ns-3 FlowMonitor XML output to CSV for P1/P2 KPI processing.
"""

from __future__ import annotations

import argparse
import csv
import xml.etree.ElementTree as ET
from pathlib import Path


def parse_ns_time(value: str) -> float:
    if value.endswith("ns"):
        return float(value[:-2]) * 1e-9
    raise ValueError(f"Unsupported ns-3 time value: {value}")


def main() -> int:
    parser = argparse.ArgumentParser(description="Convert FlowMonitor XML to CSV")
    parser.add_argument("--input", required=True, help="FlowMonitor XML path")
    parser.add_argument("--output", required=True, help="CSV output path")
    parser.add_argument("--rat", default="", help="Optional RAT label (lte|nr)")
    args = parser.parse_args()

    input_path = Path(args.input)
    output_path = Path(args.output)
    output_path.parent.mkdir(parents=True, exist_ok=True)

    root = ET.parse(input_path).getroot()
    classifier = root.find("Ipv4FlowClassifier")
    stats_root = root.find("FlowStats")
    if classifier is None or stats_root is None:
        raise RuntimeError("Invalid FlowMonitor XML: missing Ipv4FlowClassifier/FlowStats")

    flow_tuples = {}
    for flow in classifier.findall("Flow"):
        flow_id = int(flow.attrib["flowId"])
        flow_tuples[flow_id] = {
            "source_address": flow.attrib.get("sourceAddress", ""),
            "destination_address": flow.attrib.get("destinationAddress", ""),
            "source_port": int(flow.attrib.get("sourcePort", "0")),
            "destination_port": int(flow.attrib.get("destinationPort", "0")),
            "protocol": int(flow.attrib.get("protocol", "0")),
        }

    fieldnames = [
        "rat",
        "flow_id",
        "source_address",
        "destination_address",
        "source_port",
        "destination_port",
        "protocol",
        "tx_packets",
        "rx_packets",
        "lost_packets",
        "tx_bytes",
        "rx_bytes",
        "pdr_percent",
        "loss_percent",
        "mean_delay_ms",
        "mean_jitter_ms",
        "tx_offered_mbps",
        "goodput_mbps",
        "flow_duration_s",
    ]

    with output_path.open("w", newline="", encoding="utf-8") as fout:
        writer = csv.DictWriter(fout, fieldnames=fieldnames)
        writer.writeheader()

        for flow in stats_root.findall("Flow"):
            flow_id = int(flow.attrib["flowId"])
            tx_packets = int(flow.attrib.get("txPackets", "0"))
            rx_packets = int(flow.attrib.get("rxPackets", "0"))
            lost_packets = int(flow.attrib.get("lostPackets", "0"))
            tx_bytes = int(flow.attrib.get("txBytes", "0"))
            rx_bytes = int(flow.attrib.get("rxBytes", "0"))

            time_first_tx = parse_ns_time(flow.attrib.get("timeFirstTxPacket", "0ns"))
            time_last_tx = parse_ns_time(flow.attrib.get("timeLastTxPacket", "0ns"))
            time_first_rx = parse_ns_time(flow.attrib.get("timeFirstRxPacket", "0ns"))
            time_last_rx = parse_ns_time(flow.attrib.get("timeLastRxPacket", "0ns"))

            tx_duration = max(time_last_tx - time_first_tx, 0.0)
            rx_duration = max(time_last_rx - time_first_rx, 0.0)
            flow_duration = max(time_last_rx - time_first_tx, 0.0)

            delay_sum_s = parse_ns_time(flow.attrib.get("delaySum", "0ns"))
            jitter_sum_s = parse_ns_time(flow.attrib.get("jitterSum", "0ns"))
            mean_delay_ms = (delay_sum_s / rx_packets * 1e3) if rx_packets > 0 else 0.0
            mean_jitter_ms = (jitter_sum_s / max(rx_packets - 1, 1) * 1e3) if rx_packets > 1 else 0.0

            tx_offered_mbps = (tx_bytes * 8.0 / tx_duration / 1e6) if tx_duration > 0 else 0.0
            goodput_mbps = (rx_bytes * 8.0 / rx_duration / 1e6) if rx_duration > 0 else 0.0

            pdr_percent = (rx_packets / tx_packets * 100.0) if tx_packets > 0 else 0.0
            loss_percent = (lost_packets / tx_packets * 100.0) if tx_packets > 0 else 0.0

            row = {
                "rat": args.rat,
                "flow_id": flow_id,
                "tx_packets": tx_packets,
                "rx_packets": rx_packets,
                "lost_packets": lost_packets,
                "tx_bytes": tx_bytes,
                "rx_bytes": rx_bytes,
                "pdr_percent": round(pdr_percent, 6),
                "loss_percent": round(loss_percent, 6),
                "mean_delay_ms": round(mean_delay_ms, 6),
                "mean_jitter_ms": round(mean_jitter_ms, 6),
                "tx_offered_mbps": round(tx_offered_mbps, 6),
                "goodput_mbps": round(goodput_mbps, 6),
                "flow_duration_s": round(flow_duration, 6),
            }
            row.update(
                flow_tuples.get(
                    flow_id,
                    {
                        "source_address": "",
                        "destination_address": "",
                        "source_port": 0,
                        "destination_port": 0,
                        "protocol": 0,
                    },
                )
            )
            writer.writerow(row)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
