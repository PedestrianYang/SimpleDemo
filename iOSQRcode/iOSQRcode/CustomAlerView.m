//
//  CustomAlerView.m
//  iOSQRcode
//
//  Created by ymq on 16/3/22.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "CustomAlerView.h"

@interface CustomAlerView ()

@property (strong, nonatomic) UIView *alertView;
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UILabel *contentLab;
@property (strong, nonatomic) UIView *btnsView;
@property (copy, nonatomic) void (^btnClick)(NSInteger btnIndex);

@end

@implementation CustomAlerView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setupView];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    NSArray *btnTitle = @[@"确定", @"取消"];
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

    
    _alertView = [[UIView alloc] init];
    _alertView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 40, 40);
    _alertView.center = self.center;
    _alertView.backgroundColor = [UIColor redColor];
    
    [self addSubview:_alertView];
    
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, _alertView.bounds.size.width - 40, 25)];
    _titleLab.numberOfLines = 0;
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
    _titleLab.textColor = [UIColor blackColor];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [_alertView addSubview:_titleLab];
    
    _contentLab = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_titleLab.frame) + 10, _alertView.bounds.size.width - 40, 25)];
    _contentLab.numberOfLines = 0;
    _contentLab.backgroundColor = [UIColor clearColor];
    _contentLab.font = [UIFont systemFontOfSize:17];
    _contentLab.textColor = [UIColor blackColor];
    _contentLab.textAlignment = NSTextAlignmentCenter;
    [_alertView addSubview:_contentLab];
    
    _btnsView = [[UIView alloc] init];
    _btnsView.backgroundColor = [UIColor whiteColor];
    [_alertView addSubview:_btnsView];
    
    for (NSInteger i = 0; i < 2; i ++)
    {
        CGFloat btnW = 50;
        CGFloat x = (_alertView.frame.size.width - btnW * 2 - 40) / 2.0 + (btnW + 40) * i;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, 0, btnW, 50);
        [btn setTitle:btnTitle[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnsView addSubview:btn];
    }
    
    
    self.hidden = YES;
}

- (void)btnClick:(UIButton *)btn
{
    [self hindenAlertView];
    if (self.btnClick)
    {
        self.btnClick(btn.tag);
    }
}

- (nullable id)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message clickAction:(void(^ __nullable)(NSInteger index))click
{
    if (self = [super init])
    {
        [self setupView];
        _titleLab.text = title;
        _contentLab.text = message;
        self.btnClick = click;
        [self restFrame];
    }
    return self;
}

- (void)restFrame
{
    CGFloat height = [self heightForString:_titleLab.text WithFont:[UIFont fontWithName:@"Helvetica-Bold" size:20.0] WithWidth:_alertView.bounds.size.width - 40];
    self.titleLab.frame = CGRectMake(20, 10, _alertView.bounds.size.width - 40, height);
    
    height = [self heightForString:_contentLab.text WithFont:[UIFont systemFontOfSize:17] WithWidth:_alertView.bounds.size.width - 40];
    self.contentLab.frame = CGRectMake(20, CGRectGetMaxY(self.titleLab.frame) + 10, _alertView.bounds.size.width - 40, height);
    
    _btnsView.frame = CGRectMake(0, CGRectGetMaxY(self.contentLab.frame) + 10, _alertView.bounds.size.width, 50);
    
    CGRect alertFrame = _alertView.frame;
    alertFrame.size.height = CGRectGetMaxY(_btnsView.frame) + 10;
    _alertView.frame = alertFrame;
}

- (CGFloat)heightForString:(NSString *)str WithFont:(UIFont *)font WithWidth:(CGFloat)width
{
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    CGFloat height = rect.size.height;
    return height;
}

- (void)showAlertView
{
    self.hidden = NO;
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.25;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5f, 0.7f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.alertView.layer addAnimation:popAnimation forKey:nil];
}
- (void)hindenAlertView
{
    CAKeyframeAnimation *hideAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    hideAnimation.duration = 1;
    hideAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.1f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7f, 0.6f, 0.5f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.00f, 0.00f, 0.00f)]];
    hideAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f];
    hideAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    hideAnimation.delegate = self;
    [self.alertView.layer addAnimation:hideAnimation forKey:nil];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    self.hidden = YES;
    [self.alertView removeFromSuperview];
    [self removeFromSuperview];
}

@end
