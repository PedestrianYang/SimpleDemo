//
//  SecondViewController.m
//  iOSQRcode
//
//  Created by ymq on 16/3/21.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "SecondViewController.h"
#import "QRcodeView.h"

@interface SecondViewController ()

@property (nonatomic, strong) QRcodeView *qrview;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    _qrview = [[QRcodeView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_qrview setScanResult:^(QRScanResultType type, NSString *result) {
        if (type == QRScanResultType_Succeed)
        {
            NSLog(@"%@",result);
        }
        else
        {
            NSLog(@"扫描失败");
        }
    }];
    [self.view addSubview:_qrview];
    
    _indicatorView = [[UIActivityIndicatorView alloc] init];
    _indicatorView.bounds = CGRectMake(0, 0, 40, 40);
    _indicatorView.center = self.view.center;
    _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    _indicatorView.hidesWhenStopped = YES;
    [self.view addSubview:_indicatorView];
    [_indicatorView startAnimating];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_qrview startReading];
    [_indicatorView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    NSLog(@"asdfasfas");
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
