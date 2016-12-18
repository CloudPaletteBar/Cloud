//
//  MyReviewCell.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/16.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OfficeQuestionnaireModel.h"
#import "HistoricalRecordModel.h"

@interface MyReviewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellNumberLable;

@property (weak, nonatomic) IBOutlet UILabel *cellNameLable;

@property (weak, nonatomic) IBOutlet UILabel *cellTypeLable;
-(void)_initCell:(OfficeQuestionnaireListModel *)officeQuestionnaireListModel;
-(void)Cell1:(HistoricalRecordListModel *)historicalRecordListModel KeyDic:(NSDictionary *)keyDie CellIndex:(NSInteger)cellIndex;
@end
