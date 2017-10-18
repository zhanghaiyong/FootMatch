//
//  TeamTyoeModel.m
//  Match
//
//  Created by zhy on 2017/10/18.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "TeamTyoeModel.h"
#import "TeamModel.h"
@implementation TeamTyoeModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"teams":@"TeamModel"};
}
@end
