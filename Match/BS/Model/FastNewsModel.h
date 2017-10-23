//
//  FastNewsModel.h
//  Match
//
//  Created by zhy on 2017/10/23.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FastNewsModel : NSObject<MJKeyValue>
@property (nonatomic,strong)NSString *image;


@property (nonatomic,strong)NSString *newsId ;


@property (nonatomic,strong)NSString *pubTime;


@property (nonatomic,strong)NSString *desc;


@property (nonatomic,strong)NSString *pid;


@property (nonatomic,strong)NSString *category ;


@property (nonatomic,strong)NSString *type;


@property (nonatomic,strong)NSString *title;


@property (nonatomic,strong)NSString *url;

@property (nonatomic,assign)BOOL fold;

@property (nonatomic,assign)CGFloat cellH;

@end
