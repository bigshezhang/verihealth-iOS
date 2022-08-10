//
//  DataFrame.h
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/28.
//

#ifndef DataFrame_h
#define DataFrame_h

#define VS_REC_MSG1 10000
#define VS_REC_MSG2 10001
#define VS_REC_MSG3 10002
//#define VS_SEND_MSG 10001


#include <stdio.h>

typedef struct MyBleSendPacket {
    uint16_t isMeasuring;
} __attribute((__packed__)) MyBleSendPacket;

typedef struct MyBleRecPacket {
    
    uint16_t ret;
    uint16_t sdnn;
    uint16_t hr;
    uint16_t size;
    uint16_t data[36];
    
} __attribute((__packed__)) MyBleRecPacket;


#endif /* DataFrame_h */
