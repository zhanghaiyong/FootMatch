//
//  BaseViewController.m
//  Match
//
//  Created by zhy on 2017/10/12.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginTableViewController.h"
#import "RegisterTableViewController.h"
#import "PersonMsgTableViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setRightBarButtonItem {
    
    _avatarBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth-50, kStatusBarHeight, 44, 44)];
    [_avatarBtn setTitle:@"未登录" forState:UIControlStateNormal];
    _avatarBtn.layer.cornerRadius = 22;
    _avatarBtn.layer.masksToBounds = YES;
    _avatarBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [[_avatarBtn imageView] setContentMode:UIViewContentModeScaleToFill];
    [_avatarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_avatarBtn addTarget:self action:@selector(avatarTap) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.view addSubview: _avatarBtn];
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:_avatarBtn];
//    self.navigationItem.rightBarButtonItem = item;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _avatarBtn.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _avatarBtn.hidden = YES;
}

- (void)avatarTap {
    
    AccountModel *model = [AccountModel account];
    //有帐号
    if ([model.status isEqualToString:@"YES"]) {
        UIStoryboard *SB = [UIStoryboard storyboardWithName:@"PersonMsg" bundle:nil];
        PersonMsgTableViewController *persinMsgVC = [SB instantiateViewControllerWithIdentifier:@"PersonMsgTableViewController"];
        persinMsgVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:persinMsgVC animated:YES];
    }else {
    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录解锁更多内容" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"登录/注册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            LoginTableViewController *LoginVC = [SB instantiateViewControllerWithIdentifier:@"LoginTableViewController"];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:LoginVC];
            [self presentViewController:navi animated:YES completion:nil];
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
