//
//  LSYReadPageViewController.m
//  LSYReader
//
//  Created by Labanotation on 16/5/30.
//  Copyright © 2016年 okwei. All rights reserved.
//

#import "LSYReadPageViewController.h"
#import "LSYReadViewController.h"
#import "LSYChapterModel.h"
#import "LSYMenuView.h"
#import "LSYCatalogViewController.h"
#import "UIImage+ImageEffects.h"
#import "LSYNoteModel.h"
#import "LSYMarkModel.h"
#import <objc/runtime.h>
#import <MediaPlayer/MediaPlayer.h>
#define AnimationDelay 0.3

@interface LSYReadPageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,
LSYMenuViewDelegate,UIGestureRecognizerDelegate,
LSYCatalogViewControllerDelegate,LSYReadViewControllerDelegate,
AVSpeechSynthesizerDelegate>
{
    NSUInteger _chapterChange;  //将要变化的章节
    NSUInteger _pageChange;     //将要变化的页数
    BOOL _isTransition;     //是否开始翻页
}
@property (nonatomic,assign) NSUInteger chapter; //当前显示的章节
@property (nonatomic,assign) NSUInteger page;   //当前显示的页数
@property (nonatomic,strong) AVSpeechSynthesizer *av;
@property (nonatomic,strong) AVSpeechUtterance *utterance;
@property (nonatomic,strong) UIPageViewController *pageViewController;
@property (nonatomic,getter=isShowBar) BOOL showBar; //是否显示状态栏
@property (nonatomic,strong) LSYMenuView *menuView; //菜单栏
@property (nonatomic,strong) LSYCatalogViewController *catalogVC;   //侧边栏
@property (nonatomic,strong) UIView * catalogView;  //侧边栏背景
@property (nonatomic,strong) LSYReadViewController *readView;   //当前阅读视图
@property (nonatomic,strong) NSTimer *timer;        //自动翻页

@end

@implementation LSYReadPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.pageViewController];
    
    [_pageViewController setViewControllers:@[[self readViewWithChapter:_model.record.chapter page:_model.record.page]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    _chapter = _model.record.chapter;
    
    _page = _model.record.page;
    [self.view addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showToolMenu)];
        tap.delegate = self;
        tap;
    })];
    [self.view addSubview:self.menuView];
    
    [self addChildViewController:self.catalogVC];
    [self.view addSubview:self.catalogView];
    [self.catalogView addSubview:self.catalogVC.view];
    //添加笔记
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNotes:) name:LSYNoteNotification object:nil];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupAVPlayer];
}

-(void)setupAVPlayer
{
    _av = [[AVSpeechSynthesizer alloc] init];
    _av.delegate = self;
    [self setLockScreenInfo];
}

-(void)setLockScreenInfo
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    //设置歌曲题目
    
    [dict setObject:_model.chapters[_chapter].title forKey:MPMediaItemPropertyTitle];
    
    //设置歌手名
    
    [dict setObject:@"杨梦卿" forKey:MPMediaItemPropertyArtist];
    
    //设置专辑名
    
    [dict setObject:_bookName forKey:MPMediaItemPropertyAlbumTitle];
    
    //设置显示的图片
    
//    UIImage *newImage = [UIImage imageNamed:@"43.png"];
//
//    [dict setObject:[[MPMediaItemArtwork alloc] initWithImage:newImage]
//
//             forKey:MPMediaItemPropertyArtwork];
    
    //设置歌曲时长
    
//    [dict setObject:[NSNumber numberWithDouble:300] forKey:MPMediaItemPropertyPlaybackDuration];
    
    //设置已经播放时长
    
//    [dict setObject:[NSNumber numberWithDouble:150] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    
    //更新字典
    
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];

}

-(void)addNotes:(NSNotification *)no
{
    LSYNoteModel *noteModel = no.object;
    LSYChapterModel *chapterModel = _model.record.chapterModel;
    noteModel.location += [chapterModel.pageArray[_model.record.page] integerValue];
    noteModel.chapter = _model.record.chapter;
    noteModel.recordModel = [_model.record copy];
    [[_model mutableArrayValueForKey:@"notes"] addObject:noteModel];    //这样写才能KVO数组变化
    [LSYReadUtilites showAlertTitle:nil content:@"保存笔记成功"];
}

