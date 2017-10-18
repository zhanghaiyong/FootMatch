//
//  MoreTeamViewController.m
//  Match
//
//  Created by zhy on 2017/10/18.
//  Copyright © 2017年 zhy. All rights reserved.
//

#define kLocalPath [NSHomeDirectory() stringByAppendingPathComponent:@"data.archiver"]
#define TableW  120
#import "MoreTeamViewController.h"
#import "TeamModel.h"
#import "TeamTyoeModel.h"
#import "CollectionViewCell.h"
#import "TeamTableViewCell.h"
@interface MoreTeamViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *dataArray;
    UITableView *Table;
    UICollectionView *collection;
    NSInteger tableRow;
    
    NSMutableArray *collectArr;
}
@end

@implementation MoreTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    collectArr = [NSMutableArray array];
    self.title = @"更多球队";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *FollowTeam = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [FollowTeam addTarget:self action:@selector(FollowTeamClick) forControlEvents:UIControlEventTouchUpInside];
    [FollowTeam setTitle:@"关注" forState:UIControlStateNormal];
    FollowTeam.titleLabel.font = [UIFont systemFontOfSize:13];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:FollowTeam];
    self.navigationItem.rightBarButtonItem = item;
    
    Table = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, TableW, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kHomeBarHeight)];
    Table.tableFooterView = [UIView new];
    Table.backgroundColor = [UIColor clearColor];
    Table.delegate = self;
    Table.dataSource = self;
    [self.view addSubview:Table];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kDeviceWidth-TableW)/3, (kDeviceWidth-TableW)/3+20);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    collection = [[UICollectionView alloc]initWithFrame:CGRectMake(TableW, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth-TableW, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kHomeBarHeight) collectionViewLayout:layout];
    collection.delegate = self;
    collection.dataSource = self;
    collection.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [collection registerNib:[UINib nibWithNibName:[CollectionViewCell.class description] bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.view addSubview:collection];
    

    [self requestData];
}

- (void)FollowTeamClick {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:collectArr];
    //保存账号信息：数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
    //好处：以后我不想归档，用数据库，直接改业务类
    [Uitils setUserDefaultsObject:data ForKey:KTeamKey];
    [SVProgressHUD showSuccessWithStatus:@"关注成功"];
}

#pragma mark UICollectionVewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    TeamTyoeModel *model = dataArray[tableRow];
    return model.teams.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *MyCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    TeamTyoeModel *typeModel = dataArray[tableRow];
    TeamModel *model = typeModel.teams[indexPath.item];
    MyCell.nameLab.text = model.name;
    [MyCell.imageV sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default"]];
    MyCell.layer.borderColor = [UIColor clearColor].CGColor;
    MyCell.layer.borderWidth = 1;
    return MyCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *MyCell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (((TeamModel *)((TeamTyoeModel *)dataArray[tableRow]).teams[indexPath.row]).isSelect) {
        ((TeamModel *)((TeamTyoeModel *)dataArray[tableRow]).teams[indexPath.row]).isSelect = NO;
        
        [collectArr removeObject:((TeamModel *)((TeamTyoeModel *)dataArray[tableRow]).teams[indexPath.row])];
        
        MyCell.layer.borderColor = [UIColor clearColor].CGColor;
        MyCell.layer.borderWidth = 1;
    }else {
        
        [collectArr addObject:((TeamModel *)((TeamTyoeModel *)dataArray[tableRow]).teams[indexPath.row])];
        
        ((TeamModel *)((TeamTyoeModel *)dataArray[tableRow]).teams[indexPath.row]).isSelect = YES;
        MyCell.layer.borderColor = [UIColor redColor].CGColor;
        MyCell.layer.borderWidth = 1;
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
    
    TeamTyoeModel *typeModel = dataArray[indexPath.row];
    cell.nameLab.text = typeModel.league;
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:typeModel.logo] placeholderImage:[UIImage imageNamed:@"default"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableRow = indexPath.row;
    [collection reloadData];
}

- (void)requestData {
    
    [SVProgressHUD show];
    [KSMNetworkRequest postRequest:KTeamData params:nil success:^(id responseObj) {
    
        [SVProgressHUD dismiss];
        if ([responseObj[@"error_code"] integerValue] == 1) {
            dataArray = [TeamTyoeModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"][@"teams"]];
            [Table reloadData];
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
            [Table selectRowAtIndexPath:index animated:NO scrollPosition:UITableViewScrollPositionNone];
            [collection reloadData];
        }else {
            [SVProgressHUD showErrorWithStatus:@"网络错误，请重试！"];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}


@end
