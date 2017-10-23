//
//  ChannelViewController.m
//  Match
//
//  Created by zhy on 2017/10/23.
//  Copyright © 2017年 zhy. All rights reserved.
//
#define SHCollectionReusableViewHeader  @"CollectionHeader"
#import "ChannelViewController.h"
#import "ChannelCell.h"
#import "ChannelHeadView.h"
@interface ChannelViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *collection;
    NSMutableArray *allData;
}
@end

@implementation ChannelViewController

- (void)editedChannelAction {
    
    if (_EditedChannelBack) {
        _EditedChannelBack(allData[0]);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addChannerItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editedChannelAction)];
    self.navigationItem.rightBarButtonItem = addChannerItem;
    
    self.title = @"栏目定制";
    self.view.backgroundColor = [UIColor whiteColor];
    allData = [NSMutableArray array];
    NSArray *AllDataArray = @[@"热门",@"集锦",@"视频",@"专题",@"欧冠",@"法甲",@"意甲",@"德甲",@"中超",@"西甲",@"CBA",@"英超",@"NBA"];
    NSMutableArray *otherData = [NSMutableArray array];
    
    for (NSString *str in AllDataArray) {
        
        if (![self.alreadData containsObject:str]) {
            [otherData addObject:str];
        }
    }
    
    [allData addObject:self.alreadData];
    [allData addObject:otherData];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kDeviceWidth/3, 44);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kHomeBarHeight) collectionViewLayout:layout];
    collection.delegate = self;
    collection.dataSource = self;
    collection.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [collection registerNib:[UINib nibWithNibName:@"ChannelHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SHCollectionReusableViewHeader];
    [collection registerNib:[UINib nibWithNibName:@"ChannelCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];

    [self.view addSubview:collection];
    
}

#pragma mark UICollectionVewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return allData.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *array = allData[section];
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChannelCell *MyCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    MyCell.layer.borderColor = [UIColor whiteColor].CGColor;
    MyCell.layer.borderWidth = 1;
    NSArray *array = allData[indexPath.section];
    MyCell.contentLab.text = array[indexPath.item];
    return MyCell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if(kind == UICollectionElementKindSectionHeader) {

        ChannelHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SHCollectionReusableViewHeader forIndexPath:indexPath];
        if (indexPath.section == 0) {
            NSArray *oneArray = allData[0];
            if (oneArray.count > 0) {
                headerView.titleLab.text = @".已添加的栏目(点击删除栏目)";
            }else {
                headerView.titleLab.text = @".暂无栏目";
            }
        }else {
            NSArray *twoArray = allData[1];
            if (twoArray.count > 0) {
                headerView.titleLab.text = @".未添加的栏目(点击添加栏目)";
            }else {
                headerView.titleLab.text = @".已添加全部栏目";
            }
        }
        return headerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    return CGSizeMake(self.view.width,30);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = allData[indexPath.section];
    if (indexPath.section == 0) {
        
        NSMutableArray *oneData = allData[0];
        if (oneData.count >= 5) {
            NSMutableArray *twoData = allData[1];
            [twoData addObject:array[indexPath.item]];
               
            [oneData removeObjectAtIndex:indexPath.item];
            
            [allData replaceObjectAtIndex:0 withObject:oneData];
            [allData replaceObjectAtIndex:1 withObject:twoData];
            [collection reloadData];
        }
    }else {
        
        NSMutableArray *oneData = allData[0];
        [oneData addObject:array[indexPath.item]];
        
        NSMutableArray *twoData = allData[1];
        [twoData removeObjectAtIndex:indexPath.item];
        
        [allData replaceObjectAtIndex:0 withObject:oneData];
        [allData replaceObjectAtIndex:1 withObject:twoData];
        [collection reloadData];
    }
}


@end
