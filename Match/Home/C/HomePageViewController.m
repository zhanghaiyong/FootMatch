//
//  HomePageViewController.m
//  Match
//
//  Created by zhy on 2017/9/30.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "HomePageViewController.h"
#import "HotDataView.h"
#import "JJDataView.h"
#import "HotDetailViewController.h"
#import "VideoDetailViewController.h"
#import "JXSegment.h"
#import "JXPageView.h"
#import "ChannelViewController.h"
#import "VideoDetailViewController.h"
#import "SpecialTopicView.h"
@interface HomePageViewController ()<JXSegmentDelegate,JXPageViewDataSource,JXPageViewDelegate>
{
    JXPageView *pageView;
    JXSegment *segment;
    NSMutableArray *channelArray;
}
@end

@implementation HomePageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    segment.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    segment.hidden = YES;
}

- (void)addChannelAction {
    
    ChannelViewController *channelVC = [[ChannelViewController alloc]init];
    channelVC.hidesBottomBarWhenPushed = YES;
    channelVC.alreadData = channelArray;
    channelVC.EditedChannelBack = ^(NSArray *channels) {
        [segment removeFromSuperview];
        segment = nil;
        [pageView removeFromSuperview];
        pageView = nil;
        
        segment = [[JXSegment alloc] initWithFrame:CGRectMake(0, 6, kDeviceWidth-60, 38)];
        [segment updateChannels:channelArray];
        segment.delegate = self;
        [self.navigationController.navigationBar addSubview:segment];
        
        pageView =[[JXPageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kHomeBarHeight)];
        pageView.datasource = self;
        pageView.delegate = self;
        [pageView reloadData];
        [pageView changeToItemAtIndex:0];
        [self.view addSubview:pageView];
    };
    [self.navigationController pushViewController:channelVC animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    channelArray = [[NSMutableArray alloc]initWithObjects:@"热门",@"集锦",@"视频",@"专题",@"欧冠", nil];;
    
    UIBarButtonItem *addChannerItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addChannelAction)];
    self.navigationItem.rightBarButtonItem = addChannerItem;
    
    segment = [[JXSegment alloc] initWithFrame:CGRectMake(0, 6, kDeviceWidth-60, 38)];
    [segment updateChannels:channelArray];
    segment.delegate = self;
    [self.navigationController.navigationBar addSubview:segment];
    
    pageView =[[JXPageView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kHomeBarHeight)];
    pageView.datasource = self;
    pageView.delegate = self;
    [pageView reloadData];
    [pageView changeToItemAtIndex:0];
    [self.view addSubview:pageView];
    

}

#pragma mark - JXPageViewDataSource
-(NSInteger)numberOfItemInJXPageView:(JXPageView *)pageView {
    return channelArray.count;
}

