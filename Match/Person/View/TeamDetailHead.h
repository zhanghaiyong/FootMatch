//
//  TeamDetailView.h
//  Match
//
//  Created by zhy on 2017/10/18.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamDetailHead : UIView
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;

@property (nonatomic,copy)void(^backBlock)(void);

@end
