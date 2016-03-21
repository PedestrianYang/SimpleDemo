//
//  QRcodeView.h
//  iOSQRcode
//
//  Created by ymq on 16/3/21.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QRcodeView : UIView

@property (copy, nonatomic) void(^scanResult)(NSString *result);

- (void)startReading;

- (void)stopReading;

@end
