//
//  NOTeamView.h
//  Match
//
//  Created by zhy on 2017/10/18.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NOTeamView : UIView
@property (weak, nonatomic) IBOutlet UIButton *FollowBtn;
@property (nonatomic,copy)void (^toFollowTeamBack)(void);
@end
