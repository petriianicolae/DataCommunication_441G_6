import xml.etree.ElementTree as ET
import matplotlib.pyplot as plt
import numpy as np

# Load your raw XML file
tree = ET.parse('lte_s20_v5_seed1_flowmon.xml')
root = tree.getroot()

plt.figure(figsize=(10, 6))

# Loop through selected flows (e.g., bulk flows 25 through 29)
target_flows = {'25', '26', '27', '28', '29'}

for flow in root.findall('.//Flow'):
  flow_id = flow.get('flowId')
  if flow_id in target_flows:
    delays = []
    # Extract histogram bins
    for bin_elem in flow.findall('.//delayHistogram/bin'):
      start = float(bin_elem.get('start'))
      width = float(bin_elem.get('width'))
      count = int(bin_elem.get('count'))

      # Reconstruct individual sample points from bin centers
      bin_center = start + (width / 2.0)
      delays.extend([bin_center] * count)

    if delays:
      delays = np.sort(np.array(delays))
      # Compute empirical CDF values
      cdf = np.arange(1, len(delays) + 1) / len(delays)

      # Convert seconds to milliseconds for clarity
      plt.plot(
          delays * 1000,
          cdf,
          linewidth=2,
          label=f'Flow {flow_id}',
      )

plt.xlabel('Delay (ms)', fontweight='bold')
plt.ylabel('CDF (Cumulative Probability)', fontweight='bold')
plt.title('Packet Delay CDF for Bulk Data Flows', fontweight='bold')
plt.legend(loc='lower right')
plt.grid(True, linestyle='--', alpha=0.6)
plt.tight_layout()

# Save and show
plt.savefig('delay_cdf_plot.png', dpi=300)
plt.show()
