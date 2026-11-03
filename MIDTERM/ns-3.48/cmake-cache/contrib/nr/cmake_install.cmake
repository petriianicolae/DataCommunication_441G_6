# Install script for directory: /home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libns3.48-nr-optimized.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libns3.48-nr-optimized.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libns3.48-nr-optimized.so"
         RPATH "/usr/local/lib:\$ORIGIN/:\$ORIGIN/../lib:/usr/local/lib64:\$ORIGIN/:\$ORIGIN/../lib64")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/build/lib/libns3.48-nr-optimized.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libns3.48-nr-optimized.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libns3.48-nr-optimized.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libns3.48-nr-optimized.so"
         OLD_RPATH "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/build/lib:::::::::::::::"
         NEW_RPATH "/usr/local/lib:\$ORIGIN/:\$ORIGIN/../lib:/usr/local/lib64:\$ORIGIN/:\$ORIGIN/../lib64")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libns3.48-nr-optimized.so")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/ns3" TYPE FILE FILES
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/beamforming-helper-base.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/cc-bwp-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/file-scenario-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/grid-scenario-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/hexagonal-grid-scenario-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/ideal-beamforming-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/node-distribution-scenario-interface.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/nr-bearer-stats-calculator.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/nr-bearer-stats-connector.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/nr-bearer-stats-simple.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/nr-channel-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/nr-epc-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/nr-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/nr-mac-rx-trace.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/nr-mac-scheduling-stats.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/nr-no-backhaul-epc-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/nr-phy-rx-trace.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/nr-point-to-point-epc-helper-base.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/nr-point-to-point-epc-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/nr-radio-environment-map-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/nr-spectrum-value-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/nr-stats-calculator.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/realistic-beamforming-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/scenario-parameters.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/helper/three-gpp-ftp-m1-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/bandwidth-part-gnb.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/bandwidth-part-ue.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/beam-id.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/beam-manager.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/beamforming-vector.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/bwp-manager-algorithm.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/bwp-manager-gnb.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/bwp-manager-ue.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/ideal-beamforming-algorithm.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/lena-error-model.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-a2-a4-rsrp-handover-algorithm.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-a3-rsrp-handover-algorithm.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-amc.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-anr-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-anr.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-as-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-asn1-header.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-cb-two-port.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-cb-type-one-sp.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-cb-type-one.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-ccm-mac-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-ccm-rrc-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-ch-access-manager.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-chunk-processor.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-common.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-component-carrier.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-control-messages.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-csi-rs-filter.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-device-registry.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-eesm-cc-t1.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-eesm-cc-t2.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-eesm-cc.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-eesm-error-model.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-eesm-ir-t1.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-eesm-ir-t2.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-eesm-ir.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-eesm-t1.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-eesm-t2.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-epc-gnb-application.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-epc-gnb-s1-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-epc-gtpc-header.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-epc-gtpu-header.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-epc-mme-application.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-epc-pgw-application.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-epc-s11-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-epc-s1ap-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-epc-sgw-application.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-epc-ue-nas.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-epc-x2-header.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-epc-x2-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-epc-x2.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-error-model.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-fh-control.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-fh-phy-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-fh-sched-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-gnb-cmac-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-gnb-component-carrier-manager.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-gnb-cphy-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-gnb-mac.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-gnb-net-device.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-gnb-phy.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-gnb-rrc.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-handover-algorithm.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-handover-management-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-harq-phy.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-initial-association.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-interference-base.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-interference.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-lte-amc.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-lte-mi-error-model.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-csched-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-harq-process.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-harq-vector.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-header-fs-dl.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-header-fs-ul.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-header-fs.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-header-vs-dl.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-header-vs-ul.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-header-vs.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-pdu-info.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-sched-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-cqi-management.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-harq-rr.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-lc-alg.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-lc-qos.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-lc-rr.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-lcg.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-ns3.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-ofdma-mr.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-ofdma-pf.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-ofdma-qos.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-ofdma-rr.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-ofdma-symbol-per-beam.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-ofdma-random.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-ofdma.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-srs-default.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-srs.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-tdma-mr.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-tdma-pf.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-tdma-qos.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-tdma-rr.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-tdma-random.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-tdma.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-ue-info-mr.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-ue-info-pf.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-ue-info-qos.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-ue-info-rr.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler-ue-info.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-scheduler.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mac-short-bsr-ce.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mcs-tables.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mimo-chunk-processor.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mimo-matrices.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-mimo-signal.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-net-device.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-no-op-component-carrier-manager.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-no-op-handover-algorithm.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-pdcp-header.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-pdcp-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-pdcp-tag.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-pdcp.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-phy-mac-common.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-phy-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-phy-tag.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-phy.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-pm-search-fast.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-pm-search-full.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-pm-search-ideal.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-pm-search-sasaoka.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-pm-search.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-qos-flow-tag.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-qos-flow.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-qos-rule.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-qos-rule-classifier.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-radio-bearer-info.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-radio-bearer-tag.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-rlc-am-header.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-rlc-am.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-rlc-header.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-rlc-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-rlc-sdu-status-tag.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-rlc-sequence-number.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-rlc-tag.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-rlc-tm.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-rlc-um.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-rlc.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-rrc-header.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-rrc-protocol-ideal.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-rrc-protocol-real-gnb.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-rrc-protocol-real-ue.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-rrc-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-simple-ue-component-carrier-manager.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-spectrum-phy.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-spectrum-signal-parameters.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-ue-ccm-rrc-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-ue-cmac-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-ue-component-carrier-manager.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-ue-cphy-sap.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-ue-mac.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-ue-net-device.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-ue-phy.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-ue-power-control.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-ue-rrc.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/nr-vendor-specific-parameters.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/realistic-beamforming-algorithm.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/realistic-bf-manager.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/resource-assignment-matrix.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/model/sfnsf.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/channels/nyu/nyu-channel-condition-model.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/channels/nyu/nyu-channel-model.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/channels/nyu/nyu-propagation-loss-model.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/channels/nyu/nyu-spectrum-propagation-loss-model.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/distance-based-three-gpp-spectrum-propagation-loss-model.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/fast-fading-constant-position-mobility-model.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/nr-json.hpp"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/parse-string-to-vector.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/random-direction-disc-2d-mobility-model.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/traffic-generators/helper/traffic-generator-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/traffic-generators/helper/xr-traffic-mixer-helper.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/traffic-generators/model/traffic-generator-3gpp-audio-data.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/traffic-generators/model/traffic-generator-3gpp-generic-video.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/traffic-generators/model/traffic-generator-3gpp-pose-control.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/traffic-generators/model/traffic-generator-ftp-single.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/traffic-generators/model/traffic-generator-ngmn-ftp-multi.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/traffic-generators/model/traffic-generator-ngmn-gaming.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/traffic-generators/model/traffic-generator-ngmn-video.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/traffic-generators/model/traffic-generator-ngmn-voip.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/traffic-generators/model/traffic-generator.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/contrib/nr/utils/nr-wraparound-utils.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/build/include/ns3/nr-module.h"
    "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/build/include/ns3/nr-export.h"
    )
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/home/cristi/DataCommunication_Claude_Standalone/ns-3.48/cmake-cache/contrib/nr/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
