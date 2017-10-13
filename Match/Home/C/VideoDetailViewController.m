//
//  VideoDetailViewController.m
//  Match
//
//  Created by 张海勇 on 2017/10/1.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "VideoDetailViewController.h"


@interface VideoDetailViewController ()<UIWebViewDelegate>
{
    UIButton *sharebtn;
}
@end

@implementation VideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    sharebtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [sharebtn sizeToFit];
    [sharebtn addTarget:self action:@selector(shareNews) forControlEvents:UIControlEventTouchUpInside];
    [sharebtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [sharebtn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateSelected];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithCustomView:sharebtn];
    self.navigationItem.rightBarButtonItem = shareItem;
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, 200)];
    webView.scrollView.bounces = NO;
    webView.delegate = self;
    webView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:self.playUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    CGRect frame = [self.videoTitle boundingRectWithSize:CGSizeMake(kDeviceWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, webView.bottom, kDeviceWidth, frame.size.height)];
    label.text = self.videoTitle;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:label];

}

- (void)shareNews {
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[self.videoTitle, self.playUrl] applicationActivities:nil];
    [self presentViewController:activity animated:YES completion:NULL];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [SVProgressHUD dismiss];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    sharebtn.selected = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD dismiss];
}

@end
