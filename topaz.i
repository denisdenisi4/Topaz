%module Topaz

%{
#include "Topaz_Cpp/TopazInterface.h"
%}

%include <windows.i>
%include <stdint.i>
%include <std_string.i>
%include <exception.i>

// Should be place before Topaz headers
%inline %{
namespace Xrite { namespace Device_Cpp { namespace Topaz {
struct DeviceInformation {
    uint8_t serialNumber[Xrite::Device_Cpp::Topaz::MaxStringLength];
    uint8_t whiteTile[Xrite::Device_Cpp::Topaz::MaxStringLength];
    uint8_t calibrationDate[Xrite::Device_Cpp::Topaz::MaxStringLength]; 
    uint8_t instrumentType[Xrite::Device_Cpp::Topaz::MaxStringLength];
    uint8_t angles[Xrite::Device_Cpp::Topaz::MaxNumberOfAngles][Xrite::Device_Cpp::Topaz::MaxStringLength];
    uint8_t numberOfAngles;
};
}}}
%}

%include "Topaz_Cpp/LibAPI.h"
%include "Topaz_Cpp/TopazInterface.h"

%extend Xrite::Device_Cpp::Topaz::Answer {
    static bool isOk(uint32_t code) {
        return Xrite::Device_Cpp::Topaz::Answer::OK == code;
	}

	static bool isFail(uint32_t code) {
        return Xrite::Device_Cpp::Topaz::Answer::OK != code;
    }
}

%extend Xrite::Device_Cpp::Topaz::Time {
	Time(uint16_t year, uint8_t month, uint8_t day, uint8_t hour, uint8_t minute, uint8_t second) {
		Xrite::Device_Cpp::Topaz::Time *v;
		v = new Xrite::Device_Cpp::Topaz::Time;
		v->year = year;
		v->month = month;
		v->day = day;
        v->hour = hour;
		v->minute = minute;
		v->second = second;
		return v;
	}
	~Time() {
		delete $self;
	}
    char *__str__() {
        static char temp[256];
        sprintf(temp,"{ %d-%02d-%02d %02d:%02d:%02d }", $self->year, $self->month, $self->day, $self->hour, $self->minute, $self->second);
        return &temp[0];
    }
};

%extend Xrite::Device_Cpp::Topaz::Job {
    char *__str__() {
        static char temp[256];
        sprintf(temp,"{ identifier: '%s', name: '%s', status: %d }", (const char *)$self->identifier, (const char *)$self->name, $self->status);
        return &temp[0];
    }
};

%ignore Xrite::Device_Cpp::Topaz::TopazInterface::getVersion( uint8_t* version, uint8_t* legacyVersion );
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::connect(const uint8_t* ipAddress = 0);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::unlock(const uint8_t key[8],  uint8_t& unlockSuccessful);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::getTime(Time&	time);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::powerWiFiOn();
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::powerWiFiOff();
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::getNetworkDescriptions(NetworkDescription*	descriptions, uint8_t maxNumberOfDescriptions, uint8_t& actualNumberOfDescriptions);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::setWifiConfiguration(const uint8_t* ssid, const uint8_t* password);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::getWifiConfiguration(uint8_t*	ssid);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::setHostname(const uint8_t* hostname);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::getHostname(uint8_t*	ssid);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::getTotalNumberOfJobs(uint16_t&	totalNumberOfJobs);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::getJobList(Job* jobs, const uint16_t& maxNumberOfJobs,  uint16_t&	actualNumberOfJobs);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::addJob(const uint8_t* identification, const uint8_t*	description, const uint8_t	numberOfMeasurements);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::deleteJob(const uint8_t*	identification);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::getJobResult(const uint8_t* jobIdentifier, int legacy, Job& job, Time& timeStamp, Sample& result, Sample* samples = nullptr, uint8_t maxNumberOfSamples = 0,   uint8_t* actualNumberOfSamples = 0, ProfileData* profileData = nullptr);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::openShutter(const uint8_t& open, uint16_t& elepasedTimeInMs);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::getDeviceInformation(uint8_t*	serialNumber,  uint8_t*	whiteTile, uint8_t*	calibrationDate, uint8_t*	instrumentType, uint8_t* angles, uint8_t& numberOfAngles);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::getMacAddress(uint8_t*	macAddress);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::getFirmwareInformation(uint8_t*	firmwareIdentification);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::startMeasureMode(const uint8_t* jobIdentifier);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::getDeviceLog(uint8_t* buffer, const uint32_t& maxLogBufferSize,  uint32_t&	actualBufferSize);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::getSelftestReport(uint8_t* buffer, const uint32_t& maxLogBufferSize,  uint32_t&	actualBufferSize);
%ignore Xrite::Device_Cpp::Topaz::TopazInterface::isInMeasureMode(uint8_t&	isInMeasureMode);