-(BOOL)prefersStatusBarHidden
{
    return !_showBar;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)showToolMenu
{
    BOOL isMarked = FALSE;
    
    LSYRecordModel *recordModel = _model.record;
    LSYChapterModel *chapterModel = recordModel.chapterModel;
    
    NSUInteger startIndex = [chapterModel.pageArray[recordModel.page] integerValue];
    
    NSUInteger endIndex = NSUIntegerMax;
    NSUInteger chapter = recordModel.chapter;
    
    if (recordModel.page < chapterModel.pageCount - 1) {
        endIndex = [chapterModel.pageArray[recordModel.page + 1] integerValue];
    }
    
    for (int i = 0; i < _model.marks.count; i++) {
        LSYMarkModel *markModel = _model.marks[i];
        if (markModel.chapter == chapter && markModel.location >= startIndex && markModel.location < endIndex) {
            isMarked = YES;
            break;
        }
    }
    
    isMarked?(_menuView.topView.state=1): (_menuView.topView.state=0);
    [self.menuView showAnimation:YES];
    
}

#pragma mark - init
-(LSYMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[LSYMenuView alloc] init];
        _menuView.hidden = YES;
        _menuView.delegate = self;
        _menuView.recordModel = _model.record;
    }
    return _menuView;
}
-(UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self.view addSubview:_pageViewController.view];
    }
    return _pageViewController;
}
-(LSYCatalogViewController *)catalogVC
{
    if (!_catalogVC) {
        _catalogVC = [[LSYCatalogViewController alloc] init];
        _catalogVC.readModel = _model;
        _catalogVC.catalogDelegate = self;
    }
    return _catalogVC;
}
-(UIView *)catalogView
{
    if (!_catalogView) {
        _catalogView = [[UIView alloc] init];
        _catalogView.backgroundColor = [UIColor clearColor];
        _catalogView.hidden = YES;
        [_catalogView addGestureRecognizer:({
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCatalog)];
            tap.delegate = self;
            tap;
        })];
    }
    return _catalogView;
}
#pragma mark - CatalogViewController Delegate
-(void)catalog:(LSYCatalogViewController *)catalog didSelectChapter:(NSUInteger)chapter page:(NSUInteger)page
{
     [_pageViewController setViewControllers:@[[self readViewWithChapter:chapter page:page]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self updateReadModelWithChapter:chapter page:page];
    [self hiddenCatalog];
    
}
#pragma mark -  UIGestureRecognizer Delegate
//解决TabView与Tap手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
#pragma mark - Privite Method
-(void)catalogShowState:(BOOL)show
{
    show?({
        _catalogView.hidden = !show;
        [UIView animateWithDuration:AnimationDelay animations:^{
            _catalogView.frame = CGRectMake(0, 0,2*ViewSize(self.view).width, ViewSize(self.view).height);
            
        } completion:^(BOOL finished) {
            [_catalogView insertSubview:[[UIImageView alloc] initWithImage:[self blurredSnapshot]] atIndex:0];
        }];
    }):({
        if ([_catalogView.subviews.firstObject isKindOfClass:[UIImageView class]]) {
            [_catalogView.subviews.firstObject removeFromSuperview];
        }
        [UIView animateWithDuration:AnimationDelay animations:^{
             _catalogView.frame = CGRectMake(-ViewSize(self.view).width, 0, 2*ViewSize(self.view).width, ViewSize(self.view).height);
        } completion:^(BOOL finished) {
            _catalogView.hidden = !show;
            
        }];
    });
}
-(void)hiddenCatalog
{
    [self catalogShowState:NO];
}
- (UIImage *)blurredSnapshot {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)), NO, 1.0f);
    [self.view drawViewHierarchyInRect:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) afterScreenUpdates:NO];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIImage *blurredSnapshotImage = [snapshotImage applyLightEffect];
    UIGraphicsEndImageContext();
    return blurredSnapshotImage;
}
#pragma mark - Menu View Delegate
-(void)menuViewDidHidden:(LSYMenuView *)menu
{
     _showBar = NO;
    [self setNeedsStatusBarAppearanceUpdate];
}
-(void)menuViewDidAppear:(LSYMenuView *)menu
{
    _showBar = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    
}
-(void)menuViewInvokeCatalog:(LSYBottomMenuView *)bottomMenu
{
    [_menuView hiddenAnimation:NO];
    [self catalogShowState:YES];
    
}

