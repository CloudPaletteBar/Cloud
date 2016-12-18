//
//  GroundBuilding1Model.h
//  CloudPaletteBar
//
//  Created by mhl on 16/9/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol GroundBuilding1ListModel  @end


@interface GroundBuilding1Model : JSONModel
@property (strong, nonatomic)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,GroundBuilding1ListModel>*list;
@end


@interface GroundBuilding1ListModel : JSONModel

@property (strong, nonatomic)NSString <Optional>*工业园ID;
@property (strong, nonatomic)NSString <Optional>*工业园名称;
@property (strong, nonatomic)NSString <Optional>*系统楼盘编号;
@property (strong, nonatomic)NSString <Optional>*系统楼盘名称;
@property (strong, nonatomic)NSString <Optional>*实际楼盘名称;
@property (strong, nonatomic)NSString <Optional>*楼盘别名;
@property (strong, nonatomic)NSString <Optional>*地理位置1;
@property (strong, nonatomic)NSString <Optional>*地理位置2;
@property (strong, nonatomic)NSString <Optional>*总楼栋数;
@property (strong, nonatomic)NSString <Optional>*开发商;
@property (strong, nonatomic)NSString <Optional>*备注;
@property (strong, nonatomic)NSString <Optional>*任务ID;
@property (strong, nonatomic)NSString <Optional>*宗地号;
@property (strong, nonatomic)NSString <Optional>*临街名称;
@property (strong, nonatomic)NSString <Optional>*ID;

@end
