//
//  YSWFindNewVersionView.h
//  LoadingAnimationDemo
//
//  Created by ymq on 16/9/9.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define AppID @"950552997"

typedef enum : NSUInteger {
    FindNewVerAlertTypeForce,
    FindNewVerAlertTypeOption,
} FindNewVerAlertType;

@interface YSWFindNewVersionView : UIView

@property (nonatomic, strong) NSString *countryCode;
- (void)showForView:(UIView *)view WithType:(FindNewVerAlertType)type WithInfo:(NSString *)info;

@end
