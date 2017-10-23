//
//  FastNewsModel.m
//  Match
//
//  Created by zhy on 2017/10/23.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "FastNewsModel.h"

@implementation FastNewsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{@"pid":@"id",@"desc":@"description"};
}

-(CGFloat)cellH {
    
    CGRect frame = [self.desc boundingRectWithSize:CGSizeMake(kDeviceWidth-160, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    return frame.size.height + 30;
    
}
@end
