//
//  IndustryQuestionnaireModel.h
//  CloudPaletteBar
//
//  Created by mhl on 16/9/1.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol IndustryQuestionnaireListModel @end

@interface IndustryQuestionnaireModel : JSONModel

@property(nonatomic,strong)NSString <Optional>*count;
@property(nonatomic,strong)NSString <Optional>*pageNo;
@property(nonatomic,strong)NSString <Optional>*pageSize;

@property(nonatomic,strong)NSArray <Optional,IndustryQuestionnaireListModel>*list;

@end


@interface IndustryQuestionnaireListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*街道办;
@property(nonatomic,strong)NSString <Optional>*宗地编号;
@property(nonatomic,strong)NSString <Optional>*调查人;
@property(nonatomic,strong)NSString <Optional>*宗地号;
@property(nonatomic,strong)NSString <Optional>*园区名称;
@property(nonatomic,strong)NSString <Optional>*实际楼盘名称;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*实际楼栋名称;
@property(nonatomic,strong)NSString <Optional>*楼层;
@property(nonatomic,strong)NSString <Optional>*楼盘ID;
@property(nonatomic,strong)NSString <Optional>*楼栋名称;
@property(nonatomic,strong)NSString <Optional>*实际房号;


@end

