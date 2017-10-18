//
//  FindTableViewController.m
//  Match
//
//  Created by zhy on 2017/10/18.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "FindTableViewController.h"
#import "PersonViewController.h"
#import "CircelsViewController.h"
#import "FollowViewController.h"
#import "StatisticsViewController.h"
@interface FindTableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
}
@end

@implementation FindTableViewController

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
    self.title = @"发现";
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kHomeBarHeight)];
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    

    self.view.backgroundColor = [UIColor fromHexValue:0xEBEBEB];
    [self setRightBarButtonItem];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        
        return 4;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuser = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuser];
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"竞彩";
                cell.imageView.image = [UIImage imageNamed:@"竞彩"];
                break;
            case 1:
                cell.textLabel.text = @"圈子";
                cell.imageView.image = [UIImage imageNamed:@"圈子"];
                break;
            case 2:
                cell.textLabel.text = @"关注";
                cell.imageView.image = [UIImage imageNamed:@"关注"];
                break;
            case 3:
                cell.textLabel.text = @"数据";
                cell.imageView.image = [UIImage imageNamed:@"video_fullV_danmuopenHL"];
                break;
            default:
                break;
        }
    }else {
        cell.textLabel.text = @"一起看球";
        cell.imageView.image = [UIImage imageNamed:@"tabMineHL"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                PersonViewController *personVC = [[PersonViewController alloc]init];
                personVC.title  = @"竞彩";
                personVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:personVC animated:YES];
            }
                break;
            case 1:
            {
                CircelsViewController *CircelsVC = [[CircelsViewController alloc]init];
                CircelsVC.title  = @"圈子";
                CircelsVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:CircelsVC animated:YES];
                
            }
                break;
            case 2:
            {
                FollowViewController *FollowVC = [[FollowViewController alloc]init];
                FollowVC.title  = @"关注";
                FollowVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:FollowVC animated:YES];
                
            }
                break;
            case 3:
            {
                StatisticsViewController *StatisticsVC = [[StatisticsViewController alloc]init];
                StatisticsVC.title  = @"数据";
                StatisticsVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:StatisticsVC animated:YES];
                
            }
                break;
                
            default:
                break;
        }
    }else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"敬请期待" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
