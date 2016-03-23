//
//  QRcodeView.h
//  iOSQRcode
//
//  Created by ymq on 16/3/21.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    QRScanResultType_Succeed,
    QRScanResultType_Fail,
} QRScanResultType;

@interface QRcodeView : UIView

@property (copy, nonatomic) void(^scanResult)(QRScanResultType type, NSString *result);

- (void)startReading;

- (void)stopReading;

@end
