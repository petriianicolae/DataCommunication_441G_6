# Data Communication Project 6



## P0 roadmap 'pdf' file
A document covering the roadmap for the 'P0' stage is uploaded in the 'main' tree. 

## LTE versus 5G NR for mixed IoT traffic

This repository contains the ns-3 project material for Project 6 from the
Data Communications group-project brief. The project compares LTE (LENA) and
5G NR (5G-LENA) for mixed IoT traffic and records the resulting network
statistics.

The work was completed within P0 Foundations. We have verified that the ns-3 environment and the LTE/5G demonstration scenarios can
be built and executed before collecting the protocol statistics.

## What is included

The repository has two important parts:

| Location | Purpose |
| --- | --- |
| [`test_scenarious/`](./test_scenarious/) | ns-3 source tree used for the simulations, including the build system, modules, examples, and scratch area |
| [`Evidences/`](./Evidences/) | Collected LTE statistics used as evidence for the simulation and analysis |
| [`test_scenarious/p0_5g_cttc_nr_demo.txt`](./test_scenarious/p0_5g_cttc_nr_demo.txt) | P0 5G/CTTC demo output |
| [`test_scenarious/output_cttc_nr_demo.txt`](./test_scenarious/output_cttc_nr_demo.txt) | Recorded flow-level output from the demo |
| [`test_scenarious/p0_lte_lena_simple_epc.txt`](./test_scenarious/p0_lte_lena_simple_epc.txt) | Reserved file for the LTE P0 output |
| [`LICENSE`](./LICENSE) | License for the repository |

The `test_scenarious` directory is based on ns-3. It contains the simulator
framework and standard ns-3 modules, not only files written for this project.
The project-specific evidence is therefore kept in the root `Evidences`
directory and in the P0 output files listed above.

## Evidence files

The files in [`Evidences/`](./Evidences/) are text tables exported from ns-3
traces. Their first line identifies the measured fields and the following
lines contain the samples.

### Downlink

- [`DlMacStats.txt`](./Evidences/DlMacStats.txt): downlink MAC scheduling and
  transport-block statistics.
- [`DlPdcpStats.txt`](./Evidences/DlPdcpStats.txt): downlink PDCP packet
  statistics.
- [`DlRlcStats.txt`](./Evidences/DlRlcStats.txt): downlink RLC statistics.
- [`DlRxPhyStats.txt`](./Evidences/DlRxPhyStats.txt): downlink PHY reception
  statistics.
- [`DlTxPhyStats.txt`](./Evidences/DlTxPhyStats.txt): downlink PHY
  transmission statistics.

### Uplink

- [`UlInterferenceStats.txt`](./Evidences/UlInterferenceStats.txt): uplink
  interference measurements by cell and time.
- [`UlMacStats.txt`](./Evidences/UlMacStats.txt): uplink MAC scheduling and
  transport-block statistics.
- [`UlPdcpStats.txt`](./Evidences/UlPdcpStats.txt): uplink PDCP packet
  statistics.
- [`UlRlcStats.txt`](./Evidences/UlRlcStats.txt): uplink RLC statistics.
- [`UlRxPhyStats.txt`](./Evidences/UlRxPhyStats.txt): uplink PHY reception
  statistics.
- [`UlSinrStats.txt`](./Evidences/UlSinrStats.txt): uplink SINR measurements.
- [`UlTxPhyStats.txt`](./Evidences/UlTxPhyStats.txt): uplink PHY
  transmission statistics.

For a quick flow-level result, open
[`output_cttc_nr_demo.txt`](./test_scenarious/output_cttc_nr_demo.txt). It
reports two UDP flows, offered load, received bytes, throughput, mean delay,
mean jitter, and received packets. The recorded values are:

- Flow 1 throughput: **10.236587 Mbps**
- Flow 1 mean delay: **0.276044 ms**
- Flow 2 throughput: **102.229333 Mbps**
- Flow 2 mean delay: **0.900967 ms**
- Mean flow throughput: **56.232960 Mbps**
- Mean flow delay: **0.588505 ms**

These values are recorded evidence from a demo run. They are not presented as
the final statistical result of the complete Project 6 matrix.

## How the files are organised

Inside [`test_scenarious/`](./test_scenarious/), the most relevant directories
are:

- `src/`: ns-3 modules, including LTE support under `src/lte/`.
- `examples/`: standard ns-3 examples.
- `scratch/`: local scratch simulations and their CMake configuration.
- `bindings/`: Python bindings.
- `doc/`: ns-3 documentation sources.
- `build-support/`: CMake and build helper files.
- `testpy-output/`: ns-3 test-run output.

The root-level `Ul*.txt` files in `test_scenarious/` are additional copies of
uplink output. The authoritative evidence set for marking is the one in
[`Evidences/`](./Evidences/).

## Building and running the ns-3 tree

Run these commands from the `test_scenarious` directory on Linux or WSL:

```bash
cd test_scenarious
./ns3 configure
./ns3 build
```

To run an installed ns-3 example, use:

```bash
./ns3 run <example-name>
```

For the P0 checks associated with this project, the expected demonstration
paths are:

```bash
./ns3 run lena-simple-epc
./ns3 run cttc-nr-demo
```

The exact second command requires a compatible 5G-LENA `nr` module and the
ns-3 version required by that release. The current repository contains the
ns-3 base tree and recorded P0 outputs; it does **not** contain a separate
`src/nr` 5G-LENA module. Therefore, a clean reproduction of the NR command
requires installing or integrating a compatible 5G-LENA release first.

On Windows, use WSL or another Linux environment for the commands above.
The checked-in P0 output files can still be read directly from Windows.

## Relation to the Project 6 requirements

The assignment defines the following comparison:

- LTE using LENA/EPC versus 5G NR using 5G-LENA.
- Mixed sensor and video traffic.
- Sensor latency, jitter, packet-delivery ratio, video goodput/loss, and
  aggregate cell throughput.
- A mobility/handover comparison between LTE and NR.

The mandatory matrix in the brief contains 55 runs: the load matrix, the NR
parameter sweeps, and the handover comparison. The material currently checked
in this repository documents the P0 foundation and collected protocol
statistics. It should not be confused with a claim that all 55 runs, five
seeds per point, confidence intervals, or the complete handover matrix are
already automated here.


## Current limitations

- The repository has no single command that regenerates every evidence file.
- The complete Project 6 55-run matrix and confidence-interval analysis are
  not included in the current checkout.

