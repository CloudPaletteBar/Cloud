//
//  BuildingView2TableViewCell.m
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/9/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BuildingView2TableViewCell.h"

@implementation BuildingView2TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(IBAction)select:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (_SelectViewButton) {
        _SelectViewButton(_titleLabel.text);
    }
}


-(void)laodData:(NSString *)str{
    _titleLabel.text = str;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
