//
//  TeamDetailViewController.m
//  Match
//
//  Created by zhy on 2017/10/18.
//  Copyright © 2017年 zhy. All rights reserved.
//
#define headH 100
#define segmentH 40
#import "TeamDetailViewController.h"
#import "TeamDetailHead.h"
#import "SegmentTitView.h"
#import "TeamSCModel.h"
#import "TeamSC_Cell.h"
#import "NormalHotCell.h"
#import "HotModel.h"
#import "VideoHotCell.h"
#import "HotDetailViewController.h"
#import "VideoDetailViewController.h"
@interface TeamDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    TeamDetailHead *teamHead;
    
    UITableView *scTable;
    UITableView *FousTable;
    
    NSMutableArray *SC_arr;
    NSInteger SCPageReude;
    NSInteger SCPageAdd;
    
    NSInteger fousPage;
    NSMutableArray *FousDataSource;
    
    
    UIWebView *webView;
}
@end

@implementation TeamDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak TeamDetailViewController *weakSelf = self;
    
    SCPageReude = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    SC_arr = [NSMutableArray array];
    teamHead = [[[NSBundle mainBundle] loadNibNamed:@"TeamDetailHead" owner:self options:nil] lastObject];;
    teamHead.frame =CGRectMake(0, 0, kDeviceWidth, headH);
    teamHead.backBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:teamHead];
    
    [self requestHeadData];

    SegmentTitView *segmentView = [[SegmentTitView alloc]initWithFrame:CGRectMake(0, teamHead.bottom, kDeviceWidth, segmentH) titles:@[@"赛程",@"新闻",@"球员"]];
    segmentView.tapLabBack = ^(NSInteger index) {
        
        switch (index) {
            case 0:
                scTable.hidden = NO;
                FousTable.hidden = YES;
                webView.hidden = YES;
                if (SC_arr.count == 0) {
                    [scTable.mj_header beginRefreshing];
                }
                break;
            case 1:
                scTable.hidden = YES;
                FousTable.hidden = NO;
                webView.hidden = YES;
                if (FousDataSource.count == 0) {
                    [FousTable.mj_header beginRefreshing];
                }
                break;
            case 2:
                scTable.hidden = YES;
                FousTable.hidden = YES;
                webView.hidden = NO;
                break;
                
            default:
                break;
        }
        
    };
    [self.view addSubview:segmentView];
    
    scTable = [[UITableView alloc]initWithFrame:CGRectMake(0, segmentView.bottom, kDeviceWidth, KDeviceHeight-headH-segmentH-kHomeBarHeight)];
    scTable.delegate = self;
    scTable.dataSource = self;
    scTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshSCData];
    }];
    scTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreSCData];
    }];
    [self.view addSubview:scTable];
    [scTable.mj_header beginRefreshing];
    
//新闻
    FousTable = [[UITableView alloc]initWithFrame:CGRectMake(0, segmentView.bottom, kDeviceWidth, KDeviceHeight-headH-segmentH-kHomeBarHeight)];
    FousTable.delegate = self;
    FousTable.dataSource = self;
    FousTable.hidden = YES;
    FousTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshFous];
    }];
    FousTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreFous];
    }];
    [self.view addSubview:FousTable];
    
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, segmentView.bottom, kDeviceWidth, KDeviceHeight-headH-segmentH-kHomeBarHeight)];
    webView.hidden = YES;
    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?teamId=%@",kTeamDetailPlayer,self.teamId]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

#pragma mark 新闻
- (void)refreshFous {
    
    //&page=0
    [FousTable.mj_header endRefreshing];
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&page=0&teamId=%@",kTeamDetailNews,self.teamId] params:nil success:^(id responseObj) {
        if ([responseObj[@"error_code"] integerValue] == 1) {
            FousDataSource = [HotModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            [FousTable reloadData];
        }
    } failure:^(NSError *error) {
        [FousTable.mj_header endRefreshing];
    }];
}

