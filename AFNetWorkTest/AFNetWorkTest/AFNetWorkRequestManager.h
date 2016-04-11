//
//
//  Created by mac on 16-03-07.
//  Copyright (c) 2015年 ymq. All rights reserved.


#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>
typedef void(^ResultBlock)(id responseobject,NSError *error);
typedef void(^DownloadBlock)(id responseo,id filepath,NSError *error, CGFloat progress);
typedef void(^UploadBlock)(NSURLSessionDataTask *task, id responseObject, NSError *error, CGFloat progress);
typedef NS_ENUM(NSInteger, RequestType1) {
    RequestPostType,
    RequestGetType
};
@interface AFNetWorkRequestManager : NSObject

-(void)requestUrl:(NSString *)urlString requestType:(RequestType1)type parameters:(NSDictionary *)parameters requestblock:(ResultBlock)resultBlock;
-(void)downloadWithrequest:(NSString *)urlString downloadpath:(NSString *)downloadpath downloadblock:(DownloadBlock)downloadblock;
-(void)uploadImage:(NSDictionary *)dic uploadpath:(NSString *)uploadpath imageData:(NSData *)imagData uploadblock:(UploadBlock)uploadblock;
@end
