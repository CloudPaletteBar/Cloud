//
//  GongyeZongdiModel.h
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/9/21.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol GongyeZongdiListModel @end

@interface GongyeZongdiModel : JSONModel
@property(nonatomic,strong)NSArray <Optional,GongyeZongdiListModel>*list;
@property(nonatomic,strong)NSString <Optional>*status;
@end


@interface GongyeZongdiListModel : JSONModel

@property(nonatomic,strong)NSString <Optional>*宗地编号;
@property(nonatomic,strong)NSString <Optional>*行政区;
@property(nonatomic,strong)NSString <Optional>*园区名称;
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*宗地号;
@property(nonatomic,strong)NSString <Optional>*系统楼盘名称;
@property(nonatomic,strong)NSString <Optional>*系统楼盘编号;
@property(nonatomic,strong)NSString <Optional>*实际楼栋名称;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*楼栋名称;
@property(nonatomic,strong)NSString <Optional>*系统楼栋名称;
@property(nonatomic,strong)NSString <Optional>*楼层;
@property(nonatomic,strong)NSString <Optional>*系统楼层;
@property(nonatomic,strong)NSString <Optional>*房号;
@property(nonatomic,strong)NSString <Optional>*实际楼盘名称;
@property(nonatomic,strong)NSString <Optional>*街道办;
@property(nonatomic,strong)NSString <Optional>*组别名称;
@property(nonatomic,strong)NSString <Optional>*BLDG_NAME_NO;
@property(nonatomic,strong)NSString <Optional>*标准分区;
@property(nonatomic,strong)NSString <Optional>*BLDG_FLOORS;
@property(nonatomic,strong)NSString <Optional>*CONST_ENDDATE;
@property(nonatomic,strong)NSString <Optional>*是否独栋;//0就不是 1就是

@end
