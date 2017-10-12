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
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setRightBarButtonItem {
    
    _avatarBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_avatarBtn setTitle:@"未登录" forState:UIControlStateNormal];
    _avatarBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _avatarBtn.contentMode = UIViewContentModeCenter;
    [_avatarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_avatarBtn addTarget:self action:@selector(avatarTap) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:_avatarBtn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)avatarTap {
    
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

@end
