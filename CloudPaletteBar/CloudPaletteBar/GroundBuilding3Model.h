//
//  GroundBuilding3Model.h
//  CloudPaletteBar
//
//  Created by mhl on 16/9/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol GroundBuilding3ListModel  @end

@interface GroundBuilding3Model : JSONModel
@property (strong, nonatomic)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,GroundBuilding3ListModel>*list;
@end


@interface GroundBuilding3ListModel : JSONModel

@property (strong, nonatomic)NSString <Optional>*工业园ID;
@property (strong, nonatomic)NSString <Optional>*楼栋编号;
@property (strong, nonatomic)NSString <Optional>*楼栋名称;
@property (strong, nonatomic)NSString <Optional>*楼层;
@property (strong, nonatomic)NSString <Optional>*工业楼盘ID;
@property (strong, nonatomic)NSString <Optional>*是否首层;
@property (strong, nonatomic)NSString <Optional>*租金;
@property (strong, nonatomic)NSString <Optional>*数据来源;
@property (strong, nonatomic)NSString <Optional>*层高;
@property (strong, nonatomic)NSString <Optional>*ID;
@property (strong, nonatomic)NSString <Optional>*备注;

@end