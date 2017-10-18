//
//  TeamDetailView.m
//  Match
//
//  Created by zhy on 2017/10/18.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "TeamDetailHead.h"

@implementation TeamDetailHead
- (IBAction)backAction:(id)sender {
    if (_backBlock) {
        _backBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
