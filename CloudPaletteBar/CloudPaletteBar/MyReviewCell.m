//
//  MyReviewCell.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/16.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MyReviewCell.h"
#import "NetworkManager.h"

@implementation MyReviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)_initCell:(OfficeQuestionnaireListModel *)officeQuestionnaireListModel{
    self.cellNumberLable.text=officeQuestionnaireListModel.楼栋编号;
    self.cellNameLable.text=officeQuestionnaireListModel.实际楼栋名称;
    self.cellTypeLable.text=officeQuestionnaireListModel.TYPE;
}

-(void)Cell1:(HistoricalRecordListModel *)historicalRecordListModel KeyDic:(NSDictionary *)keyDie CellIndex:(NSInteger)cellIndex{
    self.cellNumberLable.text= historicalRecordListModel.ID;
    self.cellNameLable.text=[keyDie objectForKey:historicalRecordListModel.TASKTYPE];
    self.cellTypeLable.text=[NetworkManager interceptStrTo:historicalRecordListModel.调查时间 PleStr:@" "];
}

@end
