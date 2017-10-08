//
//  VideoHotCell.h
//  Match
//
//  Created by 张海勇 on 2017/9/30.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoHotCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *check;
@property (weak, nonatomic) IBOutlet UIButton *comment;

@end
