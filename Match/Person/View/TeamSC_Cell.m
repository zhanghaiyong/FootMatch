//
//  TeamSC_Cell.m
//  Match
//
//  Created by zhy on 2017/10/18.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "TeamSC_Cell.h"

@implementation TeamSC_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(TeamSCModel *)model {
    _model = model;
    
    self.tineLab.text = [Uitils yearDayIntervalString:model.beginTime];
    self.PETypeLab.text =model.leagueName;
    [self.oneTeamLogo sd_setImageWithURL:[NSURL URLWithString:model.homeTeamLogo] placeholderImage:[UIImage imageNamed:@"default"]];
    [self.twoTeamLogo sd_setImageWithURL:[NSURL URLWithString:model.awayTeamLogo] placeholderImage:[UIImage imageNamed:@"default"]];
    self.oneTeamName.text = model.homeTeamName;
    self.twoTeamName.text = model.awayTeamName;
    
    if ([model.homeScore integerValue] > 0) {
        self.twoTeamScore.hidden = NO;
        self.oneTeamScore.hidden = NO;
        self.oneTeamScore.text = model.homeScore;
        self.twoTeamScore.text = model.awayScore;
    }else {
        
        self.twoTeamScore.text = [Uitils yearDayIntervalString:model.beginTime];
        self.twoTeamScore.hidden = NO;
        self.oneTeamScore.hidden = YES;
    }   
}

@end
