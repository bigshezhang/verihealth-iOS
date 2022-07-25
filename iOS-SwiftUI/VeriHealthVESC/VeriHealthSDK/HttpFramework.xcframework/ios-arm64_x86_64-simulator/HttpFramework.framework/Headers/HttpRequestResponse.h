//
//  HttpRequestResponse.h
//  HttpFramework
//
//  Created by Alex Lin on 2021/9/23.
//

#ifndef HttpRequestResponse_h
#define HttpRequestResponse_h

/** @addtogroup HttpRequestResponse
 *  HttpRequestResponse encapsulates the parameters to be carried by the HTTP response.
 *  @ingroup HttpFramework
 *  @{
 */

#import "HttpRequestParams.h"

@interface HttpRequestResponse : NSObject

@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, assign) RequestID requestID;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSError *error;
@property (nonatomic) NSInteger msgid;

+ (HttpRequestResponse *)responseWithCode:(NSInteger)statusCode
                                requestID:(RequestID)requestID
                                     data:(id)data;

@end

/** @} */
#endif /* HttpRequestResponse_h */
