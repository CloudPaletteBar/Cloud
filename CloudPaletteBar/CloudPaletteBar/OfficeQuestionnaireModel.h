//
//  OfficeQuestionnaireModel.h
//  CloudPaletteBar
//
//  Created by test on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol  OfficeQuestionnaireListModel @end
@interface OfficeQuestionnaireListModel : JSONModel

@property(nonatomic,strong)NSString <Optional>*实际楼栋名称;
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*实际楼盘名称;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*实际房号;
@property(nonatomic,strong)NSString <Optional>*调查人;
@property(nonatomic,strong)NSString <Optional>*楼栋名称;
@property(nonatomic,strong)NSString <Optional>*现用房号;

@property(nonatomic,strong)NSString <Optional>*TYPE;
@property(nonatomic,strong)NSString <Optional>*TASKTYPE;

@end

@interface OfficeQuestionnaireModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*state;
@property(nonatomic,strong)NSString <Optional>*count;

@property(nonatomic,strong)NSArray <Optional,OfficeQuestionnaireListModel>*list;
@end
