import xml.etree.ElementTree as ET
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

def parse_flowmon_xml(xml_file_path):
    """Parses ns-3 FlowMonitor XML and returns a structured DataFrame."""
    tree = ET.parse(xml_file_path)
    root = tree.getroot()

    # 1. Extract Classifier mappings (IPs, Ports, Protocol)
    classifier = root.find('Ipv4FlowClassifier')
    flows_meta = {}
    if classifier is not None:
        for flow in classifier.findall('Flow'):
            f_id = int(flow.attrib['flowId'])
            flows_meta[f_id] = {
                'src_addr': flow.attrib.get('sourceAddress', ''),
                'dst_addr': flow.attrib.get('destinationAddress', ''),
                'src_port': int(flow.attrib.get('sourcePort', '0')),
                'dst_port': int(flow.attrib.get('destinationPort', '0')),
                'protocol': int(flow.attrib.get('protocol', '0'))
            }

    # 2. Extract Flow Performance Statistics
    stats = root.find('FlowStats')
    flow_records = []
    if stats is not None:
        for flow in stats.findall('Flow'):
            f_id = int(flow.attrib['flowId'])
            tx_p = int(flow.attrib.get('txPackets', '0'))
            rx_p = int(flow.attrib.get('rxPackets', '0'))
            lost_p = int(flow.attrib.get('lostPackets', '0'))
            tx_b = int(flow.attrib.get('txBytes', '0'))
            rx_b = int(flow.attrib.get('rxBytes', '0'))
            
            # Convert timestamps from nanoseconds (ns) to seconds
            t_first_tx = float(flow.attrib.get('timeFirstTxPacket', '0ns').replace('ns','')) * 1e-9
            t_last_tx = float(flow.attrib.get('timeLastTxPacket', '0ns').replace('ns','')) * 1e-9
            t_first_rx = float(flow.attrib.get('timeFirstRxPacket', '0ns').replace('ns','')) * 1e-9
            t_last_rx = float(flow.attrib.get('timeLastRxPacket', '0ns').replace('ns','')) * 1e-9
            
            delay_sum_s = float(flow.attrib.get('delaySum', '0ns').replace('ns','')) * 1e-9
            jitter_sum_s = float(flow.attrib.get('jitterSum', '0ns').replace('ns','')) * 1e-9
            
            rx_duration = max(t_last_rx - t_first_rx, 0.0)
            
            mean_delay_ms = (delay_sum_s / rx_p * 1e3) if rx_p > 0 else 0.0
            mean_jitter_ms = (jitter_sum_s / max(rx_p - 1, 1) * 1e3) if rx_p > 1 else 0.0
            goodput_mbps = (rx_b * 8.0 / rx_duration / 1e6) if rx_duration > 0 else 0.0
            pdr_percent = (rx_p / tx_p * 100.0) if tx_p > 0 else 0.0
            
            meta = flows_meta.get(f_id, {})
            flow_records.append({
                'flow_id': f_id,
                'src_addr': meta.get('src_addr', ''),
                'dst_addr': meta.get('dst_addr', ''),
                'src_port': meta.get('src_port', 0),
                'dst_port': meta.get('dst_port', 0),
                'tx_packets': tx_p,
                'rx_packets': rx_p,
                'lost_packets': lost_p,
                'pdr_percent': pdr_percent,
                'mean_delay_ms': mean_delay_ms,
                'mean_jitter_ms': mean_jitter_ms,
                'goodput_mbps': goodput_mbps
            })

    df = pd.DataFrame(flow_records)
    
    # Traffic classification rule based on destination port assignment
    def classify_traffic(port):
        if 5000 <= port < 6000:
            return 'Sensor Traffic'
        elif 9000 <= port < 10000:
            return 'Video Traffic'
        elif port == 2123:
            return 'GTP-U Control'
        else:
            return 'Other'

    df['traffic_type'] = df['dst_port'].apply(classify_traffic)
    return df


