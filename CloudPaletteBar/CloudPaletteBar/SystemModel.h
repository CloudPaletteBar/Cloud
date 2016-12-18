//
//  SystemModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/7.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SystemListModel @end
@interface SystemListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*地区;
@property(nonatomic,strong)NSString <Optional>*MY_ROWNUM;
@property(nonatomic,strong)NSString <Optional>*实际房产类型;
@property(nonatomic,strong)NSString <Optional>*系统楼盘名称;
@property(nonatomic,strong)NSString <Optional>*系统楼盘编号;
@property(nonatomic,strong)NSString <Optional>*宗地编号;
@property(nonatomic,strong)NSString <Optional>*实际楼栋名称;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*楼栋编码;
@property(nonatomic,strong)NSString <Optional>*房号;
@property(nonatomic,strong)NSString <Optional>*楼栋名称;
@property(nonatomic,strong)NSString <Optional>*楼层;
@property(nonatomic,strong)NSString <Optional>*系统楼栋名称;
@property(nonatomic,strong)NSString <Optional>*系统房屋用途;
@property(nonatomic,strong)NSString <Optional>*系统房屋面积;
@property(nonatomic,strong)NSString <Optional>*系统楼层;
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*实际楼盘名称;
@property(nonatomic,strong)NSString <Optional>*CONST_ENDDATE;
@end


@interface SystemModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,SystemListModel>*list;
@end
