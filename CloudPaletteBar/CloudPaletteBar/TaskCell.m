//
//  TaskCell.m
//  CloudPaletteBar
//
//  Created by test on 16/8/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import "TaskCell.h"
#import "NetworkManager.h"

@implementation TaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)cell_init:(UpcomingTasksListModel *)upcomingTasksListModel{
    self.cellNumberLable.text=upcomingTasksListModel.MY_ROWNUM;
    self.cellTitleLable.text=upcomingTasksListModel.任务名称;
    NSString *str=[NetworkManager interceptStrTo:upcomingTasksListModel.结束时间 PleStr:@" "];
    NSLog(@"%@",upcomingTasksListModel.任务完成百分比);
    self.cellTimeLable.text=[NSString stringWithFormat:@"完成时间 %@",str];
    self.completeLable.text=[NSString stringWithFormat:@"已完成%.f%%",[upcomingTasksListModel.任务完成百分比 floatValue]];
    
//    设置圆角
    self.cellNumberLable.layer.masksToBounds = YES;
    self.cellNumberLable.layer.cornerRadius = 5.0;
}

@end
