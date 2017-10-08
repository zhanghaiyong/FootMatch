//
//  VideoDetailViewController.m
//  Match
//
//  Created by 张海勇 on 2017/10/1.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "VideoDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface VideoDetailViewController ()
{
    UIView *maskView;
    AVPlayerLayer *layer;
}
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerViewController  *playerView;
@end

@implementation VideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"热门详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //视频播放的url
    NSURL *playerURL = [NSURL URLWithString:self.playUrl];
    
    //初始化
    self.playerView = [[AVPlayerViewController alloc]init];
    
    //AVPlayerItem 视频的一些信息  创建AVPlayer使用的
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:playerURL];
    
    //通过AVPlayerItem创建AVPlayer
    self.player = [[AVPlayer alloc]initWithPlayerItem:item];
    
    //给AVPlayer一个播放的layer层
    layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.videoGravity = AVLayerVideoGravityResize;
    
    layer.frame = CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, 200);
    
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    //设置AVPlayer的填充模式
    layer.videoGravity = AVLayerVideoGravityResize;
    
    [self.view.layer addSublayer:layer];
    
    //设置AVPlayerViewController内部的AVPlayer为刚创建的AVPlayer
    self.playerView.player = self.player;
    self.playerView.showsPlaybackControls = YES;
    //关闭AVPlayerViewController内部的约束
    self.playerView.view.translatesAutoresizingMaskIntoConstraints = YES;
    [self.player play];
    
    maskView = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight+200-44, kDeviceWidth, 44)];
    maskView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    UIButton *playBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 44, 44)];
    [playBtn setImage:[UIImage imageNamed:@"video_half_pauseHL"] forState:UIControlStateNormal];
    [playBtn setImage:[UIImage imageNamed:@"video_fullV_playHL"] forState:UIControlStateSelected];
    [playBtn addTarget:self action:@selector(play_pause:) forControlEvents:UIControlEventTouchUpInside];
    [maskView addSubview:playBtn];
    
    UIButton *refreshBtn = [[UIButton alloc]initWithFrame:CGRectMake(64, 0, 44, 44)];
    [refreshBtn setImage:[UIImage imageNamed:@"btn_task_refresh"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    [maskView addSubview:refreshBtn];
    
    UIButton *screenBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth-54, 0, 44, 44)];
    [screenBtn setImage:[UIImage imageNamed:@"video_full_screenHL"] forState:UIControlStateNormal];
    [screenBtn addTarget:self action:@selector(screenClick) forControlEvents:UIControlEventTouchUpInside];
    [maskView addSubview:screenBtn];
    
    [self.view addSubview:maskView];
    
}

- (void)play_pause:(UIButton *)sender {
    
    if (sender.selected) {
        sender.selected = NO;
        [self.player play];
        
    }else {
        sender.selected = YES;
        [self.player pause];
    }
}

- (void)refreshClick {
    
}

- (void)screenClick {
    
    layer.frame = CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kHomeBarHeight);
}


@end
