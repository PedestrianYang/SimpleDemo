//
//  CustomAlerView.h
//  iOSQRcode
//
//  Created by ymq on 16/3/22.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlerView : UIView


- (nullable id)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message clickAction:(void(^ __nullable)(NSInteger index))click;

- (void)showAlertView;
- (void)hindenAlertView;

@end
