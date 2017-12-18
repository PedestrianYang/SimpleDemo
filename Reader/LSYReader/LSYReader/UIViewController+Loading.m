//
//  UIViewController+Loading.m
//  LSYReader
//
//  Created by ymq on 2017/12/15.
//  Copyright © 2017年 okwei. All rights reserved.
//

#import "UIViewController+Loading.h"
#import <objc/runtime.h>

@implementation UIViewController (Loading)
- (CircleLoadView*)loadingView
{
    return objc_getAssociatedObject(self, @"loadingView");
}
- (void)setLoadingView:(CircleLoadView*)loadingView
{
    objc_setAssociatedObject(self, @"loadingView", loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)showLoadingInView:(UIView*)view{
    if (self.loadingView == nil) {
        self.loadingView = [[CircleLoadView alloc]init];
    }
    if (view) {
        [view addSubview:self.loadingView];
        self.loadingView.frame = view.bounds;
    }else{
        UIWindow *appKeyWindow = [UIApplication sharedApplication].keyWindow;
        [appKeyWindow addSubview:self.loadingView];
        self.loadingView.frame = appKeyWindow.bounds;
    }
}
- (void)hideLoad{
    [self.loadingView removeFromSuperview];
    self.loadingView = nil;
}
@end
