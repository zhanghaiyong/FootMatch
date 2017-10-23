//
//  HomePageDataView.m
//  Match
//
//  Created by zhy on 2017/10/23.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "HotDataView.h"
#import "NormalHotCell.h"
#import "HotModel.h"
#import "VideoHotCell.h"

@interface HotDataView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
    NSMutableArray *hotDataSource;
    NSInteger page;
    NSString *loadUrl;
}
@end

@implementation HotDataView

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
    
    //&page=0
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&page=0",loadUrl] params:nil success:^(id responseObj) {
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
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&page=%ld",loadUrl,page] params:nil success:^(id responseObj) {
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
        
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"defaultVideo"]];
        cell.title.text = model.title;
        cell.time.text = [Uitils timeWithTimeIntervalString:model.pubTime];
        [cell.check setTitle:[NSString stringWithFormat:@"☞ %@",model.read] forState:UIControlStateNormal];
        [cell.comment setTitle:[NSString stringWithFormat:@"✬ %@",model.comment] forState:UIControlStateNormal];
        
        return cell;
    }else {
    
    static NSString *reuser = @"normalCell";
    NormalHotCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NormalHotCell" owner:self options:nil] lastObject];
    }
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"defaultNews"]];
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
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HotModel *model = hotDataSource[indexPath.row];
    if ([model.hasVideo integerValue] == 1) {
        
        if (_toDetailBack) {
            _toDetailBack(model);
        }
    }else {
        
        if (_toVideoBacl) {
            _toVideoBacl(model);
        }

    }
}



@end
