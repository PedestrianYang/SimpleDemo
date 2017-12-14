//
//  LSYMenuView.m
//  LSYReader
//
//  Created by Labanotation on 16/6/1.
//  Copyright © 2016年 okwei. All rights reserved.
//

#import "LSYMenuView.h"
#import "LSYTopMenuView.h"
#import "LSYBottomMenuView.h"
#define AnimationDelay 0.3f
#define TopViewHeight 64.0f
#define BottomViewHeight 200.0f
#define AutoReadBottomViewHeight 150.0f
#define SoundReadBottomViewHeight 90.0f
@interface LSYMenuView ()<LSYMenuViewDelegate>{
    MenuViewType _type;
}

@end
@implementation LSYMenuView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _type = MenuViewTypeNormal;
        [self setup];
    }
    return self;
}
-(void)setup
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    [self addSubview:self.autoReadBottomView];
    [self addSubview:self.soundReadBottomView];
    [self addSubview:self.soundReadBtn];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSelf)]];
}
-(LSYTopMenuView *)topView
{
    if (!_topView) {
        _topView = [[LSYTopMenuView alloc] initWithFrame:CGRectMake(0, -TopViewHeight, ScreenSize.width, TopViewHeight)];
        _topView.delegate = self;
    }
    return _topView;
}
-(LSYBottomMenuView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[LSYBottomMenuView alloc] initWithFrame:CGRectMake(0, ScreenSize.height, ScreenSize.width,BottomViewHeight)];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

-(AutoReadBottomView *)autoReadBottomView
{
    if (!_autoReadBottomView) {
        _autoReadBottomView = [[AutoReadBottomView alloc] initWithFrame:CGRectMake(0, ScreenSize.height, ScreenSize.width,AutoReadBottomViewHeight)];
        _autoReadBottomView.delegate = self;
    }
    return _autoReadBottomView;
}

-(SoundReadBottomView *)soundReadBottomView
{
    if (!_soundReadBottomView) {
        _soundReadBottomView = [[SoundReadBottomView alloc] initWithFrame:CGRectMake(0, ScreenSize.height, ScreenSize.width,SoundReadBottomViewHeight)];
        _soundReadBottomView.delegate = self;
    }
    return _soundReadBottomView;
}

-(UIButton *)soundReadBtn
{
    if (!_soundReadBtn) {
        _soundReadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _soundReadBtn.frame = CGRectMake(ScreenSize.width - 40, ScreenSize.height - BottomViewHeight - 30 - 20, 30, 30);
        _soundReadBtn.backgroundColor = [UIColor blackColor];
        _soundReadBtn.alpha = 0.6;
        [_soundReadBtn setTitle:@"关" forState:UIControlStateSelected];
        [_soundReadBtn setTitle:@"开" forState:UIControlStateNormal];
        [_soundReadBtn addTarget:self action:@selector(soundReadStart:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _soundReadBtn;
}

-(void)setRecordModel:(LSYRecordModel *)recordModel
{
    _recordModel = recordModel;
    _bottomView.readModel = recordModel;
}

-(void)soundReadStart:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        _type = MenuViewTypeSoundRead;
        [self hiddenSelf];
    }else{
        _type = MenuViewTypeNormal;
         [self showAnimation:YES];
    }
    if ([self.delegate respondsToSelector:@selector(soundReadOpen:)]) {
        [self.delegate soundReadOpen:btn.selected];
    }
   
}

#pragma mark - LSYMenuViewDelegate

-(void)menuViewInvokeCatalog:(LSYBottomMenuView *)bottomMenu
{
    if ([self.delegate respondsToSelector:@selector(menuViewInvokeCatalog:)]) {
        [self.delegate menuViewInvokeCatalog:bottomMenu];
    }
}
-(void)menuViewJumpChapter:(NSUInteger)chapter page:(NSUInteger)page
{
    if ([self.delegate respondsToSelector:@selector(menuViewJumpChapter:page:)]) {
        [self.delegate menuViewJumpChapter:chapter page:page];
    }
}
-(void)menuViewFontSize:(LSYBottomMenuView *)bottomMenu
{
    if ([self.delegate respondsToSelector:@selector(menuViewFontSize:)]) {
        [self.delegate menuViewFontSize:bottomMenu];
    }
}
-(void)menuViewMark:(LSYTopMenuView *)topMenu
{
    if ([self.delegate respondsToSelector:@selector(menuViewMark:)]) {
        [self.delegate menuViewMark:topMenu];
    }
}

-(void)autoReadAction:(NSNumber *)speed
{
    if ([self.delegate respondsToSelector:@selector(autoReadAction:)]) {
        [self.delegate autoReadAction:speed];
    }
    _type = MenuViewTypeAutoRead;
    
    [self autoReadBottomViewShowAnimation:YES];
    
    
}

-(void)stopAutoRead{
    _type = MenuViewTypeNormal;
    if ([self.delegate respondsToSelector:@selector(stopAutoRead)]) {
        [self.delegate stopAutoRead];
    }
    [self showAnimation:YES];
}

- (void)autoReadSpeedIncrease:(NSInteger)speed{
    if ([self.delegate respondsToSelector:@selector(autoReadChangeSpeed:)]) {
        [self.delegate autoReadChangeSpeed:speed];
    }
}

- (void)autoReadSpeedDecrease:(NSInteger)speed{
    if ([self.delegate respondsToSelector:@selector(autoReadChangeSpeed:)]) {
        [self.delegate autoReadChangeSpeed:speed];
    }
}


#pragma mark -
-(void)hiddenSelf
{
    [self hiddenAnimation:YES];
}
-(void)showAnimation:(BOOL)animation
{
    _soundReadBtn.hidden = NO;
    if (_type == MenuViewTypeNormal) {
        self.hidden = NO;
        [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
            _topView.frame = CGRectMake(0, 0, ScreenSize.width, TopViewHeight);
            _bottomView.frame = CGRectMake(0, ScreenSize.height-BottomViewHeight, ScreenSize.width,BottomViewHeight);
            _autoReadBottomView.frame = CGRectMake(0, ScreenSize.height, ScreenSize.width,AutoReadBottomViewHeight);
            _soundReadBottomView.frame = CGRectMake(0, ScreenSize.height, ScreenSize.width,SoundReadBottomViewHeight);
        } completion:^(BOOL finished) {
            
        }];
        if ([self.delegate respondsToSelector:@selector(menuViewDidAppear:)]) {
            [self.delegate menuViewDidAppear:self];
        }
    }else if(_type == MenuViewTypeAutoRead){
        _soundReadBtn.hidden = YES;
        [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
            _autoReadBottomView.frame = CGRectMake(0, ScreenSize.height - AutoReadBottomViewHeight, ScreenSize.width,AutoReadBottomViewHeight);
        } completion:^(BOOL finished) {
        }];
    }
    else if(_type == MenuViewTypeSoundRead){
        [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
            _soundReadBottomView.frame = CGRectMake(0, ScreenSize.height - SoundReadBottomViewHeight, ScreenSize.width,SoundReadBottomViewHeight);
        } completion:^(BOOL finished) {
        }];
    }
    
}
-(void)hiddenAnimation:(BOOL)animation
{
    _soundReadBtn.hidden = YES;
    if (_type == MenuViewTypeNormal) {
        [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
            _topView.frame = CGRectMake(0, -TopViewHeight, ScreenSize.width, TopViewHeight);
            _bottomView.frame = CGRectMake(0, ScreenSize.height, ScreenSize.width,BottomViewHeight);
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
        if ([self.delegate respondsToSelector:@selector(menuViewDidHidden:)]) {
            [self.delegate menuViewDidHidden:self];
        }
    }else if(_type == MenuViewTypeAutoRead){
        
        BOOL viewHiden = _autoReadBottomView.frame.origin.y == ScreenSize.height ? YES : NO;
        if (viewHiden) {
            [self autoReadBottomViewShowAnimation:YES];
        }else{
            [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
                _autoReadBottomView.frame = CGRectMake(0, ScreenSize.height, ScreenSize.width,AutoReadBottomViewHeight);
            } completion:^(BOOL finished) {
                self.hidden = NO;
            }];
        }
    }else if (_type == MenuViewTypeSoundRead){
        BOOL viewHiden = _soundReadBottomView.frame.origin.y == ScreenSize.height ? YES : NO;
        if (viewHiden) {
            [self soundReadBottomViewShowAnimation:YES];
        }else{
            [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
                _soundReadBottomView.frame = CGRectMake(0, ScreenSize.height, ScreenSize.width,SoundReadBottomViewHeight);
            } completion:^(BOOL finished) {
                self.hidden = NO;
            }];
        }
        
    }
}

