//
//  TestApi.h
//  HttpFramework
//
//  Created by Alex Lin on 2021/9/23.
//

#ifndef TestApi_h
#define TestApi_h

typedef NS_ENUM(NSInteger, TestRequestID) {
    TestRequest_Ping,
    TestRequest_Heartbeat,
    TestRequest_DeviceScanned,
    TestRequest_DeviceUpdate,
    TestRequest_DeviceConnect,
    TestRequest_DeviceDisConnect,
    TestRequest_DeviceInfo,
    TestRequest_OtaUpdate,
    TestRequest_OtaStart,
    TestRequest_OtaStop,
    TestRequest_DebugMonitor,
    TestRequest_DebugInfo,
    TestRequest_SensorResulProtocol,
    TestRequest_Message,
    TestRequest_Result,
    TestRequest_DeviceReady,
    TestRequest_Max
};

// TODO: need to be updated
#define kTestRequestUrl @"http://127.0.0.1:5000/"

// api/heartbeat
#define kApiHeartbeat @"heartbeat"

// api/ping
#define kApiPing @"ping"

// module names
#define kModuleKey @"module"
#define kModuleNameOTA @"ota"

// common for not available
#define kNotAvailable @"na"

// common keys
#define kKeyAPI @"api"
#define kKeyAction @"action"
#define kKeyError @"error"

// api/device
#define kTestApiDevScan @"device_scan"
#define kTestApiDevUpdate @"device_update"
#define kTestApiDevConnect @"device_connect"
#define kTestApiDevDisconnect @"device_disconnect"
#define kTestApiDevInfo @"device_info"

// device keys
#define kDevKeyType @"type"
#define kDevKeyName @"name"
#define kDevKeyUUID @"uuid"
#define kDevKeyMAC @"mac"
#define kDevKeyVersion @"version"
#define kDevKeyState @"state"
#define kDevStaConnected @"connected"
#define kDevStaDisonnected @"disconnected"
#define kDevKeyDuration @"duration"

// device actions
#define kDevActionScan @"scan"
#define kDevActionUpdate @"update"
#define kDevActionConnect @"connect"
#define kDevActionDisconnect @"disconnect"
#define kDevActionInfo @"info"

// api/ota
#define kTestApiOtaUpdate @"ota_update"
#define kTestApiOtaStart @"ota_start"
#define kTestApiOtaStop @"ota_stop"

// OTA keys
#define kOtaKeyUrl @"url"
#define kOtaKeyFile @"file"
#define kOtaKeyState @"state"
#define kOtaKeyProgress @"progress"

// OTA actions
#define kOtaActionStart @"start"
#define kOtaActionStop @"stop"

// OTA errors
#define kOtaErrorMismatch @"mismatch"
#define kOtaErrorNoDevice @"no_device"
#define kOtaErrorDownloadFail @"download_fail"

// api/sensor
#define kApiSensorResultProtocol @"result_protocol"

// sensor keys
#define kResultParam @"param"
#define kResultType @"type"
#define kResultValue @"expected_value"
#define kSensorType @"result_type"
#define kSensorValue @"result_value"

// sensor actions
#define kSensorActionResultProtocol @"result_protocol"
#define kSensorActionProtocolTest @"protocol_test"

// api/message
#define kTestApiMessage @"message_request"
#define kTestApiResult @"test_result"
#define kTestApiReady @"test_ready"

// message keys
#define kMessage @"message"
#define kTestResult @"result"
#define kType @"type"
#define kParam @"param"

// message actions
#define kMessageAction @"msg_test"

// api/debug
#define kApiDebugMonitor @"debug_monitor"
#define kApiDebugInfo @"debug_info"

// debug keys
#define kDebugHeapSize @"heap_size"
#define kDebugPpgIRQ @"ppg_irq"
#define kDebugEcgIRQ @"ecg_irq"
#define kDebugImuIRQ @"imu_irq"
#define kDebugModule @"module"
#define kDebugAlgo @"algo"
#define kDebugSensor @"sensor"
#define kDebugFunction @"function"
#define kDebugParam @"param"
#define kDebugErrorCode @"err_code"

#endif /* TestApi_h */