- (void)loadMoreFous {
    
    [FousTable.mj_footer endRefreshing];
    fousPage ++;
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&page=%ld&teamId=%@",kTeamDetailNews,fousPage,self.teamId] params:nil success:^(id responseObj) {
        if ([responseObj[@"error_code"] integerValue] == 1) {
            [FousDataSource addObjectsFromArray:[HotModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]]];
            [FousTable reloadData];
        }
    } failure:^(NSError *error) {
        [FousTable.mj_footer endRefreshing];
    }];
}

- (void)requestHeadData {
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&teamId=%@",kTeamDetailMain,self.teamId] params:nil success:^(id responseObj) {
        
        if ([responseObj[@"error_code"] integerValue] == 1) {
            
            if (teamHead) {
                NSDictionary *dic = responseObj[@"data"];
                [teamHead.logo sd_setImageWithURL:dic[@"logo"] placeholderImage:[UIImage imageNamed:@"default"]];
                teamHead.nameLab.text = dic[@"name"];
                teamHead.scoreLab.text = dic[@"war"];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark 赛程
- (void)refreshSCData {
    
    [scTable.mj_header endRefreshing];
    [SVProgressHUD show];
    SCPageReude --;
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&teamId=%@&page=%ld",kTeamDetailSC,self.teamId,SCPageReude] params:nil success:^(id responseObj) {
        
        [SVProgressHUD dismiss];
        if ([responseObj[@"error_code"] integerValue] == 1) {
            NSArray *array = [TeamSCModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            
            for (NSInteger i = array.count-1; i>=0; i--) {
                [SC_arr insertObject:array[i] atIndex:0];
            }
            [scTable reloadData];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [scTable.mj_header endRefreshing];
    }];
}

- (void)loadMoreSCData {
    
    [SVProgressHUD show];
    [scTable.mj_footer endRefreshing];
    SCPageAdd ++;
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&teamId=%@&page=%ld",kTeamDetailSC,self.teamId,SCPageAdd] params:nil success:^(id responseObj) {
        [SVProgressHUD dismiss];
        if ([responseObj[@"error_code"] integerValue] == 1) {
            NSArray *array = [TeamSCModel mj_keyValuesArrayWithObjectArray:responseObj[@"data"]];
            [SC_arr addObjectsFromArray:array];
            [scTable reloadData];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [scTable.mj_footer endRefreshing];
    }];
}

#pragma mark UITableViewDelagate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == scTable) {
        return SC_arr.count;
    }else if (tableView == FousTable) {
        return FousDataSource.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == scTable) {
        
        return 120;
    }else if (tableView == FousTable) {
        HotModel *model = FousDataSource[indexPath.row];
        //视频
        if ([model.hasVideo integerValue] == 1) {
            
            return kDeviceWidth/4*3;
        }
        return 80;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == scTable) {
        static NSString *reuser = @"sccell";
        TeamSC_Cell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TeamSC_Cell" owner:self options:nil] lastObject];
        }
        
        TeamSCModel *model = SC_arr[indexPath.row];
        cell.model = model;
        
        return cell;
    }else if (tableView == FousTable) {
        HotModel *model = FousDataSource[indexPath.row];
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
        }
        
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
    
    if (tableView == FousTable) {
        HotModel *model = FousDataSource[indexPath.row];
        if ([model.hasVideo integerValue] == 1) {
            
            VideoDetailViewController *videoDetailVC = [[VideoDetailViewController alloc]init];
            videoDetailVC.playUrl = model.url;
            videoDetailVC.title = @"热门详情";
            videoDetailVC.newsId = model.newsId;
            videoDetailVC.videoTitle = model.title;
            [self.navigationController pushViewController:videoDetailVC animated:YES];
            
        }else {
            
            HotDetailViewController *hotDetailVC = [[HotDetailViewController alloc]init];
            hotDetailVC.title = @"热门详情";
            hotDetailVC.newsId = model.newsId;
            hotDetailVC.newsTitle = model.title;
            [self.navigationController pushViewController:hotDetailVC animated:YES];
        }
    }
    

}



@end
