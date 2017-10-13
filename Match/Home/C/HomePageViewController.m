//
//  HomePageViewController.m
//  Match
//
//  Created by zhy on 2017/9/30.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "HomePageViewController.h"
#import "NormalHotCell.h"
#import "HotModel.h"
#import "VideoHotCell.h"
#import "HotDetailViewController.h"
#import "VideoDetailViewController.h"
@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
    NSMutableArray *hotDataSource;
    NSInteger page;
}
@end

@implementation HomePageViewController

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
    self.title = @"热门";
    
    [self setRightBarButtonItem];
    
//    AVObject *todoFolder = [AVObject objectWithClassName:@"oneClass"];
    //    [todoFolder setObject:@"http://www.baidu.com" forKey:@"url"];// 设置名称
//    [todoFolder setObject:@"YES" forKey:@"show"];// 设置优先级
//    [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if (!error) {
//            NSLog(@"保存成功");
//        }else {
//            
//            NSLog(@"失败%@",error);
//        }
//    }];// 保存到云端
    
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
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&page=0",kHot] params:nil success:^(id responseObj) {
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
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&page=%ld",kHot,page] params:nil success:^(id responseObj) {
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
    
    HotModel *model = hotDataSource[indexPath.row];
    //视频
    if ([model.hasVideo integerValue] == 1) {
        
        return kDeviceWidth/4*3;
    }
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HotModel *model = hotDataSource[indexPath.row];
    if ([model.hasVideo integerValue] == 1) {
        static NSString *reuser = @"videoCell";
        VideoHotCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"VideoHotCell" owner:self options:nil] lastObject];
        }
        
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"上方大图"]];
        cell.title.text = model.title;
        cell.time.text = [Uitils timeWithTimeIntervalString:model.pubTime];
        [cell.check setTitle:[NSString stringWithFormat:@"☞ %@",model.read] forState:UIControlStateNormal];
        [cell.comment setTitle:[NSString stringWithFormat:@"✬ %@",model.comment] forState:UIControlStateNormal];
        
        return cell;
    }
    
    static NSString *reuser = @"normalCell";
    NormalHotCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NormalHotCell" owner:self options:nil] lastObject];
    }
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"yuba_note_user_default_icon"]];
    cell.title.text = model.title;
    if ([model.first integerValue] == 1) {
        cell.top.text = @"置顶";
    }else {
        cell.top.text = @"";
    }
    cell.time.text = [Uitils timeWithTimeIntervalString:model.pubTime];
    [cell.check setTitle:[NSString stringWithFormat:@"☞ %@",model.read] forState:UIControlStateNormal];
    [cell.comment setTitle:[NSString stringWithFormat:@"✬ %@",model.comment] forState:UIControlStateNormal];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HotModel *model = hotDataSource[indexPath.row];
    if ([model.hasVideo integerValue] == 1) {
    
        VideoDetailViewController *videoDetailVC = [[VideoDetailViewController alloc]init];
        videoDetailVC.playUrl = model.url;
        videoDetailVC.title = @"热门详情";
        videoDetailVC.newsId = model.newsId;
        videoDetailVC.videoTitle = model.title;
        videoDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:videoDetailVC animated:YES];
        
    }else {
    
        HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
        hotDetailVC.title = @"热门详情";
        hotDetailVC.newsId = model.newsId;
        hotDetailVC.newsTitle = model.title;
        hotDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hotDetailVC animated:YES];
    }
}



@end