-(UIView*)pageView:(JXPageView *)pageView viewAtIndex:(NSInteger)index {
    
    UIButton *button = (UIButton *)[segment.scrollView viewWithTag:index+1000];
    NSLog(@"index = %ld   title = %@",index,button.currentTitle);
    if ([button.currentTitle isEqualToString:@"热门"]) {
        
        HotDataView *view = [[HotDataView alloc] initWithFrame:pageView.bounds url:kHot];
        view.toDetailBack = ^(HotModel *model) {
            VideoDetailViewController *videoDetailVC = [[VideoDetailViewController alloc]init];
            videoDetailVC.playUrl = model.url;
            videoDetailVC.title = @"热门详情";
            videoDetailVC.newsId = model.newsId;
            videoDetailVC.videoTitle = model.title;
            videoDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:videoDetailVC animated:YES];
        };
        view.toVideoBacl = ^(HotModel *model) {
            HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
            hotDetailVC.title = @"热门详情";
            hotDetailVC.newsId = model.newsId;
            hotDetailVC.newsTitle = model.title;
            hotDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hotDetailVC animated:YES];
        };
        return view;
    }else if ([button.currentTitle isEqualToString:@"集锦"]){
        JJDataView *view = [[JJDataView alloc] initWithFrame:pageView.bounds url:kVideoHighlight];
        view.toDetailBack = ^(MatchModel *model) {
            VideoDetailViewController *videoDetailVC = [[VideoDetailViewController alloc]init];
            videoDetailVC.playUrl = model.sPlayUrl;
            videoDetailVC.videoTitle = model.sTitle;
            videoDetailVC.title = @"比赛集锦";
            videoDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:videoDetailVC animated:YES];
        };
        return view;
    }else if ([button.currentTitle isEqualToString:@"视频"]){
        HotDataView *view = [[HotDataView alloc] initWithFrame:pageView.bounds url:KVideoUrl];
        view.toDetailBack = ^(HotModel *model) {
            VideoDetailViewController *videoDetailVC = [[VideoDetailViewController alloc]init];
            videoDetailVC.playUrl = model.url;
            videoDetailVC.title = @"热门详情";
            videoDetailVC.newsId = model.newsId;
            videoDetailVC.videoTitle = model.title;
            videoDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:videoDetailVC animated:YES];
        };
        view.toVideoBacl = ^(HotModel *model) {
            HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
            hotDetailVC.title = @"热门详情";
            hotDetailVC.newsId = model.newsId;
            hotDetailVC.newsTitle = model.title;
            hotDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hotDetailVC animated:YES];
        };
        return view;
    }else if ([button.currentTitle isEqualToString:@"专题"]){
        SpecialTopicView *view = [[SpecialTopicView alloc] initWithFrame:pageView.bounds url:KspecialTopicUrl];
        view.SpecialtoDetailBack = ^(SpecialTopicModel *model) {
            HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
            hotDetailVC.title = @"热门详情";
            hotDetailVC.newsId = model.pid;
            hotDetailVC.newsTitle = model.newsTitle;
            hotDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hotDetailVC animated:YES];
        };
        return view;
        
    }else if ([button.currentTitle isEqualToString:@"欧冠"]){
    HotDataView *view = [[HotDataView alloc] initWithFrame:pageView.bounds url:OUGUANUrl];
        view.toDetailBack = ^(HotModel *model) {
            VideoDetailViewController *videoDetailVC = [[VideoDetailViewController alloc]init];
            videoDetailVC.playUrl = model.url;
            videoDetailVC.title = @"热门详情";
            videoDetailVC.newsId = model.newsId;
            videoDetailVC.videoTitle = model.title;
            videoDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:videoDetailVC animated:YES];
        };
    return view;
} else if ([button.currentTitle isEqualToString:@"NBA"]){
        HotDataView *view = [[HotDataView alloc] initWithFrame:pageView.bounds url:K_NBA];
    view.toDetailBack = ^(HotModel *model) {
        VideoDetailViewController *videoDetailVC = [[VideoDetailViewController alloc]init];
        videoDetailVC.playUrl = model.url;
        videoDetailVC.title = @"热门详情";
        videoDetailVC.newsId = model.newsId;
        videoDetailVC.videoTitle = model.title;
        videoDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:videoDetailVC animated:YES];
    };
    view.toVideoBacl = ^(HotModel *model) {
        HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
        hotDetailVC.title = @"热门详情";
        hotDetailVC.newsId = model.newsId;
        hotDetailVC.newsTitle = model.title;
        hotDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hotDetailVC animated:YES];
    };
        return view;
    
    }else if ([button.currentTitle isEqualToString:@"法甲"]){
        HotDataView *view = [[HotDataView alloc] initWithFrame:pageView.bounds url:F_JIA];
        view.toDetailBack = ^(HotModel *model) {
            VideoDetailViewController *videoDetailVC = [[VideoDetailViewController alloc]init];
            videoDetailVC.playUrl = model.url;
            videoDetailVC.title = @"热门详情";
            videoDetailVC.newsId = model.newsId;
            videoDetailVC.videoTitle = model.title;
            videoDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:videoDetailVC animated:YES];
        };
        view.toVideoBacl = ^(HotModel *model) {
            HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
            hotDetailVC.title = @"热门详情";
            hotDetailVC.newsId = model.newsId;
            hotDetailVC.newsTitle = model.title;
            hotDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hotDetailVC animated:YES];
        };
        return view;
    }else if ([button.currentTitle isEqualToString:@"德甲"]){
        HotDataView *view = [[HotDataView alloc] initWithFrame:pageView.bounds url:DE_JIA];
        view.toDetailBack = ^(HotModel *model) {
            VideoDetailViewController *videoDetailVC = [[VideoDetailViewController alloc]init];
            videoDetailVC.playUrl = model.url;
            videoDetailVC.title = @"热门详情";
            videoDetailVC.newsId = model.newsId;
            videoDetailVC.videoTitle = model.title;
            videoDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:videoDetailVC animated:YES];
        };
        view.toVideoBacl = ^(HotModel *model) {
            HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
            hotDetailVC.title = @"热门详情";
            hotDetailVC.newsId = model.newsId;
            hotDetailVC.newsTitle = model.title;
            hotDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hotDetailVC animated:YES];
        };
        return view;
    }else if ([button.currentTitle isEqualToString:@"中超"]){
        HotDataView *view = [[HotDataView alloc] initWithFrame:pageView.bounds url:ZHONG_CHAO];
        view.toDetailBack = ^(HotModel *model) {
            VideoDetailViewController *videoDetailVC = [[VideoDetailViewController alloc]init];
            videoDetailVC.playUrl = model.url;
            videoDetailVC.title = @"热门详情";
            videoDetailVC.newsId = model.newsId;
            videoDetailVC.videoTitle = model.title;
            videoDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:videoDetailVC animated:YES];
        };
        view.toVideoBacl = ^(HotModel *model) {
            HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
            hotDetailVC.title = @"热门详情";
            hotDetailVC.newsId = model.newsId;
            hotDetailVC.newsTitle = model.title;
            hotDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hotDetailVC animated:YES];
        };
        return view;
    }else if ([button.currentTitle isEqualToString:@"西甲"]){
        HotDataView *view = [[HotDataView alloc] initWithFrame:pageView.bounds url:XI_JIA];
        view.toDetailBack = ^(HotModel *model) {
            VideoDetailViewController *videoDetailVC = [[VideoDetailViewController alloc]init];
            videoDetailVC.playUrl = model.url;
            videoDetailVC.title = @"热门详情";
            videoDetailVC.newsId = model.newsId;
            videoDetailVC.videoTitle = model.title;
            videoDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:videoDetailVC animated:YES];
        };
        view.toVideoBacl = ^(HotModel *model) {
            HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
            hotDetailVC.title = @"热门详情";
            hotDetailVC.newsId = model.newsId;
            hotDetailVC.newsTitle = model.title;
            hotDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hotDetailVC animated:YES];
        };
        return view;
    }else if ([button.currentTitle isEqualToString:@"CBA"]){
        HotDataView *view = [[HotDataView alloc] initWithFrame:pageView.bounds url:K_CBA];
        view.toDetailBack = ^(HotModel *model) {
            VideoDetailViewController *videoDetailVC = [[VideoDetailViewController alloc]init];
            videoDetailVC.playUrl = model.url;
            videoDetailVC.title = @"热门详情";
            videoDetailVC.newsId = model.newsId;
            videoDetailVC.videoTitle = model.title;
            videoDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:videoDetailVC animated:YES];
        };
        view.toVideoBacl = ^(HotModel *model) {
            HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
            hotDetailVC.title = @"热门详情";
            hotDetailVC.newsId = model.newsId;
            hotDetailVC.newsTitle = model.title;
            hotDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hotDetailVC animated:YES];
        };
        return view;
    }else if ([button.currentTitle isEqualToString:@"英超"]){
        HotDataView *view = [[HotDataView alloc] initWithFrame:pageView.bounds url:YING_CHAO];
        view.toDetailBack = ^(HotModel *model) {
            VideoDetailViewController *videoDetailVC = [[VideoDetailViewController alloc]init];
            videoDetailVC.playUrl = model.url;
            videoDetailVC.title = @"热门详情";
            videoDetailVC.newsId = model.newsId;
            videoDetailVC.videoTitle = model.title;
            videoDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:videoDetailVC animated:YES];
        };
        view.toVideoBacl = ^(HotModel *model) {
            HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
            hotDetailVC.title = @"热门详情";
            hotDetailVC.newsId = model.newsId;
            hotDetailVC.newsTitle = model.title;
            hotDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hotDetailVC animated:YES];
        };
        return view;
    }else if ([button.currentTitle isEqualToString:@"意甲"]){
        HotDataView *view = [[HotDataView alloc] initWithFrame:pageView.bounds url:YI_JIA];
        view.toDetailBack = ^(HotModel *model) {
            VideoDetailViewController *videoDetailVC = [[VideoDetailViewController alloc]init];
            videoDetailVC.playUrl = model.url;
            videoDetailVC.title = @"热门详情";
            videoDetailVC.newsId = model.newsId;
            videoDetailVC.videoTitle = model.title;
            videoDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:videoDetailVC animated:YES];
        };
        view.toVideoBacl = ^(HotModel *model) {
            HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
            hotDetailVC.title = @"热门详情";
            hotDetailVC.newsId = model.newsId;
            hotDetailVC.newsTitle = model.title;
            hotDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hotDetailVC animated:YES];
        };
        return view;
    }
    return nil;
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
