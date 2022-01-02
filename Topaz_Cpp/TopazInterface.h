//==============================================================================
//
//  PROJECT:    Topaz
//
//------------------------------------------------------------------------------
//
//  FILE:       AbstractDevice.h
//  CONTENT:    Holds the interface to the Topaz-Device
//
//
//
//------------------------------------------------------------------------------
//
//              Copyright (C) 2017 X-Rite
//
//==============================================================================
#ifndef TOPAZINTERFACE_H
#define TOPAZINTERFACE_H

#include "Topaz_Cpp/LibAPI.h"
#include <cstdint>

namespace Xrite { namespace Device_Cpp { namespace Topaz {

   struct Answer
   {
	    // SDK specific error codes (range 0x2000 – 0x20ff)
		static const uint16_t NotConnected        = 0x2000;
		static const uint16_t NoResponse          = 0x2010;
		static const uint16_t WrongResponse       = 0x2020;
		static const uint16_t ResponseFormatError = 0x2030;
      static const uint16_t UnknownError        = 0x2040;
      static const uint16_t ContentError        = 0x2050;
      static const uint16_t UnknownDeviceTypeForLegacyCalculation   = 0x2060;
      
      static const uint16_t OK                   = 0x3301;
      static const uint16_t UNKNOWN_CMD          = 0x3302;
      static const uint16_t NOT_ALL_READ         = 0x3303;
      static const uint16_t TEMP_SENSOR          = 0x3304;
      static const uint16_t PARAM_OUT_OF_RANGE   = 0x3305;
      static const uint16_t NAND_FLASH           = 0x3306;
      static const uint16_t MAX_SIZE             = 0x3309;          
      static const uint16_t FILE_OPEN            = 0x330B;
      static const uint16_t FILE_DELETE          = 0x3310;
      static const uint16_t FILE_WRITE           = 0x3311;
      static const uint16_t FILE_READ            = 0x3312;
      static const uint16_t FILE_CLOSE           = 0x3313;
      static const uint16_t FILE_DIR             = 0x3314;
      static const uint16_t DATA_NOT_AVAILABLE    = 0x3318;
      static const uint16_t UNDEFINED             = 0x3319;
      static const uint16_t NO_LIGHT_DETECTED     = 0x331B;
      static const uint16_t AMBIENT_LIGHT         = 0x331D;
      static const uint16_t CALIBRATION_EXPIRED   = 0x331E;
      static const uint16_t RECOVER_USB           = 0x331F;
      static const uint16_t CALIB_DATA            = 0x3320;
      static const uint16_t OLD_CALIB_DATA        = 0x3321;     
      static const uint16_t FILE_SYSTEM           = 0x3322;
      static const uint16_t SYSTEM_BUSY           = 0x3323;
      static const uint16_t SHUTTER_PROBABLY_NOT_CLOSED   = 0x3324;

      static const uint16_t NOT_CALIBRATED        = 0x3326;
      static const uint16_t UNKNOWN_CALIB_FORMAT  = 0x3327;
      static const uint16_t CRC32                 = 0x3328;       
      static const uint16_t DATA_FLASH            = 0x3329;		     
      static const uint16_t ZERO_SIZE             = 0x332A;		              
      static const uint16_t NO_ACCESS             = 0x332B;         

      static const uint16_t BLUETOOTH_CONFIG      = 0x332D;
      static const uint16_t CHIP_ID_CRC           = 0x332E;
      static const uint16_t NOT_IMPLEMENTED_YET   = 0x332F;
      static const uint16_t JOB_ALREADY_DEFINED   = 0x3330;
      static const uint16_t JOB_NOT_CREATED       = 0x3331;
      static const uint16_t JOB_NOT_FOUND         = 0x3332;
      static const uint16_t JOB_NOT_DELETED       = 0x3333;
      static const uint16_t JOB_LIST_FULL         = 0x3334;
      static const uint16_t SHUTTER               = 0x3335;
      static const uint16_t NOT_INITIALIZED       = 0x3336;
      static const uint16_t WHITE_CAL             = 0x3337;

      static const uint16_t DeviceLocked          = 0x3430;

      static const uint16_t WIFI_POWER_OFF        = 0x3500;
      static const uint16_t WIFI_INACTIVE         = 0x3501;
      static const uint16_t NO_WIFI_CMD           = 0x3502;
      static const uint16_t WIFI_BUSY             = 0x3503;
   };

