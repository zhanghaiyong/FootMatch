//
//  JJDataView.m
//  Match
//
//  Created by zhy on 2017/10/23.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "SpecialTopicView.h"
#import "NormalHotCell.h"

@interface SpecialTopicView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
    NSMutableArray *matchDataSource;
    NSInteger page;
    NSString *loadUrl;
}
@end

@implementation SpecialTopicView


- (instancetype)initWithFrame:(CGRect)frame url:(NSString *)url
{
    self = [super initWithFrame:frame];
    if (self) {
        loadUrl = url;
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    tableView.tableFooterView = [UIView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    [self addSubview:tableView];
    
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreData];
    }];
    [tableView.mj_header beginRefreshing];
}
- (void)refreshData {
    
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&page=0",loadUrl] params:nil success:^(id responseObj) {
        [tableView.mj_header endRefreshing];
        if ([responseObj[@"error_code"] integerValue] == 1) {
            matchDataSource = [SpecialTopicModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            [tableView reloadData];
        }
    } failure:^(NSError *error) {
        [tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData {
    
    page ++;
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&page=%ld",loadUrl,page] params:nil success:^(id responseObj) {
        [tableView.mj_footer endRefreshing];
        if ([responseObj[@"error_code"] integerValue] == 1) {
            
            [matchDataSource addObjectsFromArray:[SpecialTopicModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]]];
            [tableView reloadData];
        }
    } failure:^(NSError *error) {
        [tableView.mj_footer endRefreshing];
    }];
}

#pragma mark UITableViewDelegate

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
    
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SpecialTopicModel *model = matchDataSource[indexPath.row];

    static NSString *reuser = @"normalCell";
    NormalHotCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NormalHotCell" owner:self options:nil] lastObject];
    }
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"defaultNews"]];
    cell.title.text = model.desc;
    cell.time.text = [Uitils timeWithTimeIntervalString:[NSString stringWithFormat:@"%zi",[[NSDate date]timeIntervalSince1970]]];
    [cell.check setTitle:[NSString stringWithFormat:@"☞ %d",arc4random()] forState:UIControlStateNormal];
    [cell.comment setTitle:[NSString stringWithFormat:@"✬ %d",arc4random()] forState:UIControlStateNormal];
    return cell;
}

    
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

            SpecialTopicModel *model = matchDataSource[indexPath.row];
        if (_SpecialtoDetailBack) {
            _SpecialtoDetailBack(model);
        }

}

@end

