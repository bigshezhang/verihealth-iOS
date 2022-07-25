//
//  FileDownload.h
//  HttpFramework
//
//  Created by Alex Lin on 2021/9/2.
//

#ifndef FileDownload_h
#define FileDownload_h

/** @addtogroup FileDownload
 *  @ingroup HttpFramework
 *  @{
 */

#import <BaseFramework/BaseFramework.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileDownload : NSObject

- (void)download:(NSString *)downloadUrl
       StorePath:(NSString *)storePath
        Progress:(void (^)(float progress))progress
        Complete:(void (^)(NSError *_Nullable error))complete;

- (void)cancelDownload;

@end

NS_ASSUME_NONNULL_END

/** @} */
#endif /* FileDownload_h */
