//
//  ViewController.m
//  AFNetWorkTest
//
//  Created by ymq on 16/3/7.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "ViewController.h"
#import "AFNetWorkRequestManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AFNetWorkRequestManager *manager = [[AFNetWorkRequestManager alloc] init];
    [manager downloadWithrequest:@"http://attach.bbs.miui.com/forum/201402/21/120043wsfuzzuefyasz3fe.jpg" downloadpath:[self imageSoourcePath:@"aaa"] downloadblock:^(id responseo, id filepath, NSError *error, CGFloat progress) {
        if (progress == 1)
        {
            NSData *data = [NSData dataWithContentsOfFile:[self imageSoourcePath:@"aaa"]];
            self.imageView.image = [UIImage imageWithData:data];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)imageSoourcePath:(NSString *)imageName
{
    NSFileManager* fm = [NSFileManager defaultManager];
    NSString *homeDir = NSHomeDirectory();
    NSString *imageFilePth = [NSString stringWithFormat:@"%@/img",homeDir];
    if (![fm fileExistsAtPath:imageFilePth])
    {
        [fm createDirectoryAtPath:imageFilePth withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [NSString stringWithFormat:@"%@/%@.jpg",imageFilePth,imageName];
}

@end
