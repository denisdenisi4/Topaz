import Topaz

try:
    interface = Topaz.getTopazInterface()

    version, legacyVersion = interface.getVersion()
    print("Version: " + version)
    print("LegacyVersion: " + legacyVersion)

    # interface.usbConnect()
    # interface.wifiConnect("1.2.3.4")
    # interface.disconnect()

    # interface.unlock("12345678")

    # time_to_set = Topaz.Time(2022,1,1,0,0,0)
    # print("Time to set: " + str(time_to_set))
    # interface.setTime(time_to_set)

    # time_from_device = interface.getTime()
    # print("Time to set: " + str(time_from_device))

    # interface.powerWiFiOn()
    # interface.powerWiFiOff()

    # maxNumberOfDescriptions = 5;
    # descriptions = interface.getNetworkDescriptions(maxNumberOfDescriptions)
    # # Not tested because of no device
    # for desc in descriptions:
    #     print("SSID: " + desc.SSID)

    # interface.setWifiConfiguration("my_ssid", "my_password")
    # ssid = interface.getWifiConfiguration()
    # print

    # interface.setHostname("some_hostname")
    # hostname = interface.getHostname()
    # print("HOSTNAME: " + hostname)

    # job_numbers = interface.getTotalNumberOfJobs()
    # print("JOB NUMBERS: " + str(job_numbers))

    # maxNumberOfJobs = 5
    # jobs = interface.getJobList(maxNumberOfJobs)
    # # Not tested because of no device
    # for j in jobs:
    #     print("JOB NAME: " + j.name)

    # numberOfMeasurements = 5
    # interface.addJob("job identification", "job description", numberOfMeasurements)

    # interface.deleteJob("job identification");

    # maxNumberOfSamples = 10
    # job, time, result = interface.getJobResult("job identification", 0)
    # print("JOB NAME: " + j.name)
    # print("TIME: " + str(time))
    # print("RESULT TEMP: " + result.temperature)
    # job, time, result, samples = interface.getJobResult("job identification", maxNumberOfSamples)
    # # Not tested because of no device
    # for s in samples:
    #     print("SAMPLE TIMESTAMP: " + str(s.timeStamp))

    # elepasedTimeInMs = interface.openShutter()
    # print("Timestamp open: " + elepasedTimeInMs)
    # elepasedTimeInMs = interface.closeShutter()
    # print("Timestamp close: " + elepasedTimeInMs)

    # device_info = interface.getDeviceInformation()
    # print("Device serial number: " + device_info.serialNumber)

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