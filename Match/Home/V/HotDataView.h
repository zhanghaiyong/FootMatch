//
//  HomePageDataView.h
//  Match
//
//  Created by zhy on 2017/10/23.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotModel.h"
@interface HotDataView : UIView
- (instancetype)initWithFrame:(CGRect)frame url:(NSString *)url;
@property (nonatomic,copy)void (^toDetailBack)(HotModel *model);
@property (nonatomic,copy)void (^toVideoBacl)(HotModel *model);
@end