   static const uint32_t MaxStringLength   = 200;
   static const uint32_t MaxNumberOfAngles = 5;
   
   //==============================================================================
   // AngleDescription
   //==============================================================================
   // - Describes an illumination and pickup combination
   struct AngleDescription
   {
      uint8_t name[MaxStringLength];  // name 
      uint8_t position; // position of the angle
   };


   //==============================================================================
   // Time
   //==============================================================================
   // - Allows the definition of date and time
   struct Time
   {
      uint16_t	year; //	year with four digits like 2016
      uint8_t	month; // 1 .. 12
      uint8_t	day; // 1 .. 31
      uint8_t	hour; // 0 .. 23, 24 hour representation
      uint8_t	minute; // 0 .. 59
      uint8_t	second; // 0 .. 59
   };


   //==============================================================================
   // Job
   //==============================================================================
   // - Status and description of one measurement job
   struct Job
   {
      static const int MaxIdentifierLength = 20;
      static const int MaxNameLength = 40;

      uint8_t  identifier[MaxIdentifierLength];  //  identification of the job, max length 40 including delimiter \0
      uint8_t 	name[MaxNameLength];              //  name of the job, max length 20 including delimiter \0
      uint32_t	status;                           //  Bit0: 0 – created on Device, 1 – created on PC
                                                 //  Bit1: 0 - no data available, 1 - job complete, data available
   };  
   

   //==============================================================================
   // Sample
   //==============================================================================
   // - One measured sample
   struct Sample
   {
      static const uint32_t NumberOfSpectralValues = 31;
      Time timeStamp;
      float temperature;                                                // sample temperature in Celsius: -273 if not available
      float spectralValues[MaxNumberOfAngles][NumberOfSpectralValues];  // values from 400nm to 700nm in 10nm intervals
      float LabCh[MaxNumberOfAngles][5];                                // LabCh for D65 and 10°
   };  




   //==============================================================================
   // ProfileData
   //==============================================================================
   // - Data for calculate the legacy profile
   struct ProfileData
   {
      float spectralValuesUncorrected[MaxNumberOfAngles][Sample::NumberOfSpectralValues];  //values from 400nm to 700nm in 10nm intervals without legacy
      float differences[MaxNumberOfAngles][Sample::NumberOfSpectralValues];                // difference of blended spectra 
      float blendingFactors[MaxNumberOfAngles];                                            // factors for calculate the blended spectra
   };  

   //==============================================================================
   // NetworkDescription
   //==============================================================================
   // - Parameters of a WIFI network
   struct NetworkDescription
   {
      uint8_t SSID[MaxStringLength];               // SSID
      uint8_t MACAddress[MaxStringLength];         // AP MAC address
      uint8_t authentification[MaxStringLength];   // e.g. open, WEP, WPA2-AES
      int16_t signalLevel;                         // Signal level in dBm
      uint8_t channel;                             // WIFI channel
      uint8_t mode;                                // 0 = Infrastructure, 1 = Ad-hoc 
      float rate;                                  // Data rate
   };  







   //=========================================================================
   //  
   //=========================================================================
   class TopazInterface
   {
   public:

	   TopazInterface() {};   

      //==============================================================================
      // getVersion
      //==============================================================================
      // - Gets the version strings of the SDK and used legacy library
      virtual uint32_t getVersion( uint8_t* version, uint8_t* legacyVersion ) = 0;
       
      //==============================================================================
      // connect
      //==============================================================================
      // - Connects to the instrument. Only one device can be connected to the PC at a time.
      //   Closes a connection if there is one and opens a new connection.
      // - Input: TCP/IP address of the instrument as a string (for example "192.168.0.12")
      //          to connect to an instrument via WIFI. If no address is provided a connection
      //          via USB is established. 
      virtual uint32_t connect(const uint8_t* ipAddress = 0) = 0;


      //==============================================================================
      // unlock
      //==============================================================================
      // - unlocks the device for job handling commands
      // - Input: key (8 Bytes)
      //   Output: unlockSuccessful, 0 if device is still locked, 1 if unlocking was successful
      virtual uint32_t unlock(const uint8_t key[8],  uint8_t& unlockSuccessful) = 0;


      //==============================================================================
      // disconnect
      //==============================================================================
      // - Disconnects from the device
      virtual uint32_t disconnect() = 0;
          
