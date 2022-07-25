//
//  DiscUtility.h
//  BaseFramework
//
//  Copyright (C) 2021 VeriSilicon Holdings Co., Ltd.
//

#import <Foundation/Foundation.h>

/** @addtogroup Disc
 *  Disc/Disk-related utility functions.
 *  @ingroup Utility
 *  @{
 */

/**
 *  @brief Get current phone remain device
 *  @return Current device remain space (Bytes value)
 */
NSInteger getDiskFreeSize(void);

/**
 *  @brief Get readable string value of disc space
 *  @return Readable string value for disc space
 */
NSString *getReadableDiscFreeSpace(void);

/** @} */