def parse_rrc_csv(rrc_file_path):
    """Parses RRC Events CSV and aggregates handover and connection metrics."""
    df_rrc = pd.read_csv(rrc_file_path)
    summary = {
        'total_events': len(df_rrc),
        'ue_connections': (df_rrc['event'] == 'UE_CONNECTION_ESTABLISHED').sum(),
        'enb_connections': (df_rrc['event'] == 'ENB_CONNECTION_ESTABLISHED').sum(),
        'handovers_started': df_rrc['event'].str.contains('HANDOVER_START', na=False).sum(),
        'handovers_completed': df_rrc['event'].str.contains('HANDOVER_END_OK', na=False).sum(),
        'handover_failures': df_rrc['event'].str.contains('HANDOVER_FAILURE', na=False).sum()
    }
    return df_rrc, summary


def generate_kpi_plots(df_flows, output_img='p1_p2_kpi_plots.png'):
    """Generates visualization charts for Midterm/P2 presentation requirements."""
    fig, axes = plt.subplots(1, 2, figsize=(14, 5))

    # Filter out core infrastructure control flows for user-plane analysis
    user_flows = df_flows[df_flows['traffic_type'].isin(['Sensor Traffic', 'Video Traffic'])]

    # Chart 1: Mean Latency Comparison across Traffic Types
    sensor_delays = user_flows[user_flows['traffic_type'] == 'Sensor Traffic']['mean_delay_ms']
    video_delays = user_flows[user_flows['traffic_type'] == 'Video Traffic']['mean_delay_ms']

    axes[0].boxplot([sensor_delays, video_delays], labels=['Sensor Traffic', 'Video Traffic'], patch_artist=True)
    axes[0].set_title('End-to-End Latency Distribution (ms)')
    axes[0].set_ylabel('Latency (ms)')
    axes[0].grid(True, linestyle='--', alpha=0.6)

    # Chart 2: PDR & Goodput Summary
    summary = user_flows.groupby('traffic_type').agg(
        avg_pdr=('pdr_percent', 'mean'),
        total_goodput=('goodput_mbps', 'sum')
    )

    bars = axes[1].bar(summary.index, summary['total_goodput'], color=['#2ca02c', '#1f77b4'])
    axes[1].set_title('Aggregate Goodput by Traffic Type (Mbps)')
    axes[1].set_ylabel('Goodput (Mbps)')
    axes[1].grid(True, linestyle='--', alpha=0.6)

    for bar in bars:
        yval = bar.get_height()
        axes[1].text(bar.get_x() + bar.get_width()/2.0, yval + 0.1, f'{yval:.2f} Mbps', ha='center', va='bottom')

    plt.tight_layout()
    plt.savefig(output_img, dpi=300)
    plt.close()
    print(f"[+] Plots successfully saved to '{output_img}'")


if __name__ == '__main__':
    # 1. Interpret FlowMonitor XML
    df_flows = parse_flowmon_xml('lte_s20_v5_seed1_flowmon.xml')
    print("=== FLOWMONITOR KPI SUMMARY ===")
    flow_summary = df_flows.groupby('traffic_type').agg(
        flow_count=('flow_id', 'count'),
        avg_pdr=('pdr_percent', 'mean'),
        mean_delay_ms=('mean_delay_ms', 'mean'),
        p95_delay_ms=('mean_delay_ms', lambda x: np.percentile(x, 95)),
        mean_jitter_ms=('mean_jitter_ms', 'mean'),
        total_goodput_mbps=('goodput_mbps', 'sum')
    )
    print(flow_summary.to_string())

    # 2. Interpret RRC Events CSV
    print("\n=== RRC CONTROL PLANE SUMMARY ===")
    df_rrc, rrc_summary = parse_rrc_csv('lte_s20_v5_seed1_rrc_events.csv')
    for k, v in rrc_summary.items():
        print(f"  {k}: {v}")

    # 3. Generate Visualizations
    generate_kpi_plots(df_flows)
