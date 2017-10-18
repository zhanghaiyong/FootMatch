//
//  TeamModel.h
//  Match
//
//  Created by zhy on 2017/10/18.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamModel : NSObject<NSCoding>
@property (nonatomic,strong)NSString *name;

@property (nonatomic,assign)BOOL isSelect;

@property (nonatomic,strong)NSString *logo;


@property (nonatomic,strong)NSString *follow;


@property (nonatomic,strong)NSString *type;


@property (nonatomic,strong)NSString *tid;

@end
