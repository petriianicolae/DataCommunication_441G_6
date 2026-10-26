/*
 * Project 6 - P1 common app layer and logging scaffold.
 */

#include "ns3/applications-module.h"
#include "ns3/core-module.h"
#include "ns3/flow-monitor-module.h"
#include "ns3/internet-module.h"
#include "ns3/lte-module.h"
#include "ns3/mobility-module.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"

#include <algorithm>
#include <cctype>
#include <cmath>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <sstream>
#include <string>
#include <vector>

using namespace ns3;

NS_LOG_COMPONENT_DEFINE("Project6P1Iot");

namespace
{
std::ofstream g_rrcCsv;
std::string g_rat;

void
WriteRrcEvent(const std::string& event,
              const std::string& context,
              uint64_t imsi,
              uint16_t cellId,
              uint16_t rnti,
              int32_t targetCellId)
{
    if (!g_rrcCsv.is_open())
    {
        return;
    }
    g_rrcCsv << std::fixed << std::setprecision(6) << Simulator::Now().GetSeconds() << "," << g_rat << ","
             << event << "," << context << "," << imsi << "," << cellId << "," << rnti << ","
             << targetCellId << "\n";
}

void
NotifyConnectionEstablishedUe(std::string context, uint64_t imsi, uint16_t cellId, uint16_t rnti)
{
    WriteRrcEvent("UE_CONNECTION_ESTABLISHED", context, imsi, cellId, rnti, -1);
}

void
NotifyConnectionEstablishedEnb(std::string context, uint64_t imsi, uint16_t cellId, uint16_t rnti)
{
    WriteRrcEvent("ENB_CONNECTION_ESTABLISHED", context, imsi, cellId, rnti, -1);
}

void
NotifyHandoverStartUe(std::string context,
                      uint64_t imsi,
                      uint16_t cellId,
                      uint16_t rnti,
                      uint16_t targetCellId)
{
    WriteRrcEvent("UE_HANDOVER_START", context, imsi, cellId, rnti, targetCellId);
}

void
NotifyHandoverStartEnb(std::string context,
                       uint64_t imsi,
                       uint16_t cellId,
                       uint16_t rnti,
                       uint16_t targetCellId)
{
    WriteRrcEvent("ENB_HANDOVER_START", context, imsi, cellId, rnti, targetCellId);
}

void
NotifyHandoverEndOkUe(std::string context, uint64_t imsi, uint16_t cellId, uint16_t rnti)
{
    WriteRrcEvent("UE_HANDOVER_END_OK", context, imsi, cellId, rnti, -1);
}

void
NotifyHandoverEndOkEnb(std::string context, uint64_t imsi, uint16_t cellId, uint16_t rnti)
{
    WriteRrcEvent("ENB_HANDOVER_END_OK", context, imsi, cellId, rnti, -1);
}

void
NotifyHandoverFailure(std::string context, uint64_t imsi, uint16_t cellId, uint16_t rnti)
{
    WriteRrcEvent("HANDOVER_FAILURE", context, imsi, cellId, rnti, -1);
}

class SensorBurstApplication : public Application
{
  public:
    SensorBurstApplication(Ipv4Address remoteAddress,
                           uint16_t remotePort,
                           uint32_t packetSizeBytes,
                           double baseRateHz,
                           double burstRateHz,
                           double burstDurationSeconds,
                           double burstPeriodSeconds)
        : m_remoteAddress(remoteAddress),
          m_remotePort(remotePort),
          m_packetSizeBytes(packetSizeBytes),
          m_baseRateHz(baseRateHz),
          m_burstRateHz(burstRateHz),
          m_burstDurationSeconds(burstDurationSeconds),
          m_burstPeriodSeconds(burstPeriodSeconds)
    {
    }

  private:
    void
    StartApplication() override
    {
        if (!m_socket)
        {
            m_socket = Socket::CreateSocket(GetNode(), UdpSocketFactory::GetTypeId());
            m_socket->Connect(InetSocketAddress(m_remoteAddress, m_remotePort));
        }
        m_startTime = Simulator::Now();
        SendPacketAndScheduleNext();
    }

    void
    StopApplication() override
    {
        if (m_sendEvent.IsRunning())
        {
            Simulator::Cancel(m_sendEvent);
        }
        if (m_socket)
        {
            m_socket->Close();
        }
    }

