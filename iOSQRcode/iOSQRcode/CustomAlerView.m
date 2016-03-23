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
@property (strong, nonatomic) UIView *maskView;

@end

@implementation CustomAlerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupView];
    }
    return self;
}

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
    
    _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _maskView.backgroundColor = [UIColor clearColor];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_maskView];
    
    _alertView = [[UIView alloc] init];
    _alertView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 40, 40);
    _alertView.center = _maskView.center;
    _alertView.backgroundColor = [UIColor redColor];
    
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
    
    for (NSInteger i = 0; i < 2; i ++)
    {
        CGFloat btnW = 100;
        CGFloat x = 15 + 50 + btnW * i;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, CGRectGetMaxY(_contentLab.frame) + 10, btnW, 50);
        [btn setTitle:btnTitle[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_alertView addSubview:btn];
    }
    [_maskView addSubview:_alertView];
}

- (nullable id)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message clickAction:(void(^ __nullable)(NSInteger index))click
{
    if (self = [super init])
    {
        [self setupView];
        _titleLab.text = title;
        _contentLab.text = message;
        
        [self restFrame];
    }
    return self;
}

- (void)restFrame
{
    
}

@end
