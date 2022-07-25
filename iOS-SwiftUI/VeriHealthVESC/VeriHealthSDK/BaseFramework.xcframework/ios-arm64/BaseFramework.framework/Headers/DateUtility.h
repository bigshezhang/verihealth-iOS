//
//  DateUtility.h
//  BaseFramework
//
//  Copyright (C) 2021 VeriSilicon Holdings Co., Ltd.
//

/** @defgroup Utility Utility
 *  Utility functions.
 *  @ingroup BaseFramework
 */

/** @addtogroup Date
 *  Date-related utility functions
 *  @ingroup Utility
 *  @{
 */

#import <Foundation/Foundation.h>

/**
 *  @brief Convert current date to UTC date
 *  @param localDate Current date value
 *  @return UTC date value
 */
NSDate *getUTCDateFromDate(NSDate *localDate);

/**
 * @brief Convert second to NSString with format 00:00:00
 * @param seconds Input second
 * @return HH:mm:ss format string
 */
NSString *convertSecondToShortNSString(NSUInteger seconds);

/**
 * @brief Get current UTC from system
 * @return UTC in ms
 */
uint64_t getCurrentUTC(void);

/**
 * @brief Get today 0`clock UTC from system
 * @return UTC in ms
 */
uint64_t getZeroTodayUTC(void);

/**
 * @brief Get a date string in the given format according to the timestamp (in s)
 * @return Date string
 */
NSString *getDateStringWithTimestamp(uint64_t timestamp, NSString *formatStr);

/**
 * @brief Get a date string in the given format according to the given date
 * @return Date string
 */
NSString *getStrFromDate(NSDate *date, NSString *formatStr);

/**
 * @brief Get a date from string in the given format
 * @return Date
 */
NSDate *getDateFromStr(NSString *dateStr, NSString *formatStr);

/** @} */

Boolean isExpired(void);
