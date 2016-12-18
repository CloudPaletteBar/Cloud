//
//  TaskDetailsCell.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/2.
//  Copyright © 2016年 test. All rights reserved.
//

#import "TaskDetailsCell.h"
#import "LDProgressView.h"
#import "MacroDefinition.h"

@implementation TaskDetailsCell{
    LDProgressView *progressView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)_init:(NSString *)title Cell:(TaskDetailsListModel *)taskDetailsListModel{
//    self.titleLable.text=title;
    if (taskDetailsListModel) {
//        self.completeLable.text=[NSString stringWithFormat:@"%@%%",taskDetailsListModel.已完成];
//        self.unfinishedLable.text=[NSString stringWithFormat:@"%@%%",taskDetailsListModel.未完成];
        float totalNumber = [taskDetailsListModel.任务条数 floatValue];
        float completed = [taskDetailsListModel.已完成 floatValue];
//        NSLog(@"%f,-----%f-----%f",totalNumber,completed,completed/totalNumber);
        
        if (progressView == nil) {
            progressView = [[LDProgressView alloc] initWithFrame:CGRectMake(80, 11, MainScreenWidth-80-40, 22)];
            progressView.color = [UIColor colorWithRed:0.00f green:0.64f blue:0.00f alpha:1.00f];
            progressView.flat = @YES;
            progressView.showBackgroundInnerShadow = @NO;
            progressView.progress = completed/totalNumber;
            progressView.animate = @YES;
            [self addSubview:progressView];
        }
    }
}

@end
