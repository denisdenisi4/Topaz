import Topaz

try:
    interface = Topaz.getTopazInterface()

    version, legacyVersion = interface.getVersion()
    print("Version: " + version)
    print("LegacyVersion: " + legacyVersion)

    # interface.usbConnect()
    # interface.wifiConnect("1.2.3.4")
    # interface.disconnect()

    # interface.unlock("AABBAABBAABBAABB")

    # time_to_set = Topaz.Time(2022,1,1,0,0,0)
    # print(time_to_set)
    # interface.setTime(time_to_set)

    # time_from_device = interface.getTime()
    # print(time_from_device)

    # interface.powerWiFiOn()
    # interface.powerWiFiOff()

    # maxNumberOfDescriptions = 5;
    # descriptions = interface.getNetworkDescriptions(maxNumberOfDescriptions)
    # for desc in descriptions:
    #     print(desc)

    # interface.setWifiConfiguration("my_ssid", "my_password")
    # ssid = interface.getWifiConfiguration()
    # print(desc)

    # interface.setHostname("some_hostname")
    # hostname = interface.getHostname()
    # print("HOSTNAME: " + hostname)

    # job_numbers = interface.getTotalNumberOfJobs()
    # print("JOB NUMBERS: " + str(job_numbers))

    # maxNumberOfJobs = 5
    # jobs = interface.getJobList(maxNumberOfJobs)
    # for j in jobs:
    #     print(j)

    # numberOfMeasurements = 5
    # print(interface.addJob("JobId4", "Job4", numberOfMeasurements))    

    # interface.deleteJob("JobId3");

    # maxNumberOfSamples = 10
    # job, time, result = interface.getJobResult("JobId1", 0)
    # print(time)
    # print(job)
    # print(result)
    # job, time, result, samples = interface.getJobResult("JobId1", maxNumberOfSamples)
    # for s in samples:
    #     print(s)

    # elepasedTimeInMs = interface.openShutter()
    # print("Timestamp open: " + str(elepasedTimeInMs))
    # elepasedTimeInMs = interface.closeShutter()
    # print("Timestamp close: " + str(elepasedTimeInMs))

    # device_info = interface.getDeviceInformation()
    # print(device_info)

    # macAddress = interface.getMacAddress()
    # print("Mac address: " + macAddress)
    
    # firmwareIdentification = interface.getFirmwareInformation()
    # print("Firmware: " + firmwareIdentification)

    # maxLogBufferSize = 100500
    # log = interface.getDeviceLog(maxLogBufferSize)
    # print("DEVICE LOG: " + log)

    # maxReportBufferSize = 100500
    # report = interface.getSelftestReport(maxReportBufferSize)
    # print("SELFTEST REPORT: " + report)

    # isInMeasureMode = interface.isInMeasureMode()
    # print("MODE: " + "on" if isInMeasureMode else "off" )

    # NOT IMPLEMENTED
    # interface.downloadFirmware()

except Exception as e:
    print("Execution error: " + str(e))