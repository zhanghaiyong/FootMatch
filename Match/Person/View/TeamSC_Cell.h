//
//  TeamSC_Cell.h
//  Match
//
//  Created by zhy on 2017/10/18.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamSCModel.h"
@interface TeamSC_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tineLab;
@property (weak, nonatomic) IBOutlet UILabel *PETypeLab;
@property (weak, nonatomic) IBOutlet UIImageView *oneTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *oneTeamScore;
@property (weak, nonatomic) IBOutlet UIImageView *twoTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *twoTeamScore;
@property (weak, nonatomic) IBOutlet UILabel *oneTeamName;
@property (weak, nonatomic) IBOutlet UILabel *twoTeamName;

@property (nonatomic,strong)TeamSCModel *model;

@end
