//
//  ViewController.m
//  SegmentBtn
//
//  Created by ymq on 16/5/9.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "ViewController.h"
#import "YSWSpecialShopSegmentBtn.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (assign, nonatomic) CGFloat lastPosition;
@property (nonatomic, strong) YSWSpecialShopSegmentBtn *segment;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _segment = [[[NSBundle mainBundle] loadNibNamed:@"YSWSpecialShopSegmentBtn" owner:self options:nil] firstObject];
    _segment.frame = CGRectMake(0, 64, SCREEN_WIDTH, 64);
    [_segment setSegmentClick:^(NSInteger btnIndex) {
         NSLog(@"%@",@(btnIndex));
    }];
    [self.view addSubview:_segment];
    
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segment.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(_segment.frame))];
    _bgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    _bgScrollView.delegate = self;
    [self.view addSubview:_bgScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPostion = scrollView.contentOffset.y;
    CGRect segmentFrame = self.segment.frame;
    if (currentPostion > _lastPosition && currentPostion > 0) {        //这个地方加上 currentPostion > 0 即可）
        
        _lastPosition = currentPostion;
        
        NSLog(@"ScrollUp now");
        
        if (segmentFrame.origin.y != 64.0)
        {
            segmentFrame.origin.y = 64.0;
            segmentFrame.size.height = 20.0;
            
            [UIView animateWithDuration:0.25 animations:^{
                self.segment.frame = segmentFrame;
                
                self.segment.rightIconH.constant = 0;
                self.segment.midIconH.constant = 0;
                self.segment.leftIconH.constant = 0;
                
                [self.segment layoutIfNeeded];
                
                CGRect scrollViewFrame = scrollView.frame;
                scrollViewFrame.origin.y = CGRectGetMaxY(segmentFrame);
                scrollView.frame = scrollViewFrame;
            }];
        }

       
        
    }
    
    else if (currentPostion < 0 && currentPostion < _lastPosition) //这个地方加上后边那个即可，也不知道为什么，再减20才行
        
    {
        _lastPosition = currentPostion;
        
        if (segmentFrame.origin.y != 200)
        {
            segmentFrame.origin.y = 200;
            segmentFrame.size.height = 64.0;
            [UIView animateWithDuration:0.25 animations:^{
                self.segment.frame = segmentFrame;
                
                self.segment.rightIconH.constant = 33.0;
                self.segment.midIconH.constant = 33.0;
                self.segment.leftIconH.constant = 33.0;
                
                [self.segment layoutIfNeeded];
                
                CGRect scrollViewFrame = scrollView.frame;
                scrollViewFrame.origin.y = CGRectGetMaxY(segmentFrame);
                scrollView.frame = scrollViewFrame;
            }];
        }
    }
}

@end
