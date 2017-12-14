//
//  SoundReadBottomView.m
//  LSYReader
//
//  Created by ymq on 2017/12/13.
//  Copyright © 2017年 okwei. All rights reserved.
//

#import "SoundReadBottomView.h"

@interface SoundReadBottomView()

@property (nonatomic, strong) UIButton *increaseSpeed;
@property (nonatomic, strong) UIButton *decreaseSpeed;
@property (nonatomic, strong) UILabel *speedLab;
@property (nonatomic, assign) NSInteger speed;

@end

@implementation SoundReadBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _speed = 10;
        [self setup];
        
    }
    return self;
}
- (void)setup{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    [self addSubview:self.increaseSpeed];
    [self addSubview:self.decreaseSpeed];
    [self addSubview:self.speedLab];
}

- (UIButton *)increaseSpeed{
    if (!_increaseSpeed) {
        _increaseSpeed = [LSYReadUtilites commonButtonSEL:@selector(increaseSpeedClick) target:self];
        [_increaseSpeed setTitle:@"加速 +" forState:UIControlStateNormal];
        _increaseSpeed.layer.cornerRadius = 3;
        _increaseSpeed.layer.borderWidth = 1;
        _increaseSpeed.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _increaseSpeed;
}


- (UIButton *)decreaseSpeed{
    if (!_decreaseSpeed) {
        _decreaseSpeed = [LSYReadUtilites commonButtonSEL:@selector(decreaseSpeedClick) target:self];
        [_decreaseSpeed setTitle:@"减速 -" forState:UIControlStateNormal];
        _decreaseSpeed.layer.cornerRadius = 3;
        _decreaseSpeed.layer.borderWidth = 1;
        _decreaseSpeed.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _decreaseSpeed;
}


- (UILabel *)speedLab{
    if (!_speedLab) {
        _speedLab = [[UILabel alloc] init];
        _speedLab.text = [NSString stringWithFormat:@"%@", @(_speed)];
        _speedLab.backgroundColor = [UIColor clearColor];
        _speedLab.textColor = [UIColor whiteColor];
        _speedLab.font = [UIFont systemFontOfSize:12];
        _speedLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return _speedLab;
}

- (void)increaseSpeedClick{
    if ([self.delegate respondsToSelector:@selector(autoReadSpeedIncrease:)]) {
        _speed ++;
        if (_speed > 10) {
            _speed = 10;
            return;
        }
        _speedLab.text = [NSString stringWithFormat:@"%@", @(_speed)];
        [self.delegate autoReadSpeedIncrease:_speed];
    }
}

- (void)decreaseSpeedClick{
    if ([self.delegate respondsToSelector:@selector(autoReadSpeedDecrease:)]) {
        _speed --;
        if (_speed < 1) {
            _speed = 1;
            return;
        }
        
        _speedLab.text = [NSString stringWithFormat:@"%@", @(_speed)];
        [self.delegate autoReadSpeedDecrease:_speed];
    }
}

- (void)stopClick{
    if ([self.delegate respondsToSelector:@selector(stopAutoRead)]) {
        [self.delegate stopAutoRead];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _decreaseSpeed.frame = CGRectMake((ScreenSize.width - 100.0)/3.0, 20, 50, 30);
    _increaseSpeed.frame = CGRectMake((ScreenSize.width - 100.0)/3.0 * 2 + 50 , 20, 50, 30);
    _speedLab.frame = CGRectMake(CGRectGetMaxX(_decreaseSpeed.frame), _decreaseSpeed.frame.origin.y, (ScreenSize.width - 100.0)/3.0, 30);
}

@end
