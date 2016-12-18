//
//  OfficeQuestionnaireView.h
//  CloudPaletteBar
//
//  Created by test on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OfficeQuestionnaireModel.h"
#import "IndustryQuestionnaireModel.h"
#import "BusinessModel.h"

@interface OfficeQuestionnaireHeatView : UIView
@property (weak, nonatomic) IBOutlet UILabel *officeNumberLable;
@property (weak, nonatomic) IBOutlet UILabel *officeNameLable;
@property (weak, nonatomic) IBOutlet UILabel *officePeopleLable;
@property (weak, nonatomic) IBOutlet UIButton *officeButton;
-(void)_initHeat:(OfficeQuestionnaireListModel *)officeQuestionnaireListModel Index:(NSInteger)index andMakeType:(NSString *)makeType;
-(void)_initHeat2:(OfficeQuestionnaireListModel *)officeQuestionnaireListModel Index:(NSInteger)index andMakeType:(NSString *)makeType;
-(void)_initHeat3:(OfficeQuestionnaireListModel *)officeQuestionnaireListModel Index:(NSInteger)index andMakeType:(NSString *)makeType;
-(void)_initHeat4:(IndustryQuestionnaireListModel *)dict Index:(NSInteger)index andMakeType:(NSString *)makeType;
-(void)_initHeat5:(BusinessModelListModel *)dict Index:(NSInteger)index andMakeType:(NSString *)makeType;


@property(nonatomic,copy)void (^ HeatClock)(NSInteger indexCell);

@end
