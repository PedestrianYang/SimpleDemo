//
//  UncaughtExceptionHandler.h
//  UncaughtExceptionHandlerDemo
//
//  Created by ymq on 16/4/12.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;


@interface UncaughtExceptionHandler : NSObject
{
    BOOL dismissed;
}

+ (void)InstallUncaughtExceptionHandler;
+ (NSArray *)backtrace;

void UncaughtExceptionHandlers (NSException *exception);

@end
