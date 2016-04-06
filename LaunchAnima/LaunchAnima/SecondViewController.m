//
//  SecondViewController.m
//  Test
//
//  Created by ymq on 16/3/29.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"
@import CoreText;

@interface SecondViewController ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageViewaa;
@property (nonatomic, strong) CAShapeLayer *imageLayer;
@property (nonatomic, strong) CAShapeLayer *layer;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bgImageView.image = [UIImage imageNamed:@"luanchBg"];
    [self.view addSubview:_bgImageView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 400, 20)];
    
    _label.text = @"聚美优品，您的选择，1990，abcd";
    _label.backgroundColor = [UIColor clearColor];
    NSString *aaapath = [[NSBundle mainBundle] pathForResource:@"nobel-regular" ofType:@"ttf"];
    _label.font = [self customFontWithPath:aaapath size:16.0];
    [_label sizeToFit];
    
    [self.view addSubview:_label];
    
    _layer = [CAShapeLayer layer];
    CGRect frame = _label.frame;
    frame.size.width = 0;
    _layer.frame = frame;
    _layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:_layer];
    
    _layer.mask = _label.layer;
    
    _label.frame = CGRectMake(0, 0, 400, frame.size.height);
    
//    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(changeWith) userInfo:nil repeats:YES];
    
    
//    _showView = [[UIView alloc] initWithFrame:CGRectMake(10, 200, 0, 40)];
//    _showView.backgroundColor = [UIColor clearColor];
//    _showView.clipsToBounds = YES;
//    
//    UILabel *aalabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 40)];
//    aalabel.backgroundColor = [UIColor clearColor];
//    aalabel.text = @"聚美优品，您的选择，1990，abcd";
//    aalabel.textColor = [UIColor redColor];
//    [_showView addSubview:aalabel];
//    
//    [self.view addSubview:_showView];
    
//    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(changeWitha) userInfo:nil repeats:YES];
    
    CGFloat scaleW = SCREEN_WIDTH / 320.0;
    CGFloat offsetX = (176 - 14) * scaleW;
    
    CGFloat width = SCREEN_WIDTH - offsetX;
    CGFloat height = 25.5 / 158.5 * width;
    
    CGFloat offsetY = SCREEN_HEIGHT / 2.0 - height / 2.0;
    
    _showView = [[UIView alloc] initWithFrame:CGRectMake(offsetX / 2.0, offsetY, 0, height)];


    _showView.backgroundColor = [UIColor clearColor];
    _showView.clipsToBounds = YES;
    
    
    _imageViewaa = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _imageViewaa.image = [UIImage imageNamed:@"luanchIcon"];
    [_showView addSubview:_label];
    
    [self.view addSubview:_showView];
    
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(changeWitha) userInfo:nil repeats:YES];
    
}

- (void)changeWith
{
    CGRect frame = _layer.frame;
    frame.size.width += 10;
    _layer.frame = frame;
}

- (void)changeWitha
{
    CGRect frame = _showView.frame;
    frame.size.width += 10;
    _showView.frame = frame;
    
    if (frame.size.width >= _bgImageView.frame.size.width)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(UIFont*)customFontWithPath:(NSString*)path size:(CGFloat)size
{
    NSURL *fontUrl = [NSURL fileURLWithPath:path];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    UIFont *font = [UIFont fontWithName:fontName size:size];
    CGFontRelease(fontRef);
    return font;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AppDelegatePro
- (void)click:(NSString *)aaaa
{
    NSLog(@"%@",aaaa);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
