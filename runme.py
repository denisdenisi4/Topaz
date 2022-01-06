import Topaz

try:
    TEST_ON_REAL_DEVICE = False
    interface = Topaz.getTopazInterface() if TEST_ON_REAL_DEVICE else Topaz.getTopazSimulation()

    version, legacyVersion = interface.getVersion()
    print("Version: " + version)
    print("LegacyVersion: " + legacyVersion)

    print("Anwer code example: " + Topaz.Answer.toString(Topaz.Answer.OLD_CALIB_DATA))

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
    #    print("SSID: " + desc.SSID)
    #    print("SSID: " + desc.MACAddress)
    #    print("SSID: " + desc.authentification)

    # interface.setWifiConfiguration("my_ssid", "my_password")
    # ssid = interface.getWifiConfiguration()
    # print(ssid)

    # interface.setHostname("some_hostname")
    # hostname = interface.getHostname()
    # print("HOSTNAME: " + hostname)

    # job_numbers = interface.getTotalNumberOfJobs()
    # print("JOB NUMBERS: " + str(job_numbers))

    # maxNumberOfJobs = 5
    # jobs = interface.getJobList(maxNumberOfJobs)
    # for j in jobs:
    #     print("Identifier: " + j.identifier)
    #     print("Name: " + j.name)

    # numberOfMeasurements = 5
    # print("Adding job") 
    # interface.addJob("JobId4", "Job4", numberOfMeasurements)
    # print("Job added")    

    # print("Deleting job") 
    # interface.deleteJob("JobId3");
    # print("Job deleted") 

    # WITHOUT sample array
    # job, time, result = interface.getJobResult("JobId1", 0)
    # print("Job time: " + str(time))
    # print("Job name: " + job.name)
    # print("Result temperature: " + str(result.temperature))
    # print("Some spectralValues: " + str(result.spectralValues[0][1]))
    # print("Some LabCh value: " + str(result.LabCh[0][1]))

    # WITH sample array
    # maxNumberOfSamples = 10
    # job, time, result, samples = interface.getJobResult("JobId1", maxNumberOfSamples)
    # for s in samples:
    #     print("Sample timeStamp: " + str(s.timeStamp))

    # elepasedTimeInMs = interface.openShutter()
    # print("Timestamp open: " + str(elepasedTimeInMs))
    # elepasedTimeInMs = interface.closeShutter()
    # print("Timestamp close: " + str(elepasedTimeInMs))

    # device_info = interface.getDeviceInformation()
    # print(device_info)
    # print("Serial number: " + device_info.serialNumber)
    # print("White tile: " + device_info.whiteTile)
    # print("Calibration date: " + device_info.calibrationDate)
    # print("Instrument type: " + device_info.instrumentType)
    # print("Angels number: " + str(device_info.numberOfAngles))
    # print(device_info.angles)
    # for angle in device_info.angles:
    #     print("Angel: " + angle)

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