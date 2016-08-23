//
//  ViewController.m
//  LaunchAnima
//
//  Created by ymq on 16/4/5.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@import CoreText;

@interface ViewController ()

@property (nonatomic, strong) CAGradientLayer *gLayer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _gLayer = [CAGradientLayer layer];
    _gLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                       (__bridge id)[UIColor blackColor].CGColor];
    _gLayer.startPoint = CGPointMake(0, 0);
    _gLayer.endPoint = CGPointMake(1, 0);
    _gLayer.locations = @[@(0) ,@(0)];
    
    NSString *aaapath = [[NSBundle mainBundle] pathForResource:@"nobel-regular" ofType:@"ttf"];
    NSString *title = @"聚美优品，您的选择，1990，abcd  ";
    
    CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[self customFontWithPath:aaapath size:16.0]}
                                     context:nil];
    CGFloat width = rect.size.width;
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, width, 20)];
    
    _label.text = title;
    _label.backgroundColor = [UIColor clearColor];
    
    _label.font = [self customFontWithPath:aaapath size:16.0];
    [_label sizeToFit];
    
    [self.view addSubview:_label];
    
    _gLayer.frame = _label.frame;
    _gLayer.mask = _label.layer;
    
    [self.view.layer addSublayer:_gLayer];
    
    _label.frame = CGRectMake(0, 0, width, 20);
    
    
    //    [self performSelector:@selector(playAtion) withObject:nil afterDelay:0];
    CGPoint start = _gLayer.startPoint;
    start.x = 0.98f;
    CAAnimation *animation1 = [self animationMoveFrom:_gLayer.startPoint To:start Duration:2 BeginTime:0];
    
    CGPoint start1 = start;
    start1.x = 0.5f;
    CAAnimation *animation2 = [self animationMoveFrom:start To:start1 Duration:1 BeginTime:2];
    CAAnimationGroup *group=[CAAnimationGroup animation];
    
    group.animations = [NSArray arrayWithObjects:animation1, animation2, nil];
    
    group.duration = 5;
    group.removedOnCompletion = NO;//动画结束了禁止删除
    group.fillMode = kCAFillModeForwards;//停在动画结束处
    group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_gLayer addAnimation:group forKey:nil];
    
    NSMutableArray *arr = [@[@"asdasd",@"dasd",@"ddd",@"dasd",@"wqe11",@"111"] mutableCopy];
    NSMutableArray *arr1 = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 2; i ++) {
        [arr1 addObject:arr[i]];
    }
    NSLog(@"%@",arr1);
    NSString *str = arr[0];
    str = nil;
    NSLog(@"%@",arr1);
    
}

- (CAAnimation *)animationMoveFrom:(CGPoint) from To:(CGPoint) to Duration:(CGFloat) duration BeginTime:(CGFloat)beginTime

{
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"startPoint.x"];
    
    CGFloat animationDuration = duration;
    
    bounceAnimation.values = @[@(from.x),@(to.x)];
    bounceAnimation.duration = animationDuration;
    
    bounceAnimation.beginTime = beginTime;
    
    bounceAnimation.repeatCount = 0;
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    bounceAnimation.removedOnCompletion = NO;//动画结束了禁止删除
    bounceAnimation.fillMode = kCAFillModeForwards;//停在动画结束处
    
    
    return bounceAnimation;
    
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

- (void)playAtion
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeWidth) userInfo:nil repeats:YES];
}

- (void)changeWidth
{
    CGPoint start = _gLayer.startPoint;
    start.x += 0.1;
    CGPoint end = _gLayer.endPoint;
    if (start.x >= 1)
    {
        start.x = 1.0;
    }
    
    _gLayer.startPoint = start;
    _gLayer.endPoint = end;
    
    
}

- (IBAction)btnClick:(UIButton *)sender
{
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
