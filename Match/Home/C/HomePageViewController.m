//
//  HomePageViewController.m
//  Match
//
//  Created by zhy on 2017/9/30.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "HomePageViewController.h"
#import "SegmentTitView.h"

@interface HomePageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *collectionView;
}
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SegmentTitView *segmentView = [[SegmentTitView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 44) titles:@[@"热门",@"快讯",@"集锦",@"综合体育"]];
    self.navigationItem.titleView = segmentView;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kTabBarHeight-kHomeBarHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
 
    collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kTabBarHeight-kHomeBarHeight) collectionViewLayout:layout];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
}


@end
