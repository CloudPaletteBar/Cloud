//
//  OfficeQuestionnaireView.m
//  CloudPaletteBar
//
//  Created by test on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "OfficeQuestionnaireHeatView.h"

@implementation OfficeQuestionnaireHeatView

- (IBAction)heatClock:(id)sender {
    if (self.HeatClock) {
        UIButton *button=(UIButton *)sender;
        self.HeatClock(button.tag);
    }
}

-(void)_initHeat:(OfficeQuestionnaireListModel *)officeQuestionnaireListModel Index:(NSInteger)index andMakeType:(NSString *)makeType{

    self.officeButton.tag=index;
    
    if ([makeType isEqualToString:@"officeLoupan"]) {
        self.officeNumberLable.text=officeQuestionnaireListModel.ID;
        self.officeNameLable.text=officeQuestionnaireListModel.实际楼盘名称;
        self.officePeopleLable.text=officeQuestionnaireListModel.调查人;
    }else if ([makeType isEqualToString:@"officeBuding"]){
        self.officeNumberLable.text=officeQuestionnaireListModel.楼栋编号;
        self.officeNameLable.text=officeQuestionnaireListModel.实际楼栋名称;
        self.officePeopleLable.text=officeQuestionnaireListModel.调查人;
    }else{
        self.officeNumberLable.text=officeQuestionnaireListModel.楼栋名称;
        self.officeNameLable.text=officeQuestionnaireListModel.实际房号;
        self.officePeopleLable.text=officeQuestionnaireListModel.调查人;
    }
}

-(void)_initHeat2:(OfficeQuestionnaireListModel *)officeQuestionnaireListModel Index:(NSInteger)index andMakeType:(NSString *)makeType{
    self.officeButton.tag=index;

    if ([makeType isEqualToString:@"houseXiaoqu"]) {
        self.officeNumberLable.text=officeQuestionnaireListModel.ID;
        self.officeNameLable.text=officeQuestionnaireListModel.实际楼盘名称;
        self.officePeopleLable.text=officeQuestionnaireListModel.调查人;
    }else if ([makeType isEqualToString:@"houseBuding"]){
        self.officeNumberLable.text=officeQuestionnaireListModel.楼栋编号;
        self.officeNameLable.text=officeQuestionnaireListModel.实际楼栋名称;
        self.officePeopleLable.text=officeQuestionnaireListModel.调查人;
    }else{
        self.officeNumberLable.text=officeQuestionnaireListModel.楼栋名称;
        self.officeNameLable.text=officeQuestionnaireListModel.现用房号;
        self.officePeopleLable.text=officeQuestionnaireListModel.调查人;
    }
}
//@[@"houseDLoupan",@"houseDBuding",@"houseDFangwu"];
-(void)_initHeat3:(OfficeQuestionnaireListModel *)officeQuestionnaireListModel Index:(NSInteger)index andMakeType:(NSString *)makeType{
    self.officeButton.tag=index;
    
    if ([makeType isEqualToString:@"houseDLoupan"]) {
        self.officeNumberLable.text=officeQuestionnaireListModel.ID;
        self.officeNameLable.text=officeQuestionnaireListModel.实际楼盘名称;
        self.officePeopleLable.text=officeQuestionnaireListModel.调查人;
    }else if ([makeType isEqualToString:@"houseDBuding"]){
        self.officeNumberLable.text=officeQuestionnaireListModel.楼栋编号;
        self.officeNameLable.text=officeQuestionnaireListModel.实际楼栋名称;
        self.officePeopleLable.text=officeQuestionnaireListModel.调查人;
    }else{
        self.officeNumberLable.text=officeQuestionnaireListModel.楼栋名称;
        self.officeNameLable.text=officeQuestionnaireListModel.现用房号;
        self.officePeopleLable.text=officeQuestionnaireListModel.调查人;
    }
}

-(void)_initHeat4:(IndustryQuestionnaireListModel *)dict Index:(NSInteger)index andMakeType:(NSString *)makeType{
    self.officeButton.tag=index;
    
    if ([makeType isEqualToString:@"industryZongdi"]) {
        self.officeNumberLable.text=dict.宗地编号;
        self.officeNameLable.text=dict.街道办;
        self.officePeopleLable.text=dict.调查人;
    }else if ([makeType isEqualToString:@"industryGongyeyuan"]){
        self.officeNumberLable.text=dict.宗地号;
        self.officeNameLable.text=dict.园区名称;
        self.officePeopleLable.text=dict.调查人;
    }else if ([makeType isEqualToString:@"industryLoupan"]){
        self.officeNumberLable.text=dict.ID;
        self.officeNameLable.text=dict.实际楼盘名称;
        self.officePeopleLable.text=dict.调查人;
    }else if ([makeType isEqualToString:@"industryBuding"]){
        self.officeNumberLable.text = dict.楼栋编号;
        self.officeNameLable.text=dict.实际楼栋名称;
        self.officePeopleLable.text=dict.调查人;
    }else if ([makeType isEqualToString:@"industryLouceng"]){
        self.officeNumberLable.text =dict.楼层;
        self.officeNameLable.text=dict.楼栋名称;
        self.officePeopleLable.text=dict.调查人;
    }else{
        self.officeNumberLable.text = dict.实际房号;
        self.officeNameLable.text=dict.楼栋名称;
        self.officePeopleLable.text=dict.调查人;
    }
}

-(void)_initHeat5:(BusinessModelListModel *)dict Index:(NSInteger)index andMakeType:(NSString *)makeType{
    self.officeButton.tag=index;
    
    if ([makeType isEqualToString:@"tradeLoupan"]) {
        self.officeNumberLable.text=dict.ID;
        self.officeNameLable.text=dict.实际楼盘名称;
        self.officePeopleLable.text=dict.调查人;
    }else if ([makeType isEqualToString:@"tradeBuding"]){
        self.officeNumberLable.text=dict.楼栋编号;
        self.officeNameLable.text=dict.实际名称;
        self.officePeopleLable.text=dict.调查人;
    }else if ([makeType isEqualToString:@"tradeLouceng"]){
        self.officeNumberLable.text=dict.楼栋名称;
        self.officeNameLable.text=dict.楼层;
        self.officePeopleLable.text=dict.调查人;
    }else{
        self.officeNumberLable.text=dict.楼栋名称;
        self.officeNameLable.text=dict.现场商铺号;
        self.officePeopleLable.text=dict.调查人;
    }
}

@end
