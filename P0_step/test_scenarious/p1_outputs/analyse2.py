import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# Load your CSV data (save the CSV portion to 'flow_stats.csv')
df = pd.read_csv('lte_s20_v5_seed1_flows.csv')

# Filter for high-volume flows (Flows 25 to 29)
subset = df[df['flow_id'].between(25, 29)].copy()

plt.figure(figsize=(10, 6))
x = np.arange(len(subset['flow_id']))
width = 0.35

# Plot bars
plt.bar(
    x - width / 2,
    subset['mean_delay_ms'],
    width,
    label='Mean Delay (ms)',
    color='#2b5c8f',
)
plt.bar(
    x + width / 2,
    subset['mean_jitter_ms'],
    width,
    label='Mean Jitter (ms)',
    color='#e07a5f',
)

plt.xlabel('Flow ID', fontweight='bold')
plt.ylabel('Time (ms)', fontweight='bold')
plt.title(
    'Delay and Jitter Comparison for Bulk Data Flows (Flows 25-29)',
    fontweight='bold',
)
plt.xticks(x, subset['flow_id'])
plt.legend()
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.tight_layout()

# Save and show
plt.savefig('grouped_delay_jitter_bar_chart.png', dpi=300)
plt.show()
