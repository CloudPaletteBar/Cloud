//
//  CarNumberModel.h
//  DriverSide
//
//  Created by test on 16/7/25.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol CarNumberResultRelateVehicleListModel @end
@interface CarNumberResultRelateVehicleListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*PlateNo;
@property(nonatomic,strong)NSString <Optional>*VehicleID;
@end

@interface CarNumberResultModel : JSONModel
@property(nonatomic,strong)NSArray <Optional,CarNumberResultRelateVehicleListModel>*RelateVehicleList;
@end


@interface CarNumberModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*message;
@property(assign)int code;
@property(nonatomic,strong)CarNumberResultModel <Optional>*result;

@end
