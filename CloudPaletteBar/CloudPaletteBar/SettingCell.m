//
//  SettingCell.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import "SettingCell.h"
#import "CloudPaletteBar.h"

@implementation SettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)_initCell:(NSDictionary *)dic{
    ;
    self.cellImageView.image=OdeSetImageName([[dic allKeys]objectAtIndex:0]);
    self.cellLable.text=[[dic allValues]objectAtIndex:0];
}

@end
