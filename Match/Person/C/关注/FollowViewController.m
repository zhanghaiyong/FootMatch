//
//  FollowViewController.m
//  Match
//
//  Created by zhy on 2017/10/18.
//  Copyright © 2017年 zhy. All rights reserved.
//

#define kLocalPath [NSHomeDirectory() stringByAppendingPathComponent:@"data.archiver"]

#import "FollowViewController.h"
#import "TeamModel.h"
#import "MoreTeamViewController.h"
#import "TeamTableViewCell.h"
#import "NOTeamView.h"
#import "TeamDetailViewController.h"
@interface FollowViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableView;
    NSMutableArray *dataArray;
    NOTeamView *noTeamView;
}
@end

@implementation FollowViewController

- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
    [self fetchData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak FollowViewController *weakSelf = self;
    noTeamView = [[[NSBundle mainBundle] loadNibNamed:@"NOTeamView" owner:self options:nil] lastObject];
    noTeamView.frame = CGRectMake(0, 0, 200, 140);
    noTeamView.center = self.view.center;
    noTeamView.hidden = YES;
    noTeamView.FollowBtn.userInteractionEnabled = NO;
    noTeamView.toFollowTeamBack = ^{
        [weakSelf FollowTeamClick];
    };
    [self.view addSubview:noTeamView];
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kHomeBarHeight)];
    tableView.tableFooterView = [UIView new];
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.hidden = YES;
    [self.view addSubview:tableView];
    
    UIButton *FollowTeam = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [FollowTeam addTarget:self action:@selector(FollowTeamClick) forControlEvents:UIControlEventTouchUpInside];
    [FollowTeam setTitle:@"关注更多" forState:UIControlStateNormal];
    FollowTeam.titleLabel.font = [UIFont systemFontOfSize:13];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:FollowTeam];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)fetchData {
    
    NSData *data = [Uitils getUserDefaultsForKey:KTeamKey];
    if (data) {
        dataArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        tableView.hidden = NO;
        noTeamView.hidden = YES;
        noTeamView.FollowBtn.userInteractionEnabled = NO;
        [tableView reloadData];
    }else {
        
        tableView.hidden = YES;
        noTeamView.hidden = NO;
        noTeamView.FollowBtn.userInteractionEnabled = YES;
        [SVProgressHUD showInfoWithStatus:@"暂无关注"];
    }
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuser = @"cell";
    TeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TeamTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.arrowImg.hidden = NO;
    TeamModel *model = dataArray[indexPath.row];
    cell.nameLab.text = model.name;
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TeamDetailViewController *teamDetailVC = [[TeamDetailViewController alloc]init];
    TeamModel *model = dataArray[indexPath.row];
    teamDetailVC.teamId = model.tid;
    [self.navigationController pushViewController:teamDetailVC animated:YES];
}


- (void)FollowTeamClick {
    
    MoreTeamViewController *moreTeamVC = [[MoreTeamViewController alloc]init];
    [self.navigationController pushViewController:moreTeamVC animated:YES];
}

@end
