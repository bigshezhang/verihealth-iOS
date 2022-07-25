//
//  VsMessageFrame.h
//  BaseFramework
//
//  Created by Alex Lin on 2021/7/27.
//

#ifndef VsMessageFrame_h
#define VsMessageFrame_h

/** @addtogroup DataFrame
 *  @ingroup BaseFramework
 *  @{
 */

@interface VsMessageFrame : NSObject

@property (nonatomic) uint8_t category;
@property (nonatomic) uint16_t msg_id;
@property (nonatomic) BOOL is_req_ack;
@property (nonatomic) BOOL is_get_msg;
@property (nonatomic) BOOL is_encrypted;
@property (strong, nonatomic) NSData *payload;

@end

/** @} */
#endif /* VsMessageFrame_h */
