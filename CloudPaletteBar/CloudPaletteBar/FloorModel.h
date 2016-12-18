//
//  FloorModel.h
//  CloudPaletteBar
//
//  Created by mhl on 16/9/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol FloorListModel    @end

@interface FloorModel : JSONModel

@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,FloorListModel>*list;

@end


@interface  FloorListModel :  JSONModel

@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*楼栋名称;
@property(nonatomic,strong)NSString <Optional>*楼层;
@property(nonatomic,strong)NSString <Optional>*商业类型;
@property(nonatomic,strong)NSString <Optional>*商品零售业态;//多个
@property(nonatomic,strong)NSString <Optional>*餐饮零售业态;//多个
@property(nonatomic,strong)NSString <Optional>*服务零售业态;//多个
@property(nonatomic,strong)NSString <Optional>*市场装修情况;
@property(nonatomic,strong)NSString <Optional>*市场经营方式;
@property(nonatomic,strong)NSString <Optional>*市场层高;
@property(nonatomic,strong)NSString <Optional>*市场空置率;
@property(nonatomic,strong)NSString <Optional>*商场主营品种;//多个
@property(nonatomic,strong)NSString <Optional>*商场代表品牌;
@property(nonatomic,strong)NSString <Optional>*商场经营方式;
@property(nonatomic,strong)NSString <Optional>*商场装修情况;
@property(nonatomic,strong)NSString <Optional>*商场空置率;
@property(nonatomic,strong)NSString <Optional>*商场层高;
@property(nonatomic,strong)NSString <Optional>*商场整层面积;
@property(nonatomic,strong)NSString <Optional>*商品零售比例;
@property(nonatomic,strong)NSString <Optional>*餐饮零售比例;
@property(nonatomic,strong)NSString <Optional>*服务零售比例;
@property(nonatomic,strong)NSString <Optional>*酒店装修情况;
@property(nonatomic,strong)NSString <Optional>*酒店整层面积;
@property(nonatomic,strong)NSString <Optional>*酒店层高;
@property(nonatomic,strong)NSString <Optional>*大型超市整层面积;
@property(nonatomic,strong)NSString <Optional>*大型超市装修情况;
@property(nonatomic,strong)NSString <Optional>*大型超市经营方式;
@property(nonatomic,strong)NSString <Optional>*大型超市层高;
@property(nonatomic,strong)NSString <Optional>*大型超市空置率;
@property(nonatomic,strong)NSString <Optional>*楼层平面图;

@end

@interface FloorListTypeModel : JSONModel

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



