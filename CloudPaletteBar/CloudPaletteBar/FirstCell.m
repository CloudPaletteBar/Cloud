//
//  FirstCell.m
//  CloudPaletteBar
//
//  Created by test on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "FirstCell.h"

@implementation FirstCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)heatClock:(id)sender {
    if (self.HeatClock) {
        UIButton *button=(UIButton *)sender;
        self.HeatClock(button.tag);
    }
}


-(void)laodData:(BusinessModelListModel *)dict andMakeType:(NSString *)makeType
{
    if ([makeType isEqualToString:@"tradeLoupan"]) {
        self.numberLabel.text=dict.ID;
        self.titleLabel.text=dict.实际楼盘名称;
        self.nameLabel.text=dict.调查人;
    }else if ([makeType isEqualToString:@"tradeBuding"]){
        self.numberLabel.text=dict.楼栋编号;
        self.titleLabel.text=dict.实际名称;
        self.nameLabel.text=dict.调查人;
    }else if ([makeType isEqualToString:@"tradeLouceng"]){
        self.numberLabel.text=dict.楼栋名称;
        self.titleLabel.text=dict.楼层;
        self.nameLabel.text=dict.调查人;
    }else{
        self.numberLabel.text=dict.楼栋名称;
        self.titleLabel.text=dict.现场商铺号;
        self.nameLabel.text=dict.调查人;
    }
}

-(void)laodData2:(IndustryQuestionnaireListModel *)dict andMakeType:(NSString *)makeType
{
    if ([makeType isEqualToString:@"industryZongdi"]) {
        self.numberLabel.text=dict.宗地编号;
        self.titleLabel.text=dict.街道办;
        self.nameLabel.text=dict.调查人;
    }else if ([makeType isEqualToString:@"industryGongyeyuan"]){
        self.numberLabel.text=dict.宗地号;
        self.titleLabel.text=dict.园区名称;
        self.nameLabel.text=dict.调查人;
    }else if ([makeType isEqualToString:@"industryLoupan"]){
        self.titleLabel.text=dict.楼层;
        self.nameLabel.text=dict.调查人;
    }else if ([makeType isEqualToString:@"industryBuding"]){
        self.titleLabel.text=dict.楼层;
        self.nameLabel.text=dict.调查人;
    }else if ([makeType isEqualToString:@"industryBuding"]){
        self.titleLabel.text=dict.楼层;
        self.nameLabel.text=dict.调查人;
    }else{
        self.titleLabel.text=dict.楼层;
        self.nameLabel.text=dict.调查人;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