      //==============================================================================
      // setTime
      //==============================================================================
      // - Sets the system time on the device
      virtual uint32_t setTime(const Time&	time) = 0;

      //==============================================================================
      // getTime
      //==============================================================================
      // - Gets the system time from the device
      virtual uint32_t getTime(Time&	time) = 0;

      //==============================================================================
      // powerWiFiOn 
      //==============================================================================
      // - Switches the Wi-Fi module of the device on for faster WiFi Configuration
      virtual uint32_t powerWiFiOn() = 0;

      //==============================================================================
      // powerWiFiOff 
      //==============================================================================
      // - Switches the Wi-Fi module of the device off
      virtual uint32_t powerWiFiOff() = 0;

      //==============================================================================
      // getNetworkDescriptions
      //==============================================================================
      // - Gets the descriptions of the Wi-Fi networks found by the instrument
      // - Input:	 descriptions:	pointer to an array of descriptions
      //           maxNumberOfDescriptions: maximal number of descriptions that can be stored (i.e. the array length)
      // - Output: actualNumberOfDescriptions:	actual number of descriptions found by the instrument
      virtual uint32_t getNetworkDescriptions(NetworkDescription*	descriptions, uint8_t maxNumberOfDescriptions, uint8_t& actualNumberOfDescriptions) = 0;

      //==============================================================================
      // setWifiConfiguration 
      //==============================================================================
      // - Sets Wi-Fi configuration of the device
      virtual uint32_t setWifiConfiguration(const uint8_t* ssid, const uint8_t* password) = 0;

      //==============================================================================
      // getWifiConfiguration  
      //==============================================================================
      // - Gets the Wi-Fi configuration from the device.
      virtual uint32_t getWifiConfiguration(uint8_t*	ssid) = 0;


      //==============================================================================
      // setHostname 
      //==============================================================================
      // - Sets the hostname of the device to identify it in a Wi-Fi network
      virtual uint32_t setHostname(const uint8_t* hostname) = 0;

      //==============================================================================
      // getHostname 
      //==============================================================================
      // - Gets the hostname of the device to identify it in a Wi-Fi network
      virtual uint32_t getHostname(uint8_t*	ssid) = 0;

      //==============================================================================
      // getTotalNumberOfJobs
      //==============================================================================
      // - Gets the total number of jobs stored on the device
      virtual uint32_t getTotalNumberOfJobs(uint16_t&	totalNumberOfJobs) = 0;

      //==============================================================================
      // getJobList
      //==============================================================================
      // - Retrieves a list of all jobs stored on the device and their current state
      // - Input:	 maxNumberOfJobs:	maximal number of jobs to be stored in jobStati 
      //           
      // - Output: jobs:	         array of the jobs  with size due to maxNumberOfJobs
      //                            has to allocated by the caller with size = maxNumberOfJobs
      //           actualNumberOfJobs:    number of jobs that were stored in jobStati   
      virtual uint32_t getJobList(Job* jobs, const uint16_t& maxNumberOfJobs,  uint16_t&	actualNumberOfJobs) = 0;
      
      //==============================================================================
      // addJob
      //==============================================================================
      // - Adds a new job on the device
      // - Input:	 identification:	identification of the job
      //           description:	description (only ASCII) to be displayed
      //           numberOfMeasurements:	number of measurements which have to be performed for this job
      virtual uint32_t addJob(const uint8_t* identification, const uint8_t*	description, const uint8_t	numberOfMeasurements) = 0;
         
      //==============================================================================
      // deleteJob
      //==============================================================================
      // - Deletes a job from the device.
      // - Input:	identification:	identification of the job to be deleted
      virtual uint32_t deleteJob(const uint8_t*	identification) = 0;
         	


      //==============================================================================
      // getJobResult
      //==============================================================================
      // - Gets all measurement data of a job from the device.
      // - Input:	 jobIdentifier:	identification of the job the result is requested from
      //           legacy: requested legacy correction: 0 - no legacy, 1 - Ma91, Ma98 legacy,  
      // - Output: job: description and status of the job	
      //           timeStamp:	creation time of the job
      //           result: representative spectra and lab, average of the best samples 
      //           samples:	storage for the individual measurements    
      //           maxNumberOfSamples: storage capacity of samples (might be set to 0, if samples not needed)
      //           actualNumberOfSamples: how many samples are available 
      virtual uint32_t getJobResult(const uint8_t*	jobIdentifier, int legacy, Job& job, Time& timeStamp, 
         Sample& result, Sample* samples = nullptr, uint8_t maxNumberOfSamples = 0,   uint8_t* actualNumberOfSamples = 0, ProfileData* profileData = nullptr) = 0; 
                 
