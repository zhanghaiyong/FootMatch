//
//  ChannelViewController.h
//  Match
//
//  Created by zhy on 2017/10/23.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelViewController : UIViewController
@property (nonatomic,strong)NSMutableArray *alreadData;

@property (nonatomic,copy)void (^EditedChannelBack)(NSArray *channels);
@end