    void
    SendPacketAndScheduleNext()
    {
        Ptr<Packet> packet = Create<Packet>(m_packetSizeBytes);
        m_socket->Send(packet);

        const double elapsed = (Simulator::Now() - m_startTime).GetSeconds();
        const double phase = std::fmod(elapsed, m_burstPeriodSeconds);
        const double rateHz = phase < m_burstDurationSeconds ? m_burstRateHz : m_baseRateHz;
        const double intervalSeconds = 1.0 / rateHz;
        m_sendEvent = Simulator::Schedule(Seconds(intervalSeconds),
                                          &SensorBurstApplication::SendPacketAndScheduleNext,
                                          this);
    }

    Ptr<Socket> m_socket;
    Ipv4Address m_remoteAddress;
    uint16_t m_remotePort{0};
    uint32_t m_packetSizeBytes{128};
    double m_baseRateHz{2.0};
    double m_burstRateHz{10.0};
    double m_burstDurationSeconds{3.0};
    double m_burstPeriodSeconds{30.0};
    Time m_startTime;
    EventId m_sendEvent;
};

void
InstallLteRrcAndHandoverTracing()
{
    Config::ConnectFailSafe("/NodeList/*/DeviceList/*/LteEnbRrc/ConnectionEstablished",
                            MakeCallback(&NotifyConnectionEstablishedEnb));
    Config::ConnectFailSafe("/NodeList/*/DeviceList/*/LteUeRrc/ConnectionEstablished",
                            MakeCallback(&NotifyConnectionEstablishedUe));
    Config::ConnectFailSafe("/NodeList/*/DeviceList/*/LteEnbRrc/HandoverStart",
                            MakeCallback(&NotifyHandoverStartEnb));
    Config::ConnectFailSafe("/NodeList/*/DeviceList/*/LteUeRrc/HandoverStart",
                            MakeCallback(&NotifyHandoverStartUe));
    Config::ConnectFailSafe("/NodeList/*/DeviceList/*/LteEnbRrc/HandoverEndOk",
                            MakeCallback(&NotifyHandoverEndOkEnb));
    Config::ConnectFailSafe("/NodeList/*/DeviceList/*/LteUeRrc/HandoverEndOk",
                            MakeCallback(&NotifyHandoverEndOkUe));
    Config::ConnectFailSafe("/NodeList/*/DeviceList/*/LteEnbRrc/HandoverFailureNoPreamble",
                            MakeCallback(&NotifyHandoverFailure));
    Config::ConnectFailSafe("/NodeList/*/DeviceList/*/LteEnbRrc/HandoverFailureMaxRach",
                            MakeCallback(&NotifyHandoverFailure));
    Config::ConnectFailSafe("/NodeList/*/DeviceList/*/LteEnbRrc/HandoverFailureLeaving",
                            MakeCallback(&NotifyHandoverFailure));
    Config::ConnectFailSafe("/NodeList/*/DeviceList/*/LteEnbRrc/HandoverFailureJoining",
                            MakeCallback(&NotifyHandoverFailure));
}

std::vector<Vector>
BuildHexTriadSitePositions(double interSiteDistance)
{
    return {{0.0, 0.0, 30.0},
            {interSiteDistance, 0.0, 30.0},
            {interSiteDistance / 2.0, interSiteDistance * std::sqrt(3.0) / 2.0, 30.0}};
}

std::vector<Vector>
BuildUePositions(uint32_t nUes,
                 const std::vector<Vector>& sitePositions,
                 double maxRadiusMeters,
                 int64_t firstStream)
{
    Ptr<UniformRandomVariable> angleRv = CreateObject<UniformRandomVariable>();
    Ptr<UniformRandomVariable> radiusRv = CreateObject<UniformRandomVariable>();
    angleRv->SetAttribute("Min", DoubleValue(0.0));
    angleRv->SetAttribute("Max", DoubleValue(2.0 * M_PI));
    radiusRv->SetAttribute("Min", DoubleValue(0.0));
    radiusRv->SetAttribute("Max", DoubleValue(1.0));
    angleRv->SetStream(firstStream);
    radiusRv->SetStream(firstStream + 1);

    std::vector<Vector> positions;
    positions.reserve(nUes);
    for (uint32_t i = 0; i < nUes; ++i)
    {
        const Vector& site = sitePositions.at(i % sitePositions.size());
        const double theta = angleRv->GetValue();
        const double radius = std::sqrt(radiusRv->GetValue()) * maxRadiusMeters;
        positions.emplace_back(site.x + radius * std::cos(theta), site.y + radius * std::sin(theta), 1.5);
    }
    return positions;
}
} // namespace

