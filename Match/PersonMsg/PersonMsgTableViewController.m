//
//  PersonMsgTableViewController.m
//  Match
//
//  Created by zhy on 2017/10/13.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "PersonMsgTableViewController.h"
#import "MsgSettingTableViewController.h"
#import "SignTableViewController.h"
#import "TakePhotoViewController.h"
#import "CollectsTableViewController.h"
@interface PersonMsgTableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    AccountModel *model;
}
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nickLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *emailLab;
@property (weak, nonatomic) IBOutlet UILabel *sexLab;
@property (weak, nonatomic) IBOutlet UITextView *signLab;
@property (weak, nonatomic) IBOutlet UILabel *integralLab;
@property (weak, nonatomic) IBOutlet UIButton *SignInBtn;

@end

@implementation PersonMsgTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    self.tableView.tableFooterView = [UIView new];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btn setImage:[UIImage imageNamed:@"bac"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    model = [AccountModel account];
    self.avatar.image = model.avatar;
    self.nickLab.text = model.nickname;
    self.phoneLab.text = model.account;
    self.emailLab.text = model.email;
    self.sexLab.text = model.sex;
    self.signLab.text = model.signature;
    self.integralLab.text = model.integral;
    
    if ([model.signIn isEqualToString:@"YES"]) {
        [self.SignInBtn setTitle:@"已签到" forState:UIControlStateNormal];
        self.SignInBtn.alpha = 0.4;
        self.SignInBtn.userInteractionEnabled = NO;
    }else {
        [self.SignInBtn setTitle:@"签到" forState:UIControlStateNormal];
        self.SignInBtn.alpha = 1;
        self.SignInBtn.userInteractionEnabled = YES;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(repeatAvatar)];
    [self.avatar addGestureRecognizer:tap];
}

- (void)repeatAvatar {
    TakePhotoViewController *takePhotoVC = [[TakePhotoViewController alloc]init];
    [takePhotoVC returnImage:^(UIImage *image) {
        
        self.avatar.image = image;
        model.avatar = image;
        [AccountModel saveAccount:model];
    }];
    [self presentViewController:takePhotoVC animated:YES completion:nil];
}

#pragma mark UITablViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) { //昵称
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"PersonMsg" bundle:nil];
            MsgSettingTableViewController *MsgSettingVC = [SB instantiateViewControllerWithIdentifier:@"MsgSettingTableViewController"];
            MsgSettingVC.title = @"修改昵称";
            [self.navigationController pushViewController:MsgSettingVC animated:YES];
        }else if (indexPath.row == 3){ //收藏
            CollectsTableViewController *collectsVC = [[CollectsTableViewController alloc]init];
            collectsVC.title = @"我的收藏";
            [self.navigationController pushViewController:collectsVC animated:YES];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) { //手机号
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"PersonMsg" bundle:nil];
            MsgSettingTableViewController *MsgSettingVC = [SB instantiateViewControllerWithIdentifier:@"MsgSettingTableViewController"];
            MsgSettingVC.title = @"修改手机号";
            [self.navigationController pushViewController:MsgSettingVC animated:YES];
        }else if (indexPath.row == 1) { //邮箱
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"PersonMsg" bundle:nil];
            MsgSettingTableViewController *MsgSettingVC = [SB instantiateViewControllerWithIdentifier:@"MsgSettingTableViewController"];
            MsgSettingVC.title = @"修改邮箱";
            [self.navigationController pushViewController:MsgSettingVC animated:YES];
        }else if (indexPath.row == 2) { //性别

            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                model.sex = @"男";
                self.sexLab.text = @"男";
                [AccountModel saveAccount:model];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                model.sex = @"女";
                self.sexLab.text = @"女";
                [AccountModel saveAccount:model];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            
        }else if (indexPath.row == 3) { //简介
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"PersonMsg" bundle:nil];
            SignTableViewController *SignVC = [SB instantiateViewControllerWithIdentifier:@"SignTableViewController"];
            SignVC.title = @"个人简介";
            [self.navigationController pushViewController:SignVC animated:YES];
        }
    }
}

- (IBAction)logoutAction:(id)sender {
    
    [SVProgressHUD show];
    
    [self performSelector:@selector(delayLogoutAction) withObject:self afterDelay:1];
    model.status = @"NO";
    [AccountModel saveAccount:model];
    
}

- (IBAction)SignInAction:(id)sender {
    
    self.SignInBtn.alpha = 0.4;
    self.SignInBtn.userInteractionEnabled = NO;
    [self.SignInBtn setTitle:@"已签到" forState:UIControlStateNormal];
    
    self.integralLab.text = [NSString stringWithFormat:@"%ld",[self.integralLab.text integerValue] + 100];
    model.integral = self.integralLab.text;
    model.signIn = @"YES";
    [AccountModel saveAccount:model];
    
}

- (void)delayLogoutAction {
    [SVProgressHUD showInfoWithStatus:@"已退出"];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];

}


@end
