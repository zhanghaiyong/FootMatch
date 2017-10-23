//
//  MatchViewController.m
//  Match
//
//  Created by zhy on 2017/9/30.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "MatchViewController.h"
#import "FastNewsModel.h"
#import "FastNewsCell.h"
#import "HotDetailViewController.h"
#import "SegmentTitView.h"
@interface MatchViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
    NSMutableArray *matchDataSource;
    NSInteger page;
    NSInteger newsType;
}
@end

@implementation MatchViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AccountModel *model = [AccountModel account];
    //有帐号
    if ([model.status isEqualToString:@"YES"]) {
        [self.avatarBtn setImage:model.avatar forState:UIControlStateNormal];
        [self.avatarBtn setTitle:@"" forState:UIControlStateNormal];
    }else {
        [self.avatarBtn setImage:nil forState:UIControlStateNormal];
        [self.avatarBtn setTitle:@"未登录" forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"快讯";
    [self setRightBarButtonItem];
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kHomeBarHeight-49)];
    
    SegmentTitView *segment = [[SegmentTitView alloc]initWithFrame:CGRectMake(kDeviceWidth-120, 0, 120, 30) titles:@[@"全部",@"足球",@"篮球"]];
    segment.tapLabBack = ^(NSInteger index) {
        newsType = index;
        [tableView.mj_header beginRefreshing];
    };
    tableView.tableFooterView = [UIView new];
    tableView.tableHeaderView = segment;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    [self.view addSubview:tableView];
    [tableView.mj_header beginRefreshing];
}

- (void)refreshData {
    
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&page=0&type=%ld",FastNewsAll,newsType] params:nil success:^(id responseObj) {
        [tableView.mj_header endRefreshing];
        if ([responseObj[@"error_code"] integerValue] == 1) {
            matchDataSource = [FastNewsModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            [tableView reloadData];
        }
    } failure:^(NSError *error) {
        [tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData {
    
    page ++;
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&page=%ld&type=%ld",FastNewsAll,page,newsType] params:nil success:^(id responseObj) {
        [tableView.mj_footer endRefreshing];
        if ([responseObj[@"error_code"] integerValue] == 1) {
            
            [matchDataSource addObjectsFromArray:[FastNewsModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]]];
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
    
    return matchDataSource.count;
}

//cellH
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FastNewsModel *model = matchDataSource[indexPath.row];
    if (model.fold) {
        return model.cellH;
    }
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuser = @"FastNewsCell";
    FastNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FastNewsCell" owner:self options:nil] lastObject];
    }
    
    FastNewsModel *model = matchDataSource[indexPath.row];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"defaultVideo"]];
    cell.timeLab.text = [Uitils yearDayIntervalString:model.pubTime];
    cell.contentLab.text = model.desc;
    cell.foldBtn.selected = model.fold;
    
    cell.FoldBlock = ^(BOOL isFold) {
        
        ((FastNewsModel *)matchDataSource[indexPath.row]).fold = isFold;
        [tableView beginUpdates];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:isFold ? UITableViewRowAnimationBottom : UITableViewRowAnimationTop];
        [tableView endUpdates];
    };
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FastNewsModel *model = matchDataSource[indexPath.row];
    HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
    hotDetailVC.title = @"热门详情";
    hotDetailVC.newsId = model.newsId;
    hotDetailVC.newsTitle = model.title;
    hotDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hotDetailVC animated:YES];

}



@end
