//
//  DataFrame.h
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/28.
//

#ifndef DataFrame_h
#define DataFrame_h

#define VS_REC_MSG 0x10000
#define VS_SEND_MSG 0x10001

#include <stdio.h>

typedef struct MyBleSendPacket {
    uint16_t isMeasuring;
} __attribute((__packed__)) MyBleSendPacket;

typedef struct MyBleRecPacket {
    
    uint16_t ret;
    uint16_t sdnn;
    uint16_t hr;
    uint16_t size;
    uint16_t data[64];
    
} __attribute((__packed__)) MyBleRecPacket;


#endif /* DataFrame_h */
