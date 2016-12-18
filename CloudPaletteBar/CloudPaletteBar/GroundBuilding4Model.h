//
//  GroundBuilding4Model.h
//  CloudPaletteBar
//
//  Created by mhl on 16/9/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol GroundBuilding4ListModel  @end

@interface GroundBuilding4Model : JSONModel
@property (strong, nonatomic)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,GroundBuilding4ListModel>*list;
@end


@interface GroundBuilding4ListModel : JSONModel

@property (strong, nonatomic)NSString <Optional>*楼栋编号;
@property (strong, nonatomic)NSString <Optional>*楼栋名称;
@property (strong, nonatomic)NSString <Optional>*楼层;
@property (strong, nonatomic)NSString <Optional>*系统楼层;
@property (strong, nonatomic)NSString <Optional>*系统房号;
@property (strong, nonatomic)NSString <Optional>*实际房号;
@property (strong, nonatomic)NSString <Optional>*备注;
@property (strong, nonatomic)NSString <Optional>*系统建筑面积;
@property (strong, nonatomic)NSString <Optional>*系统房屋用途;
@property (strong, nonatomic)NSString <Optional>*系统对应情况;
@property (strong, nonatomic)NSString <Optional>*所在楼层;
@property (strong, nonatomic)NSString <Optional>*使用现状;
@property (strong, nonatomic)NSString <Optional>*空间布局;
@property (strong, nonatomic)NSString <Optional>*任务ID;
@property (strong, nonatomic)NSString <Optional>*工业园ID;
@property (strong, nonatomic)NSString <Optional>*ID;
@property (strong, nonatomic)NSString <Optional>*工业楼盘ID;

@end
