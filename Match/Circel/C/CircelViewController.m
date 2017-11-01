//
//  CircelViewController.m
//  Match
//
//  Created by zhy on 2017/9/30.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "CircelViewController.h"
#import "PersonMsgTableViewController.h"
#import "LoginTableViewController.h"
@interface CircelViewController ()

@end

@implementation CircelViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AccountModel *model = [AccountModel account];
    //有帐号
    if ([model.status isEqualToString:@"YES"]) {
        UIStoryboard *SB = [UIStoryboard storyboardWithName:@"PersonMsg" bundle:nil];
        PersonMsgTableViewController *persinMsgVC = [SB instantiateViewControllerWithIdentifier:@"PersonMsgTableViewController"];
        persinMsgVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:persinMsgVC animated:YES];
        self.tabBarController.selectedIndex = 0;
        
    }else {
        UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        LoginTableViewController *LoginVC = [SB instantiateViewControllerWithIdentifier:@"LoginTableViewController"];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:LoginVC];
        [self presentViewController:navi animated:YES completion:^{
            self.tabBarController.selectedIndex = 0;
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

@end