-(void)autoReadBottomViewShowAnimation:(BOOL)animation
{
    [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
        _topView.frame = CGRectMake(0, -TopViewHeight, ScreenSize.width, TopViewHeight);
        _bottomView.frame = CGRectMake(0, ScreenSize.height, ScreenSize.width,BottomViewHeight);
        _soundReadBottomView.frame = CGRectMake(0, ScreenSize.height, ScreenSize.width,SoundReadBottomViewHeight);
        _autoReadBottomView.frame = CGRectMake(0, ScreenSize.height - AutoReadBottomViewHeight, ScreenSize.width,AutoReadBottomViewHeight);
    } completion:^(BOOL finished) {
        self.hidden = NO;
    }];
    
    if ([self.delegate respondsToSelector:@selector(menuViewDidHidden:)]) {
        [self.delegate menuViewDidHidden:self];
    }
}

-(void)soundReadBottomViewShowAnimation:(BOOL)animation
{
    _soundReadBtn.hidden = NO;
    [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
        _topView.frame = CGRectMake(0, -TopViewHeight, ScreenSize.width, TopViewHeight);
        _bottomView.frame = CGRectMake(0, ScreenSize.height, ScreenSize.width,BottomViewHeight);
        _autoReadBottomView.frame = CGRectMake(0, ScreenSize.height, ScreenSize.width,AutoReadBottomViewHeight);
        _soundReadBottomView.frame = CGRectMake(0, ScreenSize.height - SoundReadBottomViewHeight, ScreenSize.width,SoundReadBottomViewHeight);
    } completion:^(BOOL finished) {
        self.hidden = NO;
    }];
    
    if ([self.delegate respondsToSelector:@selector(menuViewDidHidden:)]) {
        [self.delegate menuViewDidHidden:self];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (@available(iOS 11.0, *)){
        // do nothing.
        // looks the layout of view in iOS 11 is different with iOS 10.
    } else {
        _topView.frame = CGRectMake(0, -TopViewHeight, ViewSize(self).width,TopViewHeight);
        _bottomView.frame = CGRectMake(0, ViewSize(self).height, ViewSize(self).width,BottomViewHeight);
        _autoReadBottomView.frame = CGRectMake(0, ViewSize(self).height, ViewSize(self).width,AutoReadBottomViewHeight);
        _soundReadBtn.frame = CGRectMake(ScreenSize.width - 40, ScreenSize.height - BottomViewHeight - 30 - 20, 30, 30);
    }
    
    

}
@end
