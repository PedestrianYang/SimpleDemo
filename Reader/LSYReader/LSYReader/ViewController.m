//
//  ViewController.m
//  LSYReader
//
//  Created by Labanotation on 16/5/30.
//  Copyright © 2016年 okwei. All rights reserved.
//

#import "ViewController.h"
#import "LSYReadViewController.h"
#import "LSYReadPageViewController.h"
#import "LSYReadUtilites.h"
#import "LSYReadModel.h"
#import "FileCollectionViewFlowLayout.h"
#import "FileCollectionViewCell.h"
#import "GCDWebUploader.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

static NSString *cellID = @"cellID";

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, GCDWebUploaderDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) GCDWebUploader *webServer;
@property (strong, nonatomic) NSArray *rootFilesPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setNavBarRightBtn];
    [_collection setCollectionViewLayout:[[FileCollectionViewFlowLayout alloc] init]];
    [_collection registerNib:[UINib nibWithNibName:@"FileCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellID];

    if (self.path == nil) {
//        self.path = NSHomeDirectory();
        self.path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//        self.title = @"主目录";
        self.title = @"本地书籍";
    }else{
        self.title = [self.path lastPathComponent];;
    }
    
    _dataArray = [[NSMutableArray alloc] init];
    self.rootFilesPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:nil];
    [self getBooks:self.rootFilesPath prePath:self.path];
    [self.collection reloadData];
    
//    self.dataArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)getBooks:(NSArray *)filePaths prePath:(NSString *)prePath{
    [filePaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *childFileName = obj;
        NSString *extension = childFileName.pathExtension;
        if ([extension isEqualToString:@"txt"] || [extension isEqualToString:@"epub"]) {
            NSString *bookPath = [NSString stringWithFormat:@"%@/%@", prePath, childFileName];
            [_dataArray addObject:bookPath];
        }else if (extension.length == 0){
            NSString *childPath = [NSString stringWithFormat:@"%@/%@",prePath,childFileName];
            NSArray *childFilesArry = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:childPath error:nil];
            [self getBooks:childFilesArry prePath:childPath];
        }
    }];
}



- (void)setNavBarRightBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn setTitle:@"传输" forState:UIControlStateNormal];
    [btn setTitle:@"结束" forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(startService:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)startService:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.webServer start];
        //初始化提示框；
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"在电脑浏览器输入IP地址：" message:[NSString stringWithFormat:@"%@",_webServer.serverURL] preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
        }]];
        
        //弹出提示框；
        [self presentViewController:alert animated:true completion:nil];
        
    }else{
        [self.webServer stop];
    }
}

- (GCDWebUploader *)webServer{
    if (!_webServer) {
        _webServer = [[GCDWebUploader alloc] initWithUploadDirectory:self.path];
        _webServer.delegate = self;
        _webServer.allowHiddenItems = YES;
    }
    return _webServer;
}

- (void)begin:(NSString *)filePath {
    NSString *fileName = [[filePath lastPathComponent] stringByDeletingPathExtension];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    LSYReadPageViewController *pageView = [[LSYReadPageViewController alloc] init];
    pageView.bookName = fileName;
    pageView.resourceURL = fileURL;    //文件位置
    
    [self showLoadingInView:self.view];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        pageView.model = [LSYReadModel getLocalModelWithURL:fileURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideLoad];
            [self.navigationController pushViewController:pageView animated:YES];

        });
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)deviceIPAdress {
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in  *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    
    NSLog(@"%@", address);
    
    return address;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *filePath = _dataArray[indexPath.row];
    NSString *extension = filePath.pathExtension;

    if ([extension isEqualToString:@"txt"]) {
        [self begin:filePath];
    }else if ([extension isEqualToString:@"epub"]){
        [self begin:filePath];
    }else if (extension.length == 0){
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//        ViewController *nextPathVC = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
//        nextPathVC.path = nextPagePath;
//        [self.navigationController pushViewController:nextPathVC animated:YES];
    }
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSString *filePath = _dataArray[indexPath.row];
    NSString *extension = filePath.pathExtension;
    cell.titleLab.text = [[filePath lastPathComponent] stringByDeletingPathExtension];
    if ([extension isEqualToString:@"txt"]) {
        cell.iconImgView.image = [UIImage imageNamed:@"texticon"];
    }else if ([extension isEqualToString:@"epub"]){
        NSString *coverImagePath = [NSString stringWithFormat:@"%@/OPS/images/cover.jpg",[filePath stringByDeletingPathExtension]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:coverImagePath]) {
            cell.iconImgView.image = [UIImage imageWithContentsOfFile:coverImagePath];
        }else{
            cell.iconImgView.image = [UIImage imageNamed:@"texticon"];
        }

    }else if (extension.length == 0){
        cell.iconImgView.image = [UIImage imageNamed:@"folder"];
    }else if ([extension isEqualToString:@"jpg"] || [extension isEqualToString:@"png"]){
        NSString *coverImagePath = [NSString stringWithFormat:@"%@/%@",self.path,filePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:coverImagePath]) {
            cell.iconImgView.image = [UIImage imageWithContentsOfFile:coverImagePath];
        }
    }
    
    return cell;
}

#pragma mark GCDWebUploaderDelegate
- (void)webUploader:(GCDWebUploader*)uploader didUploadFileAtPath:(NSString*)path {
    NSLog(@"[UPLOAD] %@", path);
    [_dataArray addObject:path];

    [self.collection reloadData];
}

- (void)webUploader:(GCDWebUploader*)uploader didMoveItemFromPath:(NSString*)fromPath toPath:(NSString*)toPath {
    NSLog(@"[MOVE] %@ -> %@", fromPath, toPath);
}

- (void)webUploader:(GCDWebUploader*)uploader didDeleteItemAtPath:(NSString*)path {
    NSLog(@"[DELETE] %@", path);
}

- (void)webUploader:(GCDWebUploader*)uploader didCreateDirectoryAtPath:(NSString*)path {
    NSLog(@"[CREATE] %@", path);
}

@end
