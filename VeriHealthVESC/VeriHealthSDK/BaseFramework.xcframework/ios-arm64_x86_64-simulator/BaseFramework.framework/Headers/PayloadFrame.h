//
//  PayloadFrame.h
//  BaseFramework
//
//  Created by Alex Lin on 2021/9/7.
//

#ifndef PayloadFrame_h
#define PayloadFrame_h

/** @addtogroup DataFrame
 *  Basic data frame definitions.
 *  @ingroup BaseFramework
 *  @{
 */

@interface PayloadFrame : NSObject

@property (nonatomic) uint8_t flags;
@property (nonatomic) uint16_t opcode;
@property (nonatomic) BOOL is_ack;
@property (strong, nonatomic) NSData *payload;

@end

/** @} */
#endif /* PayloadFrame_h */
