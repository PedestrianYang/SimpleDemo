//
//  QRcodeView.m
//  iOSQRcode
//
//  Created by ymq on 16/3/21.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "QRcodeView.h"
#import <AVFoundation/AVFoundation.h>

@interface QRcodeView ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) UIImageView *boxView;
@property (nonatomic, strong) UIImageView *scanPlayView;
//捕捉会话
@property (nonatomic, strong) AVCaptureSession *captureSession;
//展示layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation QRcodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSError *error;
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请打开相机权限" delegate:self cancelButtonTitle:@"设置" otherButtonTitles:@"取消", nil];
        [alerview show];
        return;
    }
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2.用captureDevice创建输入流
    
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    //3.创建媒体数据输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    //4.实例化捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    //4.1.将输入流添加到会话
    [_captureSession addInput:input];
    //4.2.将媒体输出流添加到会话中
    [_captureSession addOutput:captureMetadataOutput];
    //5.创建串行队列，并加媒体输出流添加到队列当中
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    //5.1.设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //5.2.设置输出媒体数据类型为QRCode
//    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode, nil]];
    
    //6.实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    //7.设置预览图层填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //8.设置图层的frame
    [_videoPreviewLayer setFrame:self.layer.bounds];
    //9.将图层添加到预览view的图层上
    [self.layer addSublayer:_videoPreviewLayer];
    
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    CGFloat offsetX = 0.1;
    CGFloat offsetY = 0.3;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    [path appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(self.bounds.size.width * offsetX, self.bounds.size.height * offsetY - 20, self.bounds.size.width - self.bounds.size.width * offsetX * 2, self.bounds.size.height * (1- offsetY * 2))]];
    maskLayer.path = path.CGPath;
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    maskLayer.opacity = 0.5;
    
    [self.layer addSublayer:maskLayer];
    
    
    //10.设置扫描范围
    captureMetadataOutput.rectOfInterest = CGRectMake(0.2, 0.2, 0.8f, 0.8f);
    //10.1.扫描框
    _boxView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width * offsetX, self.bounds.size.height * offsetY - 20, self.bounds.size.width - self.bounds.size.width * offsetX * 2, self.bounds.size.height * (1- offsetY * 2))];
    _boxView.image = [UIImage imageNamed:@"scanMagin"];
    _boxView.clipsToBounds = YES;
    [self addSubview:_boxView];
    
    _scanPlayView = [[UIImageView alloc] initWithFrame:CGRectMake(0, - _boxView.frame.size.height, _boxView.frame.size.width, _boxView.frame.size.height)];
    _scanPlayView.image = [UIImage imageNamed:@"scanGrid"];
    [_boxView addSubview:_scanPlayView];

}

- (void)scanPlay
{
    CGRect frame = _scanPlayView.frame;
    frame.origin.y += 1;
    if (frame.origin.y >= 0)
    {
        frame.origin.y = - _boxView.frame.size.height;
    }
    
    _scanPlayView.frame = frame;
}

- (void)startReading
{
    if (!_captureSession)
    {
        [self setup];
    }
    [_captureSession startRunning];
    
    NSThread *timerThread = [[NSThread alloc] initWithTarget:self selector:@selector(timerStart) object:nil];
    [timerThread start];
}

- (void)timerStart
{
    @autoreleasepool
    {
        NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(scanPlay) userInfo:nil repeats:YES];
        [runLoop run];
    }
}

- (void)stopReading
{
    [_captureSession stopRunning];
    if (self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0)
    {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode] ||
            [[metadataObj type] isEqualToString:AVMetadataObjectTypeEAN13Code] ||
            [[metadataObj type] isEqualToString:AVMetadataObjectTypeEAN8Code] ||
            [[metadataObj type] isEqualToString:AVMetadataObjectTypeCode128Code])
        {
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            
            if (self.scanResult) {
                self.scanResult(QRScanResultType_Succeed,[metadataObj stringValue]);
            }
            
        }
    }
    else
    {
        if (self.scanResult) {
            self.scanResult(QRScanResultType_Fail,nil);
        }
    }
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //跳转设置界面
        NSURL*url =[NSURL URLWithString:[NSString stringWithFormat:@"prefs:root=%@",[[NSBundle mainBundle] bundleIdentifier]]];
        if([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