int
main(int argc, char* argv[])
{
    std::string rat = "lte";
    uint32_t nSensors = 20;
    uint32_t nVideo = 5;
    uint32_t seed = 1;
    double simTime = 30.0;
    double warmup = 5.0;
    double interSiteDistance = 500.0;
    std::string outputDir = "p1_outputs";

    CommandLine cmd(__FILE__);
    cmd.AddValue("rat", "Radio access technology: lte|nr", rat);
    cmd.AddValue("nSensors", "Number of sensor UEs", nSensors);
    cmd.AddValue("nVideo", "Number of video UEs", nVideo);
    cmd.AddValue("seed", "RNG run/seed identifier", seed);
    cmd.AddValue("simTime", "Measurement simulation time in seconds", simTime);
    cmd.AddValue("warmup", "Warm-up time in seconds", warmup);
    cmd.AddValue("outputDir", "Output directory for CSV/XML files", outputDir);
    cmd.Parse(argc, argv);

    std::transform(rat.begin(), rat.end(), rat.begin(), ::tolower);
    if (rat != "lte")
    {
        NS_ABORT_MSG("This repository checkout does not include 5G-LENA (nr) sources. "
                     "Integrate a compatible nr module release first, then use --rat=nr.");
    }

    g_rat = rat;
    std::filesystem::create_directories(outputDir);
    std::ostringstream runTag;
    runTag << rat << "_s" << nSensors << "_v" << nVideo << "_seed" << seed;
    const std::string prefix = outputDir + "/" + runTag.str();
    const std::string rrcCsvPath = prefix + "_rrc_events.csv";
    const std::string flowXmlPath = prefix + "_flowmon.xml";

    g_rrcCsv.open(rrcCsvPath, std::ios::out | std::ios::trunc);
    g_rrcCsv << "time_s,rat,event,context,imsi,cell_id,rnti,target_cell_id\n";

    RngSeedManager::SetSeed(1);
    RngSeedManager::SetRun(seed);

    Ptr<LteHelper> lteHelper = CreateObject<LteHelper>();
    Ptr<PointToPointEpcHelper> epcHelper = CreateObject<PointToPointEpcHelper>();
    lteHelper->SetEpcHelper(epcHelper);
    lteHelper->SetSchedulerType("ns3::PfFfMacScheduler");
    lteHelper->SetEnbDeviceAttribute("DlBandwidth", UintegerValue(100));
    lteHelper->SetEnbDeviceAttribute("UlBandwidth", UintegerValue(100));

    Ptr<Node> pgw = epcHelper->GetPgwNode();
    NodeContainer remoteHostContainer;
    remoteHostContainer.Create(1);
    Ptr<Node> remoteHost = remoteHostContainer.Get(0);
    InternetStackHelper internet;
    internet.Install(remoteHostContainer);

    PointToPointHelper p2ph;
    p2ph.SetDeviceAttribute("DataRate", DataRateValue(DataRate("10Gb/s")));
    p2ph.SetDeviceAttribute("Mtu", UintegerValue(1500));
    p2ph.SetChannelAttribute("Delay", TimeValue(MilliSeconds(10)));
    NetDeviceContainer internetDevices = p2ph.Install(pgw, remoteHost);
    Ipv4AddressHelper ipv4h;
    ipv4h.SetBase("1.0.0.0", "255.0.0.0");
    Ipv4InterfaceContainer internetIpIfaces = ipv4h.Assign(internetDevices);
    Ipv4Address remoteHostAddr = internetIpIfaces.GetAddress(1);

    Ipv4StaticRoutingHelper ipv4RoutingHelper;
    Ptr<Ipv4StaticRouting> remoteHostStaticRouting =
        ipv4RoutingHelper.GetStaticRouting(remoteHost->GetObject<Ipv4>());
    remoteHostStaticRouting->AddNetworkRouteTo(Ipv4Address("7.0.0.0"), Ipv4Mask("255.0.0.0"), 1);

    NodeContainer enbNodes;
    enbNodes.Create(3);
    const uint32_t totalUes = nSensors + nVideo;
    NodeContainer ueNodes;
    ueNodes.Create(totalUes);

    MobilityHelper mobility;
    Ptr<ListPositionAllocator> enbPosAlloc = CreateObject<ListPositionAllocator>();
    const auto sitePositions = BuildHexTriadSitePositions(interSiteDistance);
    for (const auto& p : sitePositions)
    {
        enbPosAlloc->Add(p);
    }
    mobility.SetPositionAllocator(enbPosAlloc);
    mobility.SetMobilityModel("ns3::ConstantPositionMobilityModel");
    mobility.Install(enbNodes);

    Ptr<ListPositionAllocator> uePosAlloc = CreateObject<ListPositionAllocator>();
    const auto uePositions = BuildUePositions(totalUes, sitePositions, 120.0, 1000);
    for (const auto& p : uePositions)
    {
        uePosAlloc->Add(p);
    }
    mobility.SetPositionAllocator(uePosAlloc);
    mobility.SetMobilityModel("ns3::ConstantPositionMobilityModel");
    mobility.Install(ueNodes);

    NetDeviceContainer enbLteDevs = lteHelper->InstallEnbDevice(enbNodes);
    NetDeviceContainer ueLteDevs = lteHelper->InstallUeDevice(ueNodes);

    internet.Install(ueNodes);
    Ipv4InterfaceContainer ueIpIface = epcHelper->AssignUeIpv4Address(NetDeviceContainer(ueLteDevs));
    for (uint32_t u = 0; u < ueNodes.GetN(); ++u)
    {
        Ptr<Node> ueNode = ueNodes.Get(u);
        Ptr<Ipv4StaticRouting> ueStaticRouting =
            ipv4RoutingHelper.GetStaticRouting(ueNode->GetObject<Ipv4>());
        ueStaticRouting->SetDefaultRoute(epcHelper->GetUeDefaultGatewayAddress(), 1);
    }

    lteHelper->AttachToClosestEnb(ueLteDevs, enbLteDevs);

    NetDeviceContainer allLteDevs;
    allLteDevs.Add(enbLteDevs);
    allLteDevs.Add(ueLteDevs);
    lteHelper->AssignStreams(allLteDevs, 2000, true);

    ApplicationContainer apps;
    ApplicationContainer sinks;
    const Time appStart = Seconds(warmup);
    const Time appStop = Seconds(warmup + simTime);
    const Time sinkStart = Seconds(0.1);

    uint16_t sensorPort = 5000;
    for (uint32_t i = 0; i < nSensors; ++i)
    {
        PacketSinkHelper sink("ns3::UdpSocketFactory",
                              InetSocketAddress(Ipv4Address::GetAny(), sensorPort));
        sinks.Add(sink.Install(remoteHost));

        Ptr<SensorBurstApplication> sensorApp = CreateObject<SensorBurstApplication>(remoteHostAddr,
                                                                                      sensorPort,
                                                                                      128,
                                                                                      2.0,
                                                                                      10.0,
                                                                                      3.0,
                                                                                      30.0);
        ueNodes.Get(i)->AddApplication(sensorApp);
        sensorApp->SetStartTime(appStart);
        sensorApp->SetStopTime(appStop);
        apps.Add(sensorApp);
        ++sensorPort;
    }

    uint16_t videoPort = 9000;
    for (uint32_t i = 0; i < nVideo; ++i)
    {
        const uint32_t ueIdx = nSensors + i;
        PacketSinkHelper sink("ns3::UdpSocketFactory", InetSocketAddress(Ipv4Address::GetAny(), videoPort));
        sinks.Add(sink.Install(ueNodes.Get(ueIdx)));

        OnOffHelper video("ns3::UdpSocketFactory",
                          InetSocketAddress(ueIpIface.GetAddress(ueIdx), videoPort));
        video.SetAttribute("PacketSize", UintegerValue(1200));
        video.SetAttribute("DataRate", DataRateValue(DataRate("2Mbps")));
        video.SetAttribute("OnTime", StringValue("ns3::ConstantRandomVariable[Constant=1]"));
        video.SetAttribute("OffTime", StringValue("ns3::ConstantRandomVariable[Constant=0]"));
        apps.Add(video.Install(remoteHost));
        ++videoPort;
    }

    sinks.Start(sinkStart);
    sinks.Stop(appStop + MilliSeconds(100));
    apps.Start(appStart);
    apps.Stop(appStop);

    InstallLteRrcAndHandoverTracing();

    FlowMonitorHelper flowmonHelper;
    Ptr<FlowMonitor> monitor = flowmonHelper.InstallAll();

    Simulator::Stop(appStop + Seconds(0.5));
    Simulator::Run();

    monitor->CheckForLostPackets();
    monitor->SerializeToXmlFile(flowXmlPath, true, true);

    if (g_rrcCsv.is_open())
    {
        g_rrcCsv.close();
    }

    Simulator::Destroy();
    return 0;
}
