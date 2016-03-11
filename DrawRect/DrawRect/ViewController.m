//
//  ViewController.m
//  DrawRect
//
//  Created by ymq on 16/3/9.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "ViewController.h"

typedef enum : NSUInteger {
    ALLSHOW,
    LEFT,
    RIGHT,
} Show_Type;

@interface ViewController ()

@property (assign, nonatomic) Show_Type type;
@property (strong, nonatomic) UIView *dispalyView;

@property (strong, nonatomic) NSMutableArray *pointArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _pointArray = [@[] mutableCopy];
    
    _dispalyView = [[UIView alloc] initWithFrame:self.view.bounds];
    _dispalyView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_dispalyView];
    
    for (NSInteger i = 0; i < 3; i ++)
    {
        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 100, 20)];
        lab1.backgroundColor = [UIColor clearColor];
        lab1.text = @"dasdasd";
        lab1.tag = i + 11111;
        lab1.backgroundColor = [UIColor clearColor];
        lab1.font = [UIFont systemFontOfSize:16];
        
        CAShapeLayer *lablayer1 = [CAShapeLayer layer];
        lablayer1.frame = CGRectMake(-10, 0, lab1.frame.size.width, lab1.frame.size.height);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 10)];
        [path addLineToPoint:CGPointMake(10, 0)];
        [path addLineToPoint:CGPointMake(100, 0)];
        [path addQuadCurveToPoint:CGPointMake(100, 20) controlPoint:CGPointMake(sqrtf(300.0) + 100, 10)];
        [path addLineToPoint:CGPointMake(10, 20)];
        [path addLineToPoint:CGPointMake(0, 10)];
        lablayer1.path = path.CGPath;
        
        
        lablayer1.fillColor = [UIColor clearColor].CGColor;
        lablayer1.strokeColor = [UIColor blackColor].CGColor;
        [lab1.layer addSublayer:lablayer1];
        
        lab1.layer.anchorPoint = CGPointMake(-4.0 / 25.0, 0.5);
        
        
        [self.view addSubview:lab1];
    }
    
    
    
    //    [self start];
    [self start1];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)start
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    //1
    
    path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(175 - 40, 100 - 40, 80, 80) cornerRadius:40];
    layer.path = path.CGPath;
    
    [path moveToPoint:CGPointMake(175 + 10, 100)];
    [path addArcWithCenter:CGPointMake(175, 100) radius:10 startAngle:M_PI endAngle:M_PI clockwise:NO];

    
    //2
    CGPoint startPoint   = CGPointMake(50, 100);
    CGPoint endPoint     = CGPointMake(300, 100);
    CGPoint controlPoint = CGPointMake(175, 10);
    
    
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    
    
    //3
    CGPoint controlPoint2 = CGPointMake(175, 190);
    
    [path moveToPoint:endPoint];
    [path addQuadCurveToPoint:startPoint controlPoint:controlPoint2];
    layer.path = path.CGPath;
    
    [self.view.layer addSublayer:layer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = 10;
    [layer addAnimation:animation forKey:nil];
}

- (void)start1
{
    self.type = ALLSHOW;
    
    UIView *flickerView = [[UIView alloc] init];
    flickerView.bounds = CGRectMake(0, 0, 15, 15);
    flickerView.center = self.view.center;
    
    
    [self.view addSubview:flickerView];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = flickerView.bounds;
    layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7].CGColor;
    layer.cornerRadius = 7.5;
    layer.masksToBounds = YES;
    [flickerView.layer addSublayer:layer];
    
    UIButton *btnChange = [UIButton buttonWithType:UIButtonTypeCustom];
    btnChange.bounds = CGRectMake(0, 0, 10, 10);
    btnChange.center = flickerView.center;
    btnChange.layer.cornerRadius = 5;
    btnChange.layer.masksToBounds = YES;
    btnChange.layer.borderWidth = 2.0;
    btnChange.layer.borderColor = [UIColor whiteColor].CGColor;
    btnChange.backgroundColor = [UIColor redColor];
    [btnChange addTarget:self action:@selector(changeClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnChange];
    
    [layer addAnimation:[self opacityForever_Animation:0.25] forKey:nil];
}


