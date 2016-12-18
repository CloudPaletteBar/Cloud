//
//  OfficeQuestionnaireCell.m
//  CloudPaletteBar
//
//  Created by test on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "OfficeQuestionnaireCell.h"

@implementation OfficeQuestionnaireCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//查看
- (IBAction)SeeClock:(id)sender {
    if (self.CellSeeClock) {
        self.CellSeeClock();
    }
}
//编辑
- (IBAction)editClock:(id)sender {
    if (self.CellEditClock) {
        self.CellEditClock();
    }
}
//删除
- (IBAction)deleteClock:(id)sender {
    if (self.CellDeleteClock) {
        self.CellDeleteClock();
    }
}
//楼栋
- (IBAction)BanClock:(id)sender {
    if (self.CellBanClock) {
        self.CellBanClock();
    }
}
//房屋
- (IBAction)houseClock:(id)sender {
    if (self.CellHouseClock) {
        self.CellHouseClock();
    }
}

@end
