//
//  YSWSpecialShopSegmentBtn.m
//  SegmentBtn
//
//  Created by ymq on 16/5/9.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "YSWSpecialShopSegmentBtn.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define BUTTONTAG 3422
#define BUTTONICONTAG 1122
#define BUTTONLABELTAG 4411
#define BUTTONLINETAG 2211

@interface YSWSpecialShopSegmentBtn ()

@property (nonatomic, assign) NSInteger currentBtnIndex;

@end

@implementation YSWSpecialShopSegmentBtn

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setStatusForBtnIndex:0];
    }
    return self;
}

- (IBAction)btnClick:(UIButton *)sender
{
    NSInteger btnIndex = sender.tag - BUTTONTAG;
    if (self.currentBtnIndex == btnIndex)
    {
        return;
    }
    self.currentBtnIndex = btnIndex;
    [self setStatusForBtnIndex:btnIndex];
    if (self.segmentClick)
    {
        self.segmentClick(btnIndex);
    }
}

- (void)setStatusForBtnIndex:(NSInteger)btnIndex
{
    UIButton *btn = [self viewWithTag:btnIndex + BUTTONTAG];
    UIImageView *iconImage = [self viewWithTag:BUTTONICONTAG + btnIndex];
    iconImage.highlighted = YES;
    UIView *btnLinView = [self viewWithTag:BUTTONLINETAG + btnIndex];
    btnLinView.backgroundColor = [UIColor redColor];
    UILabel *label = [self viewWithTag:BUTTONLABELTAG + btnIndex];
    label.textColor = [UIColor redColor];
    
    for (NSInteger i = 0; i < 3; i ++)
    {
        UIButton *otherBtn = [self viewWithTag:BUTTONTAG + i];
        if (otherBtn != btn)
        {
            UIImageView *iconImage = [self viewWithTag:BUTTONICONTAG + i];
            iconImage.highlighted = NO;
            UIView *btnLinView = [self viewWithTag:BUTTONLINETAG + i];
            btnLinView.backgroundColor = [UIColor clearColor];
            UILabel *label = [self viewWithTag:BUTTONLABELTAG + i];
            label.textColor = [UIColor blackColor];
        }
    }
}

@end
