//
//  CircelViewController.m
//  Match
//
//  Created by zhy on 2017/9/30.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "CircelViewController.h"
#import "HotModel.h"
#import "NormalHotCell.h"
#import "HotDetailViewController.h"
@interface CircelViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
    NSMutableArray *hotDataSource;
    NSInteger page;
}

@end

@implementation CircelViewController
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
    
    self.title = @"国足加油";
    [self setRightBarButtonItem];
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kHomeBarHeight-49)];
    tableView.tableFooterView = [UIView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    [self.view addSubview:tableView];
    
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreData];
    }];
    [tableView.mj_header beginRefreshing];
}

- (void)refreshData {
    
    //&page=0
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&page=0",kChinaFootBall] params:nil success:^(id responseObj) {
        [tableView.mj_header endRefreshing];
        if ([responseObj[@"error_code"] integerValue] == 1) {
            hotDataSource = [HotModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            [tableView reloadData];
        }
    } failure:^(NSError *error) {
        [tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData {
    
    page ++;
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&page=%ld",kChinaFootBall,page] params:nil success:^(id responseObj) {
        [tableView.mj_footer endRefreshing];
        if ([responseObj[@"error_code"] integerValue] == 1) {
            
            [hotDataSource addObjectsFromArray:[HotModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]]];
            [tableView reloadData];
        }
    } failure:^(NSError *error) {
        [tableView.mj_footer endRefreshing];
    }];
}

#pragma mark UITableViewDelegate

//sectionCount
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

//rowCount
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return hotDataSource.count;
}

//cellH
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HotModel *model = hotDataSource[indexPath.row];

    static NSString *reuser = @"normalCell";
    NormalHotCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NormalHotCell" owner:self options:nil] lastObject];
    }
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"yuba_note_user_default_icon"]];
    cell.title.text = model.title;
    cell.top.text = @"";
    cell.time.text = [Uitils timeWithTimeIntervalString:model.pubTime];
    [cell.check setTitle:[NSString stringWithFormat:@"☞ %@",model.read] forState:UIControlStateNormal];
    [cell.comment setTitle:[NSString stringWithFormat:@"✬ %@",model.comment] forState:UIControlStateNormal];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HotModel *model = hotDataSource[indexPath.row];

    HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
    hotDetailVC.newsId = model.newsId;
    hotDetailVC.newsTitle = model.title;
    hotDetailVC.title = @"关注国足";
    hotDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hotDetailVC animated:YES];

}


@end
