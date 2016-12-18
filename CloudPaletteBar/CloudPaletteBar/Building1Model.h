//
//  Building1Model.h
//  CloudPaletteBar
//
//  Created by mhl on 16/9/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

//@interface Building1ListAddressModel : JSONModel
//@property(nonatomic,strong)NSString <Optional>*s1;
//@property(nonatomic,strong)NSString <Optional>*s2;
//@property(nonatomic,strong)NSString <Optional>*s3;
//@property(nonatomic,strong)NSString <Optional>*价格1;
//@property(nonatomic,strong)NSString <Optional>*价格2;
//
//@end

@protocol Building1ListModel  @end


@interface  Building1ListModel :  JSONModel

@property(nonatomic,strong)NSString <Optional>*查勘人;
@property(nonatomic,strong)NSString <Optional>*调查时间;
@property(nonatomic,strong)NSString <Optional>*系统楼盘编号;
@property(nonatomic,strong)NSString <Optional>*系统楼盘名称;
@property(nonatomic,strong)NSString <Optional>*实际楼盘名称;
@property(nonatomic,strong)NSString <Optional>*楼盘别名;
@property(nonatomic,strong)NSString <Optional>*总楼栋数;
@property(nonatomic,strong)NSString <Optional>*开发商;
@property(nonatomic,strong)NSString <Optional>*物业管理公司;
@property(nonatomic,strong)NSString <Optional>*地理位置1;
@property(nonatomic,strong)NSString <Optional>*地理位置2;
@property(nonatomic,strong)NSString <Optional>*楼盘类型;
@property(nonatomic,strong)NSString <Optional>*区位级别;
@property(nonatomic,strong)NSString <Optional>*价格水平;
@property(nonatomic,strong)NSString <Optional>*交通便捷程度;
@property(nonatomic,strong)NSString <Optional>*停车位;
@property(nonatomic,strong)NSString <Optional>*楼栋位置图;
@property(nonatomic,strong)NSString <Optional>*任务ID;
@property(nonatomic,strong)NSString <Optional>*ID;

@end


@interface Building1Model : JSONModel

@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,Building1ListModel>*list;

@end