-(void)menuViewJumpChapter:(NSUInteger)chapter page:(NSUInteger)page
{
    
    [_pageViewController setViewControllers:@[[self readViewWithChapter:chapter page:page]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self updateReadModelWithChapter:chapter page:page];
    
}
-(void)menuViewFontSize:(LSYBottomMenuView *)bottomMenu
{

    [_model.record.chapterModel updateFont];
    
    for (int i = 0; i < _model.chapters.count; i++) {
        [_model.chapters[i] updateFont];
    }
    
    [_pageViewController setViewControllers:@[[self readViewWithChapter:_model.record.chapter page:(_model.record.page>_model.record.chapterModel.pageCount-1)?_model.record.chapterModel.pageCount-1:_model.record.page]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self updateReadModelWithChapter:_model.record.chapter page:(_model.record.page>_model.record.chapterModel.pageCount-1)?_model.record.chapterModel.pageCount-1:_model.record.page];
}

-(void)autoReadAction:(NSNumber *)speed{
    if (!self.timer) {
        NSInteger speedInt = speed.integerValue;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:speedInt target:self selector:@selector(autoJumpNextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
}

-(void)autoReadChangeSpeed:(NSInteger)speed{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    NSInteger resSpeed = DefaultAutoReadSpeed - (speed - 10);
    [self autoReadAction:@(resSpeed)];
    
}

-(void)stopAutoRead{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


-(void)autoJumpNextPage{
    _pageChange = _page;
    _chapterChange = _chapter;
    if (_pageChange == _model.chapters.lastObject.pageCount-1 && _chapterChange == _model.chapters.count-1) {
        return;
    }
    if (_pageChange == _model.chapters[_chapterChange].pageCount-1) {
        _chapterChange++;
        _pageChange = 0;
    }
    else{
        _pageChange++;
    }
    
    _chapter = _chapterChange;
    _page = _pageChange;
    
    __weak typeof(self)bself = self;
    
   [self.pageViewController setViewControllers:@[[self readViewWithChapter:_chapterChange page:_pageChange]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
       [bself updateReadModelWithChapter:bself.chapter page:bself.page];
   }];
           
    
    
}

-(void)menuViewMark:(LSYTopMenuView *)topMenu
{

    BOOL isMarked = FALSE;
    
    LSYRecordModel *recordModel = _model.record;
    LSYChapterModel *chapterModel = recordModel.chapterModel;
    
    NSUInteger startIndex = [chapterModel.pageArray[recordModel.page] integerValue];
    
    NSUInteger endIndex = NSUIntegerMax;
    
    if (recordModel.page < chapterModel.pageCount - 1) {
        endIndex = [chapterModel.pageArray[recordModel.page + 1] integerValue];
    }
    
    NSMutableArray *markedArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _model.marks.count; i++) {
        LSYMarkModel *markModel = _model.marks[i];
        if (markModel.location >= startIndex && markModel.location <= endIndex) {
            isMarked = YES;
            [markedArray addObject:markModel];
        }
    }
    
    if (isMarked) {
        [[_model mutableArrayValueForKey:@"marks"] removeObjectsInArray:markedArray];
    } else {
        LSYRecordModel *recordModel = _model.record;
        LSYMarkModel *markModel = [[LSYMarkModel alloc] init];
        markModel.date = [NSDate date];
        markModel.location = [recordModel.chapterModel.pageArray[recordModel.page] integerValue];
        markModel.length = 0;
        markModel.chapter = recordModel.chapter;
        markModel.recordModel = [_model.record copy];
        [[_model mutableArrayValueForKey:@"marks"] addObject:markModel];
        //[_model.marksRecord setObject:markModel forKey:key];
    }
    
    _menuView.topView.state = !isMarked;
}

-(void)soundReadOpen:(BOOL)open{
    if (open) {
        _utterance = [[AVSpeechUtterance alloc] initWithString:_readView.content];
        _utterance.rate = 0.5;
        _utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
        [_av speakUtterance:_utterance];
    }else{
        [_av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    }
}


#pragma mark - Create Read View Controller

-(LSYReadViewController *)readViewWithChapter:(NSUInteger)chapter page:(NSUInteger)page{
    
    if (_model.record.chapter != chapter) {
        [self updateReadModelWithChapter:chapter page:page];
        [_model.record.chapterModel updateFont];
    }
    _readView = [[LSYReadViewController alloc] init];
    _readView.recordModel = _model.record;
    _readView.content = [_model.chapters[chapter] stringOfPage:page];
    _readView.delegate = self;
    NSLog(@"_readGreate");
    
    return _readView;
}
-(void)updateReadModelWithChapter:(NSUInteger)chapter page:(NSUInteger)page
{
    _chapter = chapter;
    _page = page;
    _model.record.chapterModel = _model.chapters[chapter];
    _model.record.chapter = chapter;
    _model.record.page = page;
    _model.font = [NSNumber numberWithFloat:[LSYReadConfig shareInstance].fontSize];
    [LSYReadModel updateLocalModel:_model url:_resourceURL];

    [self setLockScreenInfo];
}
#pragma mark - Read View Controller Delegate
-(void)readViewEndEdit:(LSYReadViewController *)readView
{
    for (UIGestureRecognizer *ges in self.pageViewController.view.gestureRecognizers) {
        if ([ges isKindOfClass:[UIPanGestureRecognizer class]]) {
            ges.enabled = YES;
            break;
        }
    }
}
-(void)readViewEditeding:(LSYReadViewController *)readView
{
    for (UIGestureRecognizer *ges in self.pageViewController.view.gestureRecognizers) {
        if ([ges isKindOfClass:[UIPanGestureRecognizer class]]) {
            ges.enabled = NO;
            break;
        }
    }
}
#pragma mark -PageViewController DataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{

    _pageChange = _page;
    _chapterChange = _chapter;

    if (_chapterChange==0 &&_pageChange == 0) {
        return nil;
    }
    if (_pageChange==0) {
        _chapterChange--;
        _pageChange = _model.chapters[_chapterChange].pageCount-1;
    }
    else{
        _pageChange--;
    }
    
    return [self readViewWithChapter:_chapterChange page:_pageChange];
    
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{

    _pageChange = _page;
    _chapterChange = _chapter;
    if (_pageChange == _model.chapters.lastObject.pageCount-1 && _chapterChange == _model.chapters.count-1) {
        return nil;
    }
    if (_pageChange == _model.chapters[_chapterChange].pageCount-1) {
        _chapterChange++;
        _pageChange = 0;
    }
    else{
        _pageChange++;
    }
    return [self readViewWithChapter:_chapterChange page:_pageChange];
}
#pragma mark -PageViewController Delegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (!completed) {
        LSYReadViewController *readView = previousViewControllers.firstObject;
        _readView = readView;
        _page = readView.recordModel.page;
        _chapter = readView.recordModel.chapter;
    }
    else{
        [self updateReadModelWithChapter:_chapter page:_page];
    }
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    _chapter = _chapterChange;
    _page = _pageChange;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    
    if (@available(iOS 11.0, *)){
        _pageViewController.view.frame = self.view.frame;
        _menuView.frame = self.view.frame;
        _catalogVC.view.frame = CGRectMake(0, 0, ViewSize(self.view).width-100, ViewSize(self.view).height);
    } else {
        _pageViewController.view.frame = self.view.frame;
        _menuView.frame = self.view.frame;
        _catalogView.frame = CGRectMake(-ViewSize(self.view).width, 0, 2*ViewSize(self.view).width, ViewSize(self.view).height);
        _catalogVC.view.frame = CGRectMake(0, 0, ViewSize(self.view).width-100, ViewSize(self.view).height);
    }
    
    [_catalogVC reload];
}

#pragma mark AVSpeechSynthesizerDelegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"语音开始");
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"语音结束");
    
    [self autoJumpNextPage];
    [self soundReadOpen:YES];
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"语音暂停");
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"语音继续");
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"语音取消");
}

#pragma mark 进入后台按钮

- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
            {
                if (_av != nil && _av.isPaused) {
                    [_av continueSpeaking];
                }else{
                    [_av speakUtterance:_utterance];
                }
            }
            break;
        case UIEventSubtypeRemoteControlPause:
        {
            [_av pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
        }
            break;
        case UIEventSubtypeRemoteControlNextTrack:
        {
            // ▶▶
            
            [self menuViewJumpChapter:(_chapter == _model.chapters.count-1)?_chapter:_chapter+1 page:0];
            [_av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
            [self soundReadOpen:YES];
            
            
        }
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
        {
            // ◀◀
            
            [self menuViewJumpChapter:_chapter?_chapter - 1 : 0  page:0];
            [_av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
            [self soundReadOpen:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
