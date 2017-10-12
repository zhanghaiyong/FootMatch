//
//  FindPwdTableViewController.m
//  Match
//
//  Created by zhy on 2017/10/12.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "FindPwdTableViewController.h"

@interface FindPwdTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdOfNewTF;
@property (weak, nonatomic) IBOutlet UIButton *showBtn;


@end

@implementation FindPwdTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";

}
- (IBAction)getCodeAction:(id)sender {
}

- (IBAction)submitAction:(id)sender {
}


@end