      //==============================================================================
      // openShutter
      //==============================================================================
      // - Allows to open and close the shutter for service purposes.
      // - Input:	  open:	1 for open, 0 for close
      // - Output:  time in milliseconds to open or close the shutter 
      virtual uint32_t openShutter(const uint8_t&	open, uint16_t& elepasedTimeInMs) = 0;
         
      //==============================================================================
      // getDeviceInformation
      //==============================================================================
      // - Retrieves information to identify the device
      // - Output:	 serialNumber:	serial number of the instrument
      //              whiteTile:	serial number of the white tile
      //              calibrationDate:	string describing when the last calibration of the device was performed
      //              instrumentType:	type of instrument 
      //              angles:            names of angles used by the device
      //              numberOfAngles:    number of angles used by the device
      virtual uint32_t getDeviceInformation(uint8_t*	serialNumber,  uint8_t*	whiteTile,
                        uint8_t*	calibrationDate, uint8_t*	instrumentType,
				      uint8_t* angles, uint8_t& numberOfAngles) = 0;
         



      //==============================================================================
      // getMacAddress  
      //==============================================================================
      // - Gets the MAC address of the device.
      // - Output:	 macAddress:	MAC address of the instrument
      virtual uint32_t getMacAddress(uint8_t*	macAddress) = 0;


      //==============================================================================
      // getFirmwareInformation
      //==============================================================================
      // - Gets an identification of the firmware. 
      // - Output:	firmwareIdentification:	for example: "Topaz 0.63"  
      virtual uint32_t getFirmwareInformation(uint8_t*	firmwareIdentification) = 0;

       
      //==============================================================================
      // downloadFirmware
      //==============================================================================
      // - downloads the Firmware to the device 
      // - Input:	   buffer containing the firmware
      //       	   size of buffer 
      // - Output:	buffer:	buffer to store the log data
      //             actualBufferSize:	actual used size of the buffer
      virtual uint32_t  downloadFirmware(uint8_t* buffer, const uint32_t& bufferSize) = 0;   


      //==============================================================================
      // getDeviceLog
      //==============================================================================
      // - Retrieves device internal log data. This information should be sent to the support team. It is not intended to be displayed to the operator.
      // - Input:	   maxLogBufferSize:	size of the reserved buffer to store the log; it is recommended to prepare a buffer of 100 000 bytes
      // - Output:	buffer:	buffer to store the log data
      //             actualBufferSize:	actual used size of the buffer
      virtual uint32_t getDeviceLog(uint8_t* buffer, const uint32_t& maxLogBufferSize,  uint32_t&	actualBufferSize) = 0;       

      //==============================================================================
      // getSelftestReport
      //==============================================================================
      // - Retrieves the last selftest report executed by the device. This information should be sent to the support team. It is not intended to be displayed to the operator.
      // - Input:	   maxBufferSize:	size of the reserved buffer to store the report; it is recommended to prepare a buffer of 100 000 bytes
      // - Output:	buffer:	buffer to store the log data
      //             actualBufferSize:	actual used size of the buffer
      virtual uint32_t getSelftestReport(uint8_t* buffer, const uint32_t& maxLogBufferSize,  uint32_t&	actualBufferSize) = 0;       


      //==============================================================================
      // startMeasureMode
      //==============================================================================
      // - Switches to the measure screen on the device, allows the user to direct measure the given job 
      virtual uint32_t startMeasureMode(const uint8_t* jobIdentifier) = 0;      

      //==============================================================================
      // isInMeasureMode
      //==============================================================================
      // - Asks if the device is displaying the measure screen
      //   Shall be used for online measurements
      // - Output:  1 if measure screen is displayed, 0 if not
      virtual uint32_t isInMeasureMode(uint8_t&	isInMeasureMode) = 0;
  };
  
   extern "C" DEVICE_API TopazInterface* getTopazInterface();
   extern "C" DEVICE_API TopazInterface* getTopazSimulation();
   typedef TopazInterface* (*TopazInterfaceFunction)();




}}}




#endif //
