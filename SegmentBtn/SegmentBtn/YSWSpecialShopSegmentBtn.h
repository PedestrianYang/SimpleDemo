//
//  YSWSpecialShopSegmentBtn.h
//  SegmentBtn
//
//  Created by ymq on 16/5/9.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSWSpecialShopSegmentBtn : UIView

@property (nonatomic, copy) void (^segmentClick)(NSInteger btnIndex);
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftIconH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midIconH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightIconH;

- (void)setStatusForBtnIndex:(NSInteger)btnIndex;

@end
