//
//  AutoReadBottomView.h
//  LSYReader
//
//  Created by ymq on 2017/12/6.
//  Copyright © 2017年 okwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSYMenuView.h"
@protocol LSYMenuViewDelegate;

@interface AutoReadBottomView : UIView

@property (nonatomic,weak) id<LSYMenuViewDelegate> delegate;

@end
