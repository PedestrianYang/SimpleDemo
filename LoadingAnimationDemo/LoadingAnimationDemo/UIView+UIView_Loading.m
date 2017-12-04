//
//  UIView+UIView_Loading.m
//  LoadingAnimationDemo
//
//  Created by ymq on 16/9/7.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "UIView+UIView_Loading.h"

@implementation UIView (UIView_Loading)

- (void)startLoading
{
    UIView *bgView = [self viewWithTag:223311];
    
    UIImageView *loadingImg = [bgView viewWithTag:223311];
    if (!bgView) {
        bgView  = [[UIView alloc] init];
        bgView.bounds = CGRectMake(0, 0, 40, 40);
        bgView.tag = 223311;
        bgView.center = self.center;
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
       loadingImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loadRangle"]];
        loadingImg.frame = CGRectMake((40 - 29.5) / 2, (40 - 29.5) / 2, 29.5, 29.5);
        loadingImg.tag = 223311;
        [bgView addSubview:loadingImg];
        
        [self addSubview:bgView];
    }
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = NSIntegerMax;
    
    [loadingImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopLoading
{
    UIView *bgView = [self viewWithTag:223311];
    UIImageView *loadingImg = [bgView viewWithTag:223311];
    [loadingImg.layer removeAllAnimations];
}

@end
