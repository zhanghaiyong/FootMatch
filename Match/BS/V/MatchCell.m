//
//  MatchCell.m
//  Match
//
//  Created by zhy on 2017/10/9.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "MatchCell.h"

@implementation MatchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setMatchModel:(MatchModel *)matchModel {
    _matchModel = matchModel;
    
    self.typeLabel.text = matchModel.leagueName;
    [self.backImg sd_setImageWithURL:[NSURL URLWithString:matchModel.sImgUrl] placeholderImage:[UIImage imageNamed:@"上方大图"]];
    self.scoreLab.text = [NSString stringWithFormat:@"%@:%@",matchModel.nHomeScore,matchModel.nGuestScore];
    self.homeTeamName.text = matchModel.sHomeName;
    [self.homeTeamLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.sHomeLogo] placeholderImage:[UIImage imageNamed:@"yuba_note_user_default_icon"]];
    
    self.awayTeamName.text = matchModel.sGuestName;
    [self.awayTeamLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.sGuestLogo] placeholderImage:[UIImage imageNamed:@"yuba_note_user_default_icon"]];
    
    self.contentLab.text = matchModel.sTitle;
    
}
@end
