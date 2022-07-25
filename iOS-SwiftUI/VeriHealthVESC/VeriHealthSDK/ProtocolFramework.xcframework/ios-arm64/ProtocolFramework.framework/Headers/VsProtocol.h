//
//  VsProtocol.h
//  ProtocolFramework
//
//  Created by Alex Lin on 2021/7/21.
//

#ifndef VsProtocol_h
#define VsProtocol_h

/** @defgroup ProtocolFramework ProtocolFramework
 *  ProtocolFramework is responsible for parsing and encapsulating private Bluetooth packets.
 */

/** @addtogroup VsProtocol
 *  @ingroup ProtocolFramework
 *  @{
 */

#import <Foundation/Foundation.h>
#import <BaseFramework/BaseFramework.h>

NS_ASSUME_NONNULL_BEGIN

@class VsProtocol;

/**
 * @brief Delegate method for data transfer protocol
 */
@protocol VsProtocolDelegate <NSObject>

@optional
/**
 * @brief Transfer protocol delegate for sensor raw data
 *
 * @param device The device of data source
 * @param frame Frame of sensor raw data
 */
- (void)protoReceiveRawData:(id)device dataFrame:(RawDataFrame *)frame;

/**
 * @brief Transfer protocol delegate for result data
 *
 * @param device The device of data source
 * @param frame Frame result data
 */
- (void)protoReceiveResultData:(id)device dataFrame:(ResultDataFrame *)frame;

/**
 * @brief Transfer protocol delegate for vs message
 *
 * @param device The device of data source
 * @param frame Frame of vs message
 */
- (void)protoReceiveVsMessage:(id)device msgFrame:(VsMessageFrame *)frame;

/**
 * @brief Transfer protocol delegate for message payload
 *
 * @param device The device of data source
 * @param frame Frame of message payload
 */
- (void)protoReceiveMsgPayload:(id)device msgFrame:(PayloadFrame *)frame;
@end

@interface VsProtocol : NSObject

@property (nonatomic, weak) id<VsProtocolDelegate> delegate;

/**
 *  @brief Parse the input data
 *  @param device The device of data source
 *  @param data The input data which need to be parsed
 *  @return Return parsed result data
 */
- (int)parse:(id)device Data:(NSData *)data;

/**
 *  @brief Generate command data according to VsProtocol
 *  @param flags The flags which defined by up layer
 *  @param op_code The operate code(command id)
 *  @param params Append params for the op_code
 *  @return The generated data bases on input params
 */
- (NSData *)generate:(uint8_t)flags OpCode:(uint16_t)op_code Params:(NSData *__nullable)params;

@end
NS_ASSUME_NONNULL_END

/** @} */
#endif /* VsProtocol_h */
