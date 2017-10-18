//
//  TeamModel.m
//  Match
//
//  Created by zhy on 2017/10/18.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "TeamModel.h"

@implementation TeamModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.name forKey:@"name"];
    
    [aCoder encodeObject:self.logo forKey:@"logo"];
    
    [aCoder encodeObject:self.follow forKey:@"follow"];
    
    [aCoder encodeObject:self.type forKey:@"type"];
    
    [aCoder encodeObject:self.tid forKey:@"tid"];
    
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    
    if (self) {
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        
        self.logo = [aDecoder decodeObjectForKey:@"logo"];
        
        self.follow = [aDecoder decodeObjectForKey:@"follow"];
        
        self.type = [aDecoder decodeObjectForKey:@"type"];
        
        self.tid = [aDecoder decodeObjectForKey:@"tid"];
        
    }
    
    return self;
    
}


@end
