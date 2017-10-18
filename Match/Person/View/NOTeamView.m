//
//  NOTeamView.m
//  Match
//
//  Created by zhy on 2017/10/18.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "NOTeamView.h"

@implementation NOTeamView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)tapToFollowClick:(id)sender {
    
    if (_toFollowTeamBack) {
        _toFollowTeamBack();
    }
}

@end
