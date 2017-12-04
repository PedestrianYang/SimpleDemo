//
//  YSWFindNewVersionView.m
//  LoadingAnimationDemo
//
//  Created by ymq on 16/9/9.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "YSWFindNewVersionView.h"

NSString * const HarpyAppStoreLinkUniversal         = @"http://itunes.apple.com/lookup?id=%@";
NSString * const HarpyAppStoreLinkCountrySpecific   = @"http://itunes.apple.com/lookup?id=%@&country=%@";

@interface YSWFindNewVersionView()

@property (nonatomic, strong) UITextView *infoView;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation YSWFindNewVersionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setViews];
    }
    return self;
}

- (void)setViews
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.center = self.center;
    contentView.bounds = CGRectMake(0, 0, 280, 200);
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 4.5;
    contentView.layer.masksToBounds = YES;
    [self addSubview:contentView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 280, 18)];
    titleLab.textColor = [UIColor redColor];
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.text = @"发现新版本";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.backgroundColor = [UIColor clearColor];
    [contentView addSubview:titleLab];
    
    _infoView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLab.frame) + 4, contentView.bounds.size.width - 40, contentView.bounds.size.height - 90)];
    _infoView.backgroundColor = [UIColor clearColor];
    _infoView.textColor = [UIColor blackColor];
    _infoView.font = [UIFont systemFontOfSize:13.0];
    _infoView.textAlignment = NSTextAlignmentLeft;
    _infoView.editable = NO;
    _infoView.showsVerticalScrollIndicator = NO;
    _infoView.showsHorizontalScrollIndicator = NO;
    [contentView addSubview:_infoView];
    
    _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancleBtn.frame = CGRectMake(50, CGRectGetMaxY(_infoView.frame) + 20, 75, 25);
    _cancleBtn.layer.cornerRadius = 4.5;
    _cancleBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _cancleBtn.layer.borderWidth = 0.5;
    _cancleBtn.layer.masksToBounds = YES;
    [_cancleBtn setTitle:@"下次再说" forState:UIControlStateNormal];
    [_cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_cancleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_cancleBtn];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(CGRectGetMaxX(_cancleBtn.frame) + 30, CGRectGetMaxY(_infoView.frame) + 20, 75, 25);
    _confirmBtn.layer.cornerRadius = 4.5;
    _confirmBtn.layer.masksToBounds = YES;
    _confirmBtn.backgroundColor = [UIColor redColor];
    [_confirmBtn setTitle:@"更新" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_confirmBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_confirmBtn];
}

- (void)showForView:(UIView *)view WithType:(FindNewVerAlertType)type WithInfo:(NSString *)info
{
    __weak typeof(self)bself = self;
    [self performVersionCheckComplete:^(bool shoulfUpdata) {
        if (shoulfUpdata) {
            [view addSubview:bself];
            bself.infoView.text = info;
            switch (type) {
                case FindNewVerAlertTypeForce:
                {
                    bself.cancleBtn.hidden = YES;
                    CGRect confirmBtnFrame = bself.confirmBtn.frame;
                    confirmBtnFrame.origin.x = (280.0 - 75.0) / 2.0;
                    bself.confirmBtn.frame = confirmBtnFrame;
                }
                    break;
                case FindNewVerAlertTypeOption:
                {
                    bself.cancleBtn.hidden = NO;
                    CGRect cancleBtnFrame = bself.cancleBtn.frame;
                    cancleBtnFrame.origin.x = (280.0 - 75.0) / 2.0;
                    bself.cancleBtn.frame = cancleBtnFrame;
                    
                    CGRect confirmBtnFrame = bself.confirmBtn.frame;
                    confirmBtnFrame.origin.x = (280.0 - 75.0) / 2.0;
                    bself.confirmBtn.frame = confirmBtnFrame;
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
    }];
    
}

- (void)performVersionCheckComplete:(void(^)(_Bool shoulfUpdata))complete
{

    NSString *storeString = nil;
    if (self.countryCode) {
        storeString = [NSString stringWithFormat:HarpyAppStoreLinkCountrySpecific, AppID, _countryCode];
    } else {
        storeString = [NSString stringWithFormat:HarpyAppStoreLinkUniversal, AppID];
    }
    
    NSURL *storeURL = [NSURL URLWithString:storeString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:storeURL];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if ([data length] > 0 && !error) { // Success
                                                    
                                                    NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        
                                                    
                                                        NSArray *versionsInAppStore = [[appData valueForKey:@"results"] valueForKey:@"version"];
                                                        
                                                        if ([versionsInAppStore count]) {
                                                            NSString *currentAppStoreVersion = [versionsInAppStore objectAtIndex:0];
                                                            BOOL shouledUpdate = [[self currentVersion] compare:currentAppStoreVersion options:NSNumericSearch] == NSOrderedAscending;
                                                            if (shouledUpdate){
                                                                if (complete) {
                                                                    complete(shouledUpdate);
                                                                }
                                                            }
                                                        }
                                                    });
                                                }
                                            }];
    [task resume];
}


- (NSString *)currentVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}


- (void)btnClick:(UIButton *)btn
{
    if (btn == _confirmBtn)
    {
        NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@",@"950552997"];
        NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
        [[UIApplication sharedApplication] openURL:iTunesURL];
    }
    
    [self removeFromSuperview];
}

@end
