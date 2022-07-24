//
//  MessageUtility.h
//  CoreSDK
//
//  Created by Kaili Lu on 2022/6/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageUtility : NSObject

/**
 * @struct Message Infomation List
 * @brief Message params structure
 */
typedef struct MessageInfo {
    uint16_t msg_id; /**<Message id list*/
    uint16_t size; /**<Message data struct size list*/
    char *name; /**<Message name list*/
} MessageInfo;

/**
 *  @brief get message id list
 *  @return id  list
 */
+ (NSData *)getMsgIdList;

/**
 *  @brief get message size list
 *  @return size  list
 */
+ (NSData *)getMsgSizeList;

/**
 *  @brief get message name list
 *  @return size  list
 */
+ (NSArray *)getMsgNameList;

/**
 *  @brief get message size from table
 *  @param msgId message opcode
 *  @return size  value
 */
+ (uint16_t)getMsgSize:(uint16_t)msgId;

/**
 *  @brief get message name  from table
 *  @param msgId message opcode
 *  @return message name
 */
+ (NSString *)getMsgName:(uint16_t)msgId;

@end

NS_ASSUME_NONNULL_END
