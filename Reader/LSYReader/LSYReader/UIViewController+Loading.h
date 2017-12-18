//
//  UIViewController+Loading.h
//  LSYReader
//
//  Created by ymq on 2017/12/15.
//  Copyright © 2017年 okwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleLoadView.h"
@interface UIViewController (Loading)
//显示动画
- (void)showLoadingInView:(UIView*)view;
//隐藏动画
- (void)hideLoad;
@property (nonatomic,strong) CircleLoadView *loadingView;
@end
