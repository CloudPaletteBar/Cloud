//
//  Building2Model.h
//  CloudPaletteBar
//
//  Created by mhl on 16/9/7.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol Building2ListModel  @end


@interface Building2Model : JSONModel

@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,Building2ListModel>*list;

@end


@interface  Building2ListModel :  JSONModel

@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*楼盘名称;
@property(nonatomic,strong)NSString <Optional>*商业类型;
@property(nonatomic,strong)NSString <Optional>*裙楼分类;
@property(nonatomic,strong)NSString <Optional>*市场类型;
@property(nonatomic,strong)NSString <Optional>*商场定位;
@property(nonatomic,strong)NSString <Optional>*酒店类型;
@property(nonatomic,strong)NSString <Optional>*酒店级别;
@property(nonatomic,strong)NSString <Optional>*超市品牌;
@property(nonatomic,strong)NSString <Optional>*系统名称;
@property(nonatomic,strong)NSString <Optional>*实际名称;
@property(nonatomic,strong)NSString <Optional>*物业管理公司;
@property(nonatomic,strong)NSString <Optional>*楼栋位置;
@property(nonatomic,strong)NSString <Optional>*地上层数;
@property(nonatomic,strong)NSString <Optional>*地下层数;
@property(nonatomic,strong)NSString <Optional>*商业层数;
@property(nonatomic,strong)NSString <Optional>*临街类型;
@property(nonatomic,strong)NSString <Optional>*所临街道名称;
@property(nonatomic,strong)NSString <Optional>*无法调查说明;
@property(nonatomic,strong)NSString <Optional>*临街道照片;
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*楼盘ID;

@end

@interface Building2ListTypeModel : JSONModel

@property(nonatomic,strong)NSString <Optional>*裙楼商铺;
@property(nonatomic,strong)NSString <Optional>*地下商场;
@property(nonatomic,strong)NSString <Optional>*其它;
@property(nonatomic,strong)NSString <Optional>*专业市场;
@property(nonatomic,strong)NSString <Optional>*综合市场;
@property(nonatomic,strong)NSString <Optional>*购物中心;
@property(nonatomic,strong)NSString <Optional>*百货商场;
@property(nonatomic,strong)NSString <Optional>*宾馆酒店;
@property(nonatomic,strong)NSString <Optional>*大型超市;

@end
