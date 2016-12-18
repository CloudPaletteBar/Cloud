//
//  ShopsViewTableViewCell.m
//  CloudPaletteBar
//
//  Created by mhl on 16/9/22.
//  Copyright © 2016年 test. All rights reserved.
//

#import "ShopsViewTableViewCell.h"


@implementation ShopsViewTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(IBAction)select:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (_SelectViewButton) {
        _SelectViewButton(_idLabel.text, _titleLabel.text);
    }
}

-(void)laodData:(CommerciaEstateListModel *)dict
{
    _idLabel.text = dict.ID;
    _titleLabel.text = [NSString stringWithFormat:@"%@ %@层",dict.楼栋名称, dict.楼层];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
