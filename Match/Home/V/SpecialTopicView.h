//
//  SpecialTopicView.h
//  Match
//
//  Created by zhy on 2017/10/23.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialTopicModel.h"
@interface SpecialTopicView : UIView
- (instancetype)initWithFrame:(CGRect)frame url:(NSString *)url;
@property (nonatomic,copy)void (^SpecialtoDetailBack)(SpecialTopicModel *model);

@end