%extend Xrite::Device_Cpp::Topaz::TopazInterface {

    PyObject *isInMeasureMode() {
	    uint8_t isInMeasureMode = 0;
		uint32_t libCode = $self->isInMeasureMode(isInMeasureMode);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"isInMeasureMode() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
		return PyBool_FromLong(isInMeasureMode);
		fail:
	    return nullptr;
	}

    PyObject *getSelftestReport(uint32_t maxLogBufferSize) {
	    PyObject *pyBuffer = nullptr;
	    uint8_t* buffer = new uint8_t[maxLogBufferSize];
		uint32_t actualBufferSize = 0;
		uint32_t libCode = $self->getSelftestReport(buffer, maxLogBufferSize, actualBufferSize);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
		    delete[] buffer;
			static char temp[256];
			sprintf(temp,"getSelftestReport() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
		pyBuffer = PyBytes_FromStringAndSize((const char *)buffer, actualBufferSize);
		delete[] buffer;
		return pyBuffer;
		fail:
	    return nullptr;
	}

    PyObject *getDeviceLog(uint32_t maxLogBufferSize) {
	    PyObject *pyBuffer = nullptr;
	    uint8_t* buffer = new uint8_t[maxLogBufferSize];
		uint32_t actualBufferSize = 0;
		uint32_t libCode = $self->getDeviceLog(buffer, maxLogBufferSize, actualBufferSize);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
		    delete[] buffer;
			static char temp[256];
			sprintf(temp,"getDeviceLog() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
		pyBuffer = PyBytes_FromStringAndSize((const char *)buffer, actualBufferSize);
		delete[] buffer;
		return pyBuffer;
		fail:
	    return nullptr;
	}

    void startMeasureMode(const char* identification) {
		uint32_t libCode = $self->startMeasureMode((const uint8_t*) identification);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"startMeasureMode() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
		return;
		fail:
	    return;
	}

    PyObject *getFirmwareInformation() {
		uint8_t firmwareIdentification[Xrite::Device_Cpp::Topaz::MaxStringLength];
        uint32_t libCode = $self->getFirmwareInformation(firmwareIdentification);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"getFirmwareInformation() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
        return PyString_FromString((char *)firmwareIdentification);
		fail:
	    return nullptr;
	}
    
    PyObject *getMacAddress() {
		uint8_t macAddress[Xrite::Device_Cpp::Topaz::MaxStringLength];
        uint32_t libCode = $self->getMacAddress(macAddress);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"getMacAddress() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
        return PyString_FromString((char *)macAddress);
		fail:
	    return nullptr;
    }

     PyObject *getDeviceInformation() {
	    Xrite::Device_Cpp::Topaz::DeviceInformation* info = new Xrite::Device_Cpp::Topaz::DeviceInformation;
		uint32_t libCode = $self->getDeviceInformation(info->serialNumber, info->whiteTile, info->calibrationDate, info->instrumentType, (uint8_t*) info->angles, info->numberOfAngles);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
		    delete info;
		    static char temp[256];
			sprintf(temp,"getDeviceInformation() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
	    return SWIG_NewPointerObj(info, SWIGTYPE_p_Xrite__Device_Cpp__Topaz__DeviceInformation, SWIG_POINTER_OWN);
		fail:
	    return nullptr;
    }

    uint16_t openShutter() {
	    uint16_t elepasedTimeInMs = 0;
        uint32_t libCode = $self->openShutter(1, elepasedTimeInMs);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"openShutter() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
        return elepasedTimeInMs;
		fail:
	    return elepasedTimeInMs;
	}

	uint16_t closeShutter() {
	    uint16_t elepasedTimeInMs = 0;
        uint32_t libCode = $self->openShutter(0, elepasedTimeInMs);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"closeShutter() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
        return elepasedTimeInMs;
		fail:
	    return elepasedTimeInMs;
	}

    PyObject *getJobResult(const char* identification, uint8_t maxNumberOfSamples) {
	    uint8_t actualNumberOfSamples = 0;
	    PyObject *pyJob = nullptr;
		PyObject *pyTime = nullptr;
		PyObject *pyResult = nullptr;
		PyObject *pySamples = nullptr;
		Xrite::Device_Cpp::Topaz::Job* job = new Xrite::Device_Cpp::Topaz::Job;
		Xrite::Device_Cpp::Topaz::Time* time = new Xrite::Device_Cpp::Topaz::Time;
		Xrite::Device_Cpp::Topaz::Sample* result = new Xrite::Device_Cpp::Topaz::Sample;
	    Xrite::Device_Cpp::Topaz::Sample* samples = maxNumberOfSamples > 0 ? new Xrite::Device_Cpp::Topaz::Sample[maxNumberOfSamples] : nullptr;
		uint32_t libCode = $self->getJobResult((const uint8_t* )identification, 0, *job, *time, *result, samples, maxNumberOfSamples, &actualNumberOfSamples, nullptr);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
		    if (maxNumberOfSamples > 0) {
			    delete[] samples;
		    }
			static char temp[256];
			sprintf(temp,"getJobResult() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}

		pyJob = SWIG_NewPointerObj(time, SWIGTYPE_p_Xrite__Device_Cpp__Topaz__Job, SWIG_POINTER_OWN);
		pyTime = SWIG_NewPointerObj(time, SWIGTYPE_p_Xrite__Device_Cpp__Topaz__Time, SWIG_POINTER_OWN);
		pyResult = SWIG_NewPointerObj(time, SWIGTYPE_p_Xrite__Device_Cpp__Topaz__Sample, SWIG_POINTER_OWN);
		if (maxNumberOfSamples > 0) {
			pySamples = PyList_New(actualNumberOfSamples);
			for (uint8_t i = 0; i < actualNumberOfSamples; ++i) {
				Xrite::Device_Cpp::Topaz::Sample* sample = new Xrite::Device_Cpp::Topaz::Sample;
				*sample = samples[i];
				PyList_SetItem(pySamples, i, SWIG_NewPointerObj(sample, SWIGTYPE_p_Xrite__Device_Cpp__Topaz__Sample, SWIG_POINTER_OWN));
			}
			delete[] samples;
		}	    
		return maxNumberOfSamples > 0 ? Py_BuildValue("(O,O,O,O)", pyJob, pyTime, pyResult, pySamples) : Py_BuildValue("(O,O,O)", pyJob, pyTime, pyResult);
		fail:
	    return nullptr;
	}

    void deleteJob(const char* identification) {
		uint32_t libCode = $self->deleteJob((const uint8_t*) identification);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"deleteJob() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
		return;
		fail:
	    return;
	}

    void addJob(const char* identification, const char* description, uint8_t numberOfMeasurements) {
		uint32_t libCode = $self->addJob((const uint8_t*) identification, (const uint8_t*) description, numberOfMeasurements);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"addJob() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
		return;
		fail:
	    return;
	}

    PyObject *getJobList(uint16_t maxNumberOfJobs) {
	    PyObject *pyJobs = nullptr;
	    Xrite::Device_Cpp::Topaz::Job* jobs = new Xrite::Device_Cpp::Topaz::Job[maxNumberOfJobs];
		uint16_t actualNumberOfJobs = 0;
		uint32_t libCode = $self->getJobList(jobs, maxNumberOfJobs, actualNumberOfJobs);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
		    delete[] jobs;
			static char temp[256];
			sprintf(temp,"getJobList() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
		pyJobs = PyList_New(actualNumberOfJobs);
		for (uint8_t i = 0; i < actualNumberOfJobs; ++i) {
		    Xrite::Device_Cpp::Topaz::Job* job = new Xrite::Device_Cpp::Topaz::Job;
			*job = jobs[i];
			PyList_SetItem(pyJobs, i, SWIG_NewPointerObj(job, SWIGTYPE_p_Xrite__Device_Cpp__Topaz__Job, SWIG_POINTER_OWN));
		}
		delete[] jobs;
	    return pyJobs;
		fail:
	    return nullptr;
	}

    uint16_t getTotalNumberOfJobs() {
	    uint16_t totalNumberOfJobs = 0;
        uint32_t libCode = $self->getTotalNumberOfJobs(totalNumberOfJobs);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"getTotalNumberOfJobs() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
        return totalNumberOfJobs;
		fail:
	    return totalNumberOfJobs;
    }

    PyObject *getHostname() {
		uint8_t hostname[Xrite::Device_Cpp::Topaz::MaxStringLength];
        uint32_t libCode = $self->getHostname(hostname);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"getHostname() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
        return PyString_FromString((char *)hostname);
		fail:
	    return nullptr;
    }

    void setHostname(const char* hostname) {
		uint32_t libCode = $self->setHostname((const uint8_t*) hostname);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"setHostname() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
		return;
		fail:
	    return;
	}

    PyObject *getWifiConfiguration() {
		uint8_t ssid[Xrite::Device_Cpp::Topaz::MaxStringLength];
        uint32_t libCode = $self->getWifiConfiguration(ssid);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"getWifiConfiguration() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
        return PyString_FromString((char *)ssid);
		fail:
	    return nullptr;
    }

    void setWifiConfiguration(const char* ssid, const char* password) {
		uint32_t libCode = $self->setWifiConfiguration((const uint8_t*) ssid, (const uint8_t*) password);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"setWifiConfiguration() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
		return;
		fail:
	    return;
	}

    PyObject *getNetworkDescriptions(uint8_t maxNumberOfDescriptions) {
	    PyObject *pyDescriptions = nullptr;
	    Xrite::Device_Cpp::Topaz::NetworkDescription* descriptions = new Xrite::Device_Cpp::Topaz::NetworkDescription[maxNumberOfDescriptions];
		uint8_t actualNumberOfDescriptions = 0;
		uint32_t libCode = $self->getNetworkDescriptions(descriptions, maxNumberOfDescriptions, actualNumberOfDescriptions);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
		    delete[] descriptions;
			static char temp[256];
			sprintf(temp,"getNetworkDescriptions() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
		pyDescriptions = PyList_New(actualNumberOfDescriptions);
		for (uint8_t i = 0; i < actualNumberOfDescriptions; ++i) {
		    Xrite::Device_Cpp::Topaz::NetworkDescription* description = new Xrite::Device_Cpp::Topaz::NetworkDescription;
			*description = descriptions[i];
			PyList_SetItem(pyDescriptions, i, SWIG_NewPointerObj(description, SWIGTYPE_p_Xrite__Device_Cpp__Topaz__NetworkDescription, SWIG_POINTER_OWN));
		}
		delete[] descriptions;
	    return pyDescriptions;
		fail:
	    return nullptr;
	}

    void powerWiFiOn() {
		uint32_t libCode = $self->powerWiFiOn();
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
		    static char temp[256];
			sprintf(temp,"powerWiFiOn() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
	    return;
		fail:
	    return;
	}

    void powerWiFiOff() {
		uint32_t libCode = $self->powerWiFiOff();
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
		    static char temp[256];
			sprintf(temp,"powerWiFiOff() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
	    return;
		fail:
	    return;
	}

    PyObject *getTime() {
	    Xrite::Device_Cpp::Topaz::Time* time = new Xrite::Device_Cpp::Topaz::Time{0, 0, 0, 0, 0, 0};
		uint32_t libCode = $self->getTime(*time);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
		    delete time;
		    static char temp[256];
			sprintf(temp,"getTime() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
	    return SWIG_NewPointerObj(time, SWIGTYPE_p_Xrite__Device_Cpp__Topaz__Time, SWIG_POINTER_OWN);
		fail:
	    return nullptr;
    }

    PyObject *getVersion() {
		uint8_t version[Xrite::Device_Cpp::Topaz::MaxStringLength];
		uint8_t legacyVersion[Xrite::Device_Cpp::Topaz::MaxStringLength];
        uint32_t libCode = $self->getVersion(version, legacyVersion);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"getVersion() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
        return Py_BuildValue("(s,s)", (char *)version, (char *)legacyVersion);
		fail:
	    return nullptr;
    }

	void wifiConnect(const char *address) {
	    uint32_t libCode = $self->connect((const uint8_t* )address);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"wifiConnect() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
        return;
		fail:
	    return;
	}

	void usbConnect() {
	    uint32_t libCode = $self->connect(nullptr);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
			static char temp[256];
			sprintf(temp,"usbConnect() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
        return;
		fail:
	    return;
	}

	void powerWiFiOn() {
	    uint32_t libCode = $self->powerWiFiOn();
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
		    static char temp[256];
			sprintf(temp,"powerWiFiOn() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
	    return;
		fail:
	    return;
	}

	void powerWiFiOff() {
	    uint32_t libCode = $self->powerWiFiOff();
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
		    static char temp[256];
			sprintf(temp,"powerWiFiOff() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
	    return;
		fail:
	    return;
	}

	PyObject *unlock(const char* key) {
	    uint8_t _key[8];
	    uint8_t unlockSuccessful = 0;
		size_t len = strlen(key);
		memset(_key, 0, 8);
		memcpy(_key, key, len > 8? 8 : len);
	    uint32_t libCode = $self->unlock(_key, unlockSuccessful);
		if (libCode != Xrite::Device_Cpp::Topaz::Answer::OK) {
		    static char temp[256];
			sprintf(temp,"unlock() error code 0x%04x", libCode);
		    SWIG_exception(SWIG_RuntimeError, temp);
		}
	    return PyBool_FromLong(unlockSuccessful);
		fail:
	    return nullptr;
	}
};


