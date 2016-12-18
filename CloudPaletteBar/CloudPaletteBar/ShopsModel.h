//
//  ShopsModel.h
//  CloudPaletteBar
//
//  Created by mhl on 16/9/14.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ShopsListModel   @end

@interface ShopsModel : JSONModel

@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,ShopsListModel>*list;


@end


@interface  ShopsListModel :  JSONModel

@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*楼栋名称;
@property(nonatomic,strong)NSString <Optional>*楼层;
@property(nonatomic,strong)NSString <Optional>*系统商铺号;
@property(nonatomic,strong)NSString <Optional>*现场商铺号;
@property(nonatomic,strong)NSString <Optional>*物业管理费;
@property(nonatomic,strong)NSString <Optional>*租金;
@property(nonatomic,strong)NSString <Optional>*商品零售业态;
@property(nonatomic,strong)NSString <Optional>*餐饮零售业态;
@property(nonatomic,strong)NSString <Optional>*服务零售业态;
@property(nonatomic,strong)NSString <Optional>*经营状况;
@property(nonatomic,strong)NSString <Optional>*商铺进深;
@property(nonatomic,strong)NSString <Optional>*使用面积;
@property(nonatomic,strong)NSString <Optional>*商铺开面数;
@property(nonatomic,strong)NSString <Optional>*商铺开面宽;
@property(nonatomic,strong)NSString <Optional>*商铺类型;
@property(nonatomic,strong)NSString <Optional>*临街类型;
@property(nonatomic,strong)NSString <Optional>*临街名称;
@property(nonatomic,strong)NSString <Optional>*内铺类型;
@property(nonatomic,strong)NSString <Optional>*内铺位置;
@property(nonatomic,strong)NSString <Optional>*内铺临内街;
@property(nonatomic,strong)NSString <Optional>*社区商铺;
@property(nonatomic,strong)NSString <Optional>*地下商铺临内街;
@property(nonatomic,strong)NSString <Optional>*地下交通商铺;

@end