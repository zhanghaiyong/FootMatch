//
//  StatisticsViewController.m
//  Match
//
//  Created by zhy on 2017/10/9.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "StatisticsViewController.h"
#import "JXSegment.h"
#import "JXPageView.h"

@interface StatisticsViewController ()<JXSegmentDelegate,JXPageViewDataSource,JXPageViewDelegate,UIWebViewDelegate>{
    JXPageView *pageView;
    JXSegment *segment;
}
@property(nonatomic,strong) NSArray *channelArray;
@end

@implementation StatisticsViewController

- (NSArray*)channelArray{
    if (_channelArray == nil) {
        _channelArray = @[@"NBA",@"CBA",@"德甲",@"英超",@"意甲",@"西甲",@"法甲",@"欧冠",@"中超"];
    }
    return _channelArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AccountModel *model = [AccountModel account];
    //有帐号
    if (model) {
        [self.avatarBtn setImage:model.avatar forState:UIControlStateNormal];
        [self.avatarBtn setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"数据-分析";
    [self setRightBarButtonItem];
    segment = [[JXSegment alloc] initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, 38)];
    [segment updateChannels:self.channelArray];
    segment.delegate = self;
    [self.view addSubview:segment];
    
    pageView =[[JXPageView alloc] initWithFrame:CGRectMake(0, segment.bottom, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-49-kHomeBarHeight-segment.height)];
    pageView.datasource = self;
    pageView.delegate = self;
    [pageView reloadData];
    [pageView changeToItemAtIndex:0];
    [self.view addSubview:pageView];
}

#pragma mark - JXPageViewDataSource
-(NSInteger)numberOfItemInJXPageView:(JXPageView *)pageView{
    return self.channelArray.count;
}

-(UIView*)pageView:(JXPageView *)pageView viewAtIndex:(NSInteger)index{

    [SVProgressHUD showWithStatus:@"加载中..."];
    UIView *view = [[UIView alloc] init];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kHomeBarHeight-90)];
    [webView scalesPageToFit];
    webView.delegate = self;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&leagueId=%ld",kNBATeam,index+1]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [view addSubview:webView];

    return view;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD dismiss];
}

#pragma mark - JXSegmentDelegate
- (void)JXSegment:(JXSegment*)segment didSelectIndex:(NSInteger)index{
    [pageView changeToItemAtIndex:index];
}

#pragma mark - JXPageViewDelegate
- (void)didScrollToIndex:(NSInteger)index{
    [segment didChengeToIndex:index];
}


@end
