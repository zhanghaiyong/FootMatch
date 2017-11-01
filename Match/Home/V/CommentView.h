//
//  CommentView.h
//  Match
//
//  Created by zhy on 2017/10/13.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentView : UIView
@property (weak, nonatomic) IBOutlet UIButton *tapToCommentBtn;
@property (nonatomic,copy)void (^shareNewsBack)(void);
@property (nonatomic,copy)void (^commentBack)(void);
@property (nonatomic,copy)void (^CollectBack)(void);
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@end
