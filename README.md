# Data Communications Project 6

## LTE vs 5G NR for mixed IoT traffic

This project uses **ns-3** to compare LTE (LENA) and 5G NR (5G-LENA) when
both sensor devices and video devices use the network. The main things we
measure are delay, jitter, packet delivery, video goodput, packet loss, and
the total throughput of the cells.

The project is split into three stages:

- **P0_step:** the basic ns-3 setup and first demonstrations.
- **P1:** the common application traffic and logging used by both LTE and NR.
- **P2:** the first KPI results, comparisons, and extra test cases.

## Project settings

The simulations are based on the settings from the project brief:

- 3 base stations/cells in a triangular layout.
- Sensors send 128-byte UDP packets at 2 packets/second, with short bursts at
  10 packets/second.
- Video traffic uses UDP at 2 Mbps per video device.
- The normal simulation has a 5 second warm-up followed by 30 seconds of
  measurements.
- The main comparison uses 20 sensors and 5 video devices.
- LTE uses the LENA/EPC model. NR uses the 5G-LENA model when the NR module is
  available.

## P0: foundations

The P0 files are in [`P0_step/`](./P0_step/). This folder contains the ns-3
tree used for the project, including the simulator, modules, examples, build
files, and the project outputs.

The most useful P0 files are:

- [`test_scenarious/`](./P0_step/test_scenarious/) - the ns-3 working tree.
- [`p0_lte_lena_simple_epc.txt`](./P0_step/test_scenarious/p0_lte_lena_simple_epc.txt)
  - recorded LTE demonstration output.
- [`p0_5g_cttc_nr_demo.txt`](./P0_step/test_scenarious/p0_5g_cttc_nr_demo.txt)
  - recorded 5G NR demonstration output.
- [`output_cttc_nr_demo.txt`](./P0_step/test_scenarious/output_cttc_nr_demo.txt)
  - flow results from an NR demo run.
- [`Evidences/`](./P0_step/Evidences/) - LTE protocol statistics from the simulation,
  such as MAC, RLC, PDCP, PHY, SINR, and interference results.

The P0 demonstrations show that the simulation environment can be built and
that the LTE and NR examples can run. The standard ns-3 tree is included, so
many files under `test_scenarious/src/` and `test_scenarious/examples/` are
from ns-3 and are not project-specific.

## P1: traffic and logging

The P1 implementation is inside
[`P0_step/test_scenarious/`](./P0_step/test_scenarious/). The main scenario is
[`project6-p1-iot.cc`](./P0_step/test_scenarious/scratch/project6-p1-iot.cc).
It creates the sensor and video traffic and records FlowMonitor and RRC
events.

Important P1 files:

- [`scratch/project6-p1-iot.cc`](./P0_step/test_scenarious/scratch/project6-p1-iot.cc)
  - main LTE/NR scenario and traffic generator.
- [`p1_flowmon_to_csv.py`](./P0_step/test_scenarious/p1_flowmon_to_csv.py)
  - converts FlowMonitor XML files into easier-to-read CSV files.
- [`p1_p2_analyse.py`](./P0_step/test_scenarious/p1_outputs/p1_p2_analyse.py)
  - reads flow and RRC CSV files, calculates KPIs, and creates plots.
- [`p1_outputs/`](./P0_step/test_scenarious/p1_outputs/)
  - example FlowMonitor XML, flow CSV, RRC event CSV, and generated plots.
- [`p1_integrate_nr.sh`](./P0_step/test_scenarious/p1_integrate_nr.sh)
  - helper script for adding a compatible 5G-LENA NR module.

The CSV flow output includes transmitted and received packets, packet delivery
ratio, loss, mean delay, jitter, offered load, goodput, and flow duration.
The RRC output includes connection events, handover start/end events, and
handover failures.

## P2: results and analysis

The P2 results are in [`MIDTERM/P2/p2/`](./MIDTERM/P2/p2/). Each folder
contains KPI tables and, in most cases, the original logs and raw simulation
files in compressed archives.

| Folder | What it contains |
| --- | --- |
| [`baseline/`](./MIDTERM/P2/p2/baseline/) | Main LTE and NR comparison at 20 sensors and 5 video devices, using 5 seeds. |
| [`sizing/`](./MIDTERM/P2/p2/sizing/) | Tests with larger loads: `(20,5)`, `(50,10)`, and `(100,10)`. |
| [`iso/`](./MIDTERM/P2/p2/iso/) | Isolated sensor tests without video traffic. |
| [`diag/`](./MIDTERM/P2/p2/diag/) | Diagnostic runs used to check the simulation configuration. |
| [`demo/`](./MIDTERM/P2/p2/demo/) | Smaller demonstration results. |
| [`combined/`](./MIDTERM/P2/p2/combined/) | Combined KPI tables from several P2 runs. |

The main files in each results folder are:

- `kpi_summary.md` - readable summary of the calculated results.
- `kpi_runs.csv` - one row for each simulation run.
- `kpi_flows.csv` - flow-level measurements.
- `kpi_points.csv` - grouped KPI points used for comparisons.
- `*_flowmon.csv`, `*_rrc.csv`, `*_phy.csv`, `*_rx.csv`, `*_tx.csv`, and
  `*_ues.csv` - detailed per-run measurements.
- `logs.tar.gz` and `raw.tar.gz` - compressed copies of larger result files
  where available.

The most useful starting point for the results is
[`baseline/kpi_summary.md`](./MIDTERM/P2/p2/baseline/kpi_summary.md). In the
five-seed baseline, LTE has lower sensor delay and no sensor packet loss,
while the NR results improve when the NR configuration is fixed. The sizing
results also show that increasing the number of devices increases delay,
video loss, memory use, and simulation time.

## Running the project

The ns-3 commands are intended for Linux or WSL. From the repository root:

```bash
cd P0_step/test_scenarious
./ns3 configure --enable-examples --disable-werror
./ns3 build
```

To run the P0 examples:

```bash
./ns3 run lena-simple-epc
./ns3 run cttc-nr-demo
```

To build and run the P1 scenario for LTE:

```bash
python3 ns3 build project6-p1-iot
python3 ns3 run "project6-p1-iot --rat=lte --nSensors=20 --nVideo=5 --seed=1 --warmup=5 --simTime=30"
```

Then convert the FlowMonitor output to CSV:

```bash
python3 p1_flowmon_to_csv.py \
  --input p1_outputs/lte_s20_v5_seed1_flowmon.xml \
  --output p1_outputs/lte_s20_v5_seed1_flows.csv \
  --rat lte
```

The NR scenario needs a compatible 5G-LENA `nr` module. The repository
contains the NR result files, but a clean NR run may require installing the
correct version of 5G-LENA first.

## KPI meanings

- **Latency:** time taken by a packet to reach the receiver.
- **Jitter:** variation in packet delay.
- **PDR:** percentage of transmitted packets that arrive.
- **Goodput:** useful received video data per second.
- **Loss:** percentage of video packets that do not arrive.
- **Aggregate throughput:** total received traffic across the cells.
- **Handover events:** changes between cells while a UE is moving.

The current repository mainly covers the P0, P1, and P2 work. The complete
55-run experiment matrix and the final handover study are not represented by
one automatic command yet.
