//
//  LSYMenuView.h
//  LSYReader
//
//  Created by Labanotation on 16/6/1.
//  Copyright © 2016年 okwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSYRecordModel.h"
#import "LSYTopMenuView.h"
#import "AutoReadBottomView.h"
#import "SoundReadBottomView.h"
@class LSYMenuView;
@class LSYBottomMenuView;
@class AutoReadBottomView;
@class SoundReadBottomView;
@protocol LSYMenuViewDelegate <NSObject>
@optional
-(void)menuViewDidHidden:(LSYMenuView *)menu;
-(void)menuViewDidAppear:(LSYMenuView *)menu;
-(void)menuViewInvokeCatalog:(LSYBottomMenuView *)bottomMenu;
-(void)menuViewJumpChapter:(NSUInteger)chapter page:(NSUInteger)page;
-(void)menuViewFontSize:(LSYBottomMenuView *)bottomMenu;
-(void)menuViewMark:(LSYTopMenuView *)topMenu;
-(void)autoReadAction:(NSNumber *)speed;
-(void)autoReadSpeedIncrease:(NSInteger)speed;
-(void)autoReadSpeedDecrease:(NSInteger)speed;
-(void)autoReadChangeSpeed:(NSInteger)speed;
-(void)stopAutoRead;
-(void)soundReadOpen:(BOOL)open;
@end

typedef enum : NSUInteger {
    MenuViewTypeNormal,
    MenuViewTypeAutoRead,
    MenuViewTypeSoundRead,
} MenuViewType;

@interface LSYMenuView : UIView
@property (nonatomic,weak) id<LSYMenuViewDelegate> delegate;
@property (nonatomic,strong) LSYRecordModel *recordModel;
@property (nonatomic,strong) LSYTopMenuView *topView;
@property (nonatomic,strong) LSYBottomMenuView *bottomView;
@property (nonatomic,strong) AutoReadBottomView *autoReadBottomView;
@property (nonatomic,strong) SoundReadBottomView *soundReadBottomView;
@property (nonatomic,strong) UIButton *soundReadBtn;
-(void)showAnimation:(BOOL)animation;
-(void)hiddenAnimation:(BOOL)animation;
@end
