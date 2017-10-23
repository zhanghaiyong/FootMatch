//
//  JJDataView.h
//  Match
//
//  Created by zhy on 2017/10/23.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchModel.h"
@interface JJDataView : UIView
- (instancetype)initWithFrame:(CGRect)frame url:(NSString *)url;

@property (nonatomic,copy)void (^toDetailBack)(MatchModel *model);
@end
