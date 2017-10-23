//
//  FastNewsCell.m
//  Match
//
//  Created by zhy on 2017/10/23.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "FastNewsCell.h"

@implementation FastNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)foldAction:(UIButton *)sender {
    
    if (sender.selected) {
        
        self.foldBtn.selected = NO;
    }else {
        
        self.foldBtn.selected = YES;
    }
    if (_FoldBlock) {
        _FoldBlock(self.foldBtn.selected);
    }

}

@end
