//
//  HotDetailViewController.m
//  Match
//
//  Created by 张海勇 on 2017/9/30.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "HotDetailViewController.h"
#import "HotDetailCommentModel.h"
#import "HotDetailCommentCell.h"
@interface HotDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
{
    CGFloat webViewH;
    UITableView *tableView;
    NSDictionary *htmlDict;
    NSMutableArray *commentArr;
}
@property (nonatomic,strong)UIWebView *webView;

@end

@implementation HotDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热门详情";
    
    webViewH = 200;
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kHomeBarHeight)];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kHomeBarHeight)];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scrollView.bounces = NO;
    _webView.delegate = self;
    
    tableView.tableHeaderView = _webView;
    tableView.tableFooterView = [UIView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    [self.view addSubview:tableView];
    [tableView.mj_header beginRefreshing];
}

- (void)refreshData {
    
    [KSMNetworkRequest getRequest:[NSString stringWithFormat:@"%@&nid=%@",kHotDetail,self.newsId] params:nil success:^(id responseObj) {
        if ([responseObj[@"error_code"] integerValue] == 1) {
            htmlDict = [NSDictionary dictionaryWithDictionary:responseObj[@"data"]];
            
            [self.webView loadHTMLString:responseObj[@"data"][@"content"] baseURL:nil];
            
        }
    } failure:^(NSError *error) {
        [tableView.mj_header endRefreshing];
    }];
    
    [KSMNetworkRequest getRequest:[NSString stringWithFormat:@"%@&originId=%@",kHotDetailComment,self.newsId] params:nil success:^(id responseObj) {
        [tableView.mj_header endRefreshing];
        if ([responseObj[@"error_code"] integerValue] == 1) {
            commentArr = [HotDetailCommentModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"][@"newList"]];
            [tableView reloadData];
        }
    } failure:^(NSError *error) {
        [tableView.mj_header endRefreshing];
        return;
    }];

}

#pragma mark UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)wb
{
    NSString *height_str = [wb stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
    //document.body.offsetHeight获取页面高度信息
    int temp = (int)height_str.integerValue - 44;
    _webView.frame = CGRectMake(0, 0, kDeviceWidth, temp);
    _webView.scrollView.scrollEnabled = NO;  //禁止滚动
    [tableView reloadData];

}

#pragma mark UITableViewDelegate

//sectionCount
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

//rowCount
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return commentArr.count;
}

//cellH
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotDetailCommentModel *model = commentArr[indexPath.row];
    return model.cellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuser = @"hotComment";
    HotDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HotDetailCommentCell" owner:self options:nil] lastObject];
    }
    HotDetailCommentModel *model = commentArr[indexPath.row];
    [cell.avatar sd_setImageWithURL:[NSURL URLWithString:model.userLogo] placeholderImage:[UIImage imageNamed:@"yuba_note_user_default_icon"]];
    cell.nickLab.text = model.userNickname;
    cell.timeLab.text = [Uitils timeWithTimeIntervalString:model.createTime];
    [cell.TagLab setTitle:[NSString stringWithFormat:@"✯%@",model.approveCount] forState:UIControlStateNormal];
    cell.commentLab.text = model.content;
    
    return cell;
}



@end
