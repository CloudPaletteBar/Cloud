//
//  CommerciaEstateModel.h
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/9/20.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol CommerciaEstateListModel  @end

@interface CommerciaEstateModel : JSONModel

@property(nonatomic,strong)NSArray <Optional,CommerciaEstateListModel>*list;
@property(nonatomic,strong)NSString <Optional>*status;

@end



@interface CommerciaEstateListModel : JSONModel

@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*楼盘名称;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*系统楼栋名称;
@property(nonatomic,strong)NSString <Optional>*实际名称;
@property(nonatomic,strong)NSString <Optional>*系统楼盘名称;
@property(nonatomic,strong)NSString <Optional>*实际楼盘名称;
@property(nonatomic,strong)NSString <Optional>*楼层;
@property(nonatomic,strong)NSString <Optional>*楼栋名称;
@property(nonatomic,strong)NSString <Optional>*房号;

@end