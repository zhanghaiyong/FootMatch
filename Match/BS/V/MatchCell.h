//
//  MatchCell.h
//  Match
//
//  Created by zhy on 2017/10/9.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchModel.h"
@interface MatchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImg;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamName;
@property (weak, nonatomic) IBOutlet UIImageView *homeTeamLogo;
@property (weak, nonatomic) IBOutlet UIImageView *awayTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamName;
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (nonatomic,strong)MatchModel *matchModel;
@end
