//
//  OfficeHouseModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/8.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol OfficeHouseListModel @end
@interface OfficeHouseListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*任务ID;
@property(nonatomic,strong)NSString <Optional>*当前使用情况其它;
@property(nonatomic,strong)NSString <Optional>*调查时间;
@property(nonatomic,strong)NSString <Optional>*审核人;
@property(nonatomic,strong)NSString <Optional>*租户性质;
@property(nonatomic,strong)NSString <Optional>*楼栋名称;
@property(nonatomic,strong)NSString <Optional>*系统房屋用途;
@property(nonatomic,strong)NSString <Optional>*售价;
@property(nonatomic,strong)NSString <Optional>*采光面;
@property(nonatomic,strong)NSString <Optional>*售价信息来源;
@property(nonatomic,strong)NSString <Optional>*楼盘ID;
@property(nonatomic,strong)NSString <Optional>*当前租户;
@property(nonatomic,strong)NSString <Optional>*楼盘名称;
@property(nonatomic,strong)NSString <Optional>*已拆分;
@property(nonatomic,strong)NSString <Optional>*是否临近电梯口;
@property(nonatomic,strong)NSString <Optional>*租约信息来源;
@property(nonatomic,strong)NSString <Optional>*出入口门牌号照片;
@property(nonatomic,strong)NSString <Optional>*基本信息备注;
@property(nonatomic,strong)NSString <Optional>*采光评价;
@property(nonatomic,strong)NSString <Optional>*特殊景观;
@property(nonatomic,strong)NSString <Optional>*系统房号;
@property(nonatomic,strong)NSString <Optional>*景观名称;
@property(nonatomic,strong)NSString <Optional>*租户行业类别;
@property(nonatomic,strong)NSString <Optional>*实用面积;
@property(nonatomic,strong)NSString <Optional>*租金;
@property(nonatomic,strong)NSString <Optional>*系统楼层;
@property(nonatomic,strong)NSString <Optional>*租约信息来源其它;
@property(nonatomic,strong)NSString <Optional>*STATE;
@property(nonatomic,strong)NSString <Optional>*房屋照片;
@property(nonatomic,strong)NSString <Optional>*已合并;
@property(nonatomic,strong)NSString <Optional>*包含物业管理费;
@property(nonatomic,strong)NSString <Optional>*售价信息来源其它;
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*装修情况;
@property(nonatomic,strong)NSString <Optional>*审核时间;
@property(nonatomic,strong)NSString <Optional>*系统对应情况;
@property(nonatomic,strong)NSString <Optional>*朝向;
@property(nonatomic,strong)NSString <Optional>*当前使用情况;
@property(nonatomic,strong)NSString <Optional>*实际房号;
@property(nonatomic,strong)NSString <Optional>*租户行业类别其它;
@property(nonatomic,strong)NSString <Optional>*租户性质其它;
@property(nonatomic,strong)NSString <Optional>*租约;
@property(nonatomic,strong)NSString <Optional>*租售情况备注;
@property(nonatomic,strong)NSString <Optional>*赠送面积;
@property(nonatomic,strong)NSString <Optional>*所在楼层;
@property(nonatomic,strong)NSString <Optional>*系统建筑面积;
@property(nonatomic,strong)NSString <Optional>*调查人;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;

@end

//朝向
@interface OfficeHouseOrientationModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*南;
@property(nonatomic,strong)NSString <Optional>*东;
@property(nonatomic,strong)NSString <Optional>*西;
@property(nonatomic,strong)NSString <Optional>*北;
@property(nonatomic,strong)NSString <Optional>*东南;
@property(nonatomic,strong)NSString <Optional>*东北;
@property(nonatomic,strong)NSString <Optional>*西南;
@property(nonatomic,strong)NSString <Optional>*西北;

@end


@interface OfficeHousePhModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*zhaopian1;
@property(nonatomic,strong)NSString <Optional>*zhaopian2;
@property(nonatomic,strong)NSString <Optional>*zhaopian3;
@property(nonatomic,strong)NSString <Optional>*zhaopian4;
@property(nonatomic,strong)NSString <Optional>*zhaopian5;
@end

@interface OfficeHouseModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,OfficeHouseListModel>*list;
@end
