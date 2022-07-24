//
//  NSDateAndNSStringConversion.h
//  BaseFramework
//
//  Copyright (C) 2021 VeriSilicon Holdings Co., Ltd.
//

#import <Foundation/Foundation.h>

/** @addtogroup Date
 *  @ingroup Utility
 *  @{
 */

#pragma mark - NSDate to NSString
/**
 *  @brief Convert NSDate to special format NSString
 *  @param date   Input NSDate value
 *  @param format NSString date format. ext:yyyy-MM-dd HH:mm:ss
 *  @return NSString formate date value
 */
NSString *convertNSDateToFormatNSString(NSDate *date, NSString *format);

/**
 *  @brief Convert NSDate to NSString with format yyyy-MM-dd HH:mm:ss
 *  @param date Input NSDate value
 *  @return NSString date value
 */
NSString *convertNSDateToStandString(NSDate *date);

/**
 *  @brief Convert NSDate to NSString with format HH:mm:ss
 *  @param date Input NSDate value
 *  @return NSString date value
 */
NSString *convertNSDateToShortNSString(NSDate *date);

#pragma mark - NSString to NSDate
/**
 *  @brief Convert NSString to NSDate with given format
 *  @param stringDate Input a string representing the date
 *  @param format Input date format
 *  @return Formatted date
 */
NSDate *convertNSStringToNSDate(NSString *stringDate, NSString *format);

/** @} */
