//
//  CollectsTableViewController.m
//  Match
//
//  Created by zhy on 2017/11/1.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "CollectsTableViewController.h"
#import "HotDetailViewController.h"
@interface CollectsTableViewController ()
{
    AccountModel *model;
    NSArray *collects;
}
@end

@implementation CollectsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    model = [AccountModel account];
    collects = [NSArray arrayWithArray:model.collects];
    self.tableView.tableFooterView = [UIView new];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return collects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuser = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuser];
    }
    
    NSDictionary *dic = collects[indexPath.row];
    
    cell.textLabel.text = dic[@"newsTitle"];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = collects[indexPath.row];
    HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
    hotDetailVC.title = @"热门详情";
    hotDetailVC.newsId = dic[@"newsId"];
    hotDetailVC.newsTitle = dic[@"newsTitle"];
    [self.navigationController pushViewController:hotDetailVC animated:YES];
}


@end