//三条线段同时动画，必须要做三个不同layer来存放path
- (void)changeClick
{
    [self clearDisplayView];
    
    
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    CAShapeLayer *layer3 = [CAShapeLayer layer];
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    
    [path1 moveToPoint:self.view.center];
    [path2 moveToPoint:self.view.center];
    [path3 moveToPoint:self.view.center];
    
    CGFloat radius = 2.5;
    
    switch (self.type)
    {
        case ALLSHOW:
        {
            self.type = LEFT;
            [path1 addLineToPoint:CGPointMake(self.view.center.x - 100, self.view.center.y)];
            //addArcWithCenter画圆皆为顺时针 startAngle:在线段右边时为0 线段左边时为M_PI endAngle与startAngle相反
            [path1 addArcWithCenter:CGPointMake(self.view.center.x - 100 - radius, self.view.center.y) radius:radius startAngle:0 endAngle:(0 - 0.1 / 180 * M_PI) clockwise:YES];
            [_pointArray addObject:NSStringFromCGPoint(CGPointMake(self.view.center.x - 100 - radius, self.view.center.y))];
            
            [path2 addLineToPoint:CGPointMake(self.view.center.x + 50, self.view.center.y - 50)];
            [path2 addLineToPoint:CGPointMake(self.view.center.x + 50 + 50, self.view.center.y - 50)];
            [path2 addArcWithCenter:CGPointMake(self.view.center.x  + 50 + 50 + radius, self.view.center.y - 50) radius:radius startAngle:M_PI endAngle:(M_PI - 0.1 / 180 * M_PI) clockwise:YES];
            [_pointArray addObject:NSStringFromCGPoint(CGPointMake(self.view.center.x  + 50 + 50 + radius, self.view.center.y - 50))];
            
            [path3 addLineToPoint:CGPointMake(self.view.center.x + 50, self.view.center.y + 50)];
            [path3 addLineToPoint:CGPointMake(self.view.center.x + 50 + 50, self.view.center.y + 50)];
            [path3 addArcWithCenter:CGPointMake(self.view.center.x + 50 + 50 + radius, self.view.center.y + 50) radius:radius startAngle:M_PI endAngle:(M_PI - 0.1 / 180 * M_PI) clockwise:YES];
            [_pointArray addObject:NSStringFromCGPoint(CGPointMake(self.view.center.x + 50 + 50 + radius, self.view.center.y + 50))];
            
        }
            break;
        case LEFT:
        {
            self.type = RIGHT;
            [path1 addLineToPoint:CGPointMake(self.view.center.x - 100, self.view.center.y)];
            [path1 addArcWithCenter:CGPointMake(self.view.center.x - 100 - radius, self.view.center.y) radius:radius startAngle:0 endAngle:(0 - 0.1 / 180 * M_PI) clockwise:YES];
            [_pointArray addObject:NSStringFromCGPoint(CGPointMake(self.view.center.x - 100 - radius, self.view.center.y))];
            
            [path2 addLineToPoint:CGPointMake(self.view.center.x - 50, self.view.center.y - 50)];
            [path2 addLineToPoint:CGPointMake(self.view.center.x - 50 - 50, self.view.center.y - 50)];
            [path2 addArcWithCenter:CGPointMake(self.view.center.x  - 50 - 50 - radius, self.view.center.y - 50) radius:radius startAngle:0 endAngle:(0 - 0.1 / 180 * M_PI) clockwise:YES];
            [_pointArray addObject:NSStringFromCGPoint(CGPointMake(self.view.center.x  - 50 - 50 - radius, self.view.center.y - 50))];
            
            [path3 addLineToPoint:CGPointMake(self.view.center.x - 50, self.view.center.y + 50)];
            [path3 addLineToPoint:CGPointMake(self.view.center.x - 50 - 50, self.view.center.y + 50)];
            [path3 addArcWithCenter:CGPointMake(self.view.center.x - 50 - 50 - radius, self.view.center.y + 50) radius:radius startAngle:0 endAngle:(0 - 0.1 / 180 * M_PI) clockwise:YES];
            [_pointArray addObject:NSStringFromCGPoint(CGPointMake(self.view.center.x  - 50 - 50 - radius, self.view.center.y + 50))];
        }
            break;
        case RIGHT:
        {
            self.type = ALLSHOW;
            [path1 addLineToPoint:CGPointMake(self.view.center.x + 100, self.view.center.y)];
            [path1 addArcWithCenter:CGPointMake(self.view.center.x + 100 + radius, self.view.center.y) radius:radius startAngle:M_PI endAngle:(M_PI- 0.1 / 180 * M_PI ) clockwise:YES];
            [_pointArray addObject:NSStringFromCGPoint(CGPointMake(self.view.center.x + 100 + radius, self.view.center.y))];
            
            [path2 addLineToPoint:CGPointMake(self.view.center.x + 50, self.view.center.y - 50)];
            [path2 addLineToPoint:CGPointMake(self.view.center.x + 50 + 50, self.view.center.y - 50)];
            [path2 addArcWithCenter:CGPointMake(self.view.center.x + 50 + 50 + radius, self.view.center.y - 50) radius:radius startAngle:M_PI endAngle:(M_PI- 0.1 / 180 * M_PI ) clockwise:YES];
            [_pointArray addObject:NSStringFromCGPoint(CGPointMake(self.view.center.x + 50 + 50 + radius, self.view.center.y - 50))];
            
            [path3 addLineToPoint:CGPointMake(self.view.center.x + 50, self.view.center.y + 50)];
            [path3 addLineToPoint:CGPointMake(self.view.center.x + 50 + 50, self.view.center.y + 50)];
            [path3 addArcWithCenter:CGPointMake(self.view.center.x + 50 + 50 + radius, self.view.center.y + 50) radius:radius startAngle:M_PI endAngle:(M_PI- 0.1 / 180 * M_PI ) clockwise:YES];
            [_pointArray addObject:NSStringFromCGPoint(CGPointMake(self.view.center.x + 50 + 50 + radius, self.view.center.y + 50))];
        }
            break;
            
        default:
            break;
    }
    
    layer1.strokeColor = [UIColor redColor].CGColor;
    layer1.fillColor = [UIColor clearColor].CGColor;
    layer1.path = path1.CGPath;
    layer2.strokeColor = [UIColor redColor].CGColor;
    layer2.fillColor = [UIColor clearColor].CGColor;
    layer2.path = path2.CGPath;
    layer3.strokeColor = [UIColor redColor].CGColor;
    layer3.fillColor = [UIColor clearColor].CGColor;
    layer3.path = path3.CGPath;

    [self.dispalyView.layer addSublayer:layer1];
    [self.dispalyView.layer addSublayer:layer2];
    [self.dispalyView.layer addSublayer:layer3];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation2.fromValue = @(0);
    animation2.toValue = @(1);
    animation2.duration = 0.25;
    animation2.delegate = self;
    [layer1 addAnimation:animation2 forKey:@"1"];
    [layer2 addAnimation:animation2 forKey:@"2"];
    [layer3 addAnimation:animation2 forKey:@"3"];

}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        for (NSInteger i = 0; i < 3; i ++)
        {
            CGPoint point = CGPointFromString(self.pointArray[i]);
            UILabel *labe = [self.view viewWithTag:i + 11111];
            labe.hidden = NO;
            CGPoint labP = labe.center;
            labP.x = point.x;
            labP.y = point.y;
            
            labe.center = labP;
            
            switch (self.type)
            {
                case LEFT:
                {
                    
                    if (i == 0)
                    {
                        labP.x -= 110;
                        labe.center = labP;
                        CAShapeLayer *layerv = (CAShapeLayer *)labe.layer.sublayers[0];
                        [layerv removeAllAnimations];
                        CATransform3D transform3D = CATransform3DMakeRotation(M_PI, 0, 1, 0);
                        layerv.transform = transform3D;
                    }
                }
                    break;
                case RIGHT:
                {
                    labP.x -= 110;
                    labe.center = labP;
                    if (i != 0)
                    {
                        CAShapeLayer *layerv = (CAShapeLayer *)labe.layer.sublayers[0];
                        [layerv removeAllAnimations];
                        CATransform3D transform3D = CATransform3DMakeRotation(M_PI, 0, 1, 0);
                        layerv.transform = transform3D;
                    }
                    
                    
                }
                    break;
                case ALLSHOW:
                {
                    CAShapeLayer *layerv = (CAShapeLayer *)labe.layer.sublayers[0];
                    [layerv removeAllAnimations];
                    CATransform3D transform3D = CATransform3DMakeRotation(M_PI, 0, 0, 0);
                    layerv.transform = transform3D;

                }
                    break;
                    
                default:
                    break;
            }
        }
        
    }
}

//闪光效果
- (CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.5f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}


- (void)clearDisplayView
{
    for (NSInteger i = 0; i < 3; i ++)
    {
        UILabel *label = [self.view viewWithTag:i + 11111];
        label.hidden = YES;
    }
    [_pointArray removeAllObjects];
    [_dispalyView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

@end
