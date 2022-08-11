//
//  DataFrame.h
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/28.
//

#ifndef DataFrame_h
#define DataFrame_h

#define VS_REC_Result 10000
#define VS_REC_RawData 10001
#define VS_REC_Lod 10002
//#define VS_SEND_MSG 10001


#include <stdio.h>

typedef struct MyBleSendPacket {
    uint16_t isMeasuring;
} __attribute((__packed__)) MyBleSendPacket;

typedef struct ResultPacket {
    
    uint16_t ret;
    uint16_t spo2;
    uint16_t loss;
    uint16_t wrong;
    
} __attribute((__packed__)) ResultPacket;

typedef struct RawDataPacket{
    uint16_t size;
    uint16_t data[64];
} __attribute((__packed__)) RawDataPacket;

typedef struct LodPacket{
    uint16_t status;
} __attribute((__packed__)) LodPacket;
#endif /* DataFrame_h */
