//
//  CaseStudyCell.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import "CaseStudyCell.h"

@implementation CaseStudyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)_initCell:(NSString *)title Index:(NSInteger)index{
    self.cellLable.text=title;
    self.cellNumber.text=[NSString stringWithFormat:@"%ld",(long)index];
    self.cellNumber.layer.masksToBounds = YES;
    self.cellNumber.layer.cornerRadius = self.cellNumber.frame.size.width/2;
}

@end
