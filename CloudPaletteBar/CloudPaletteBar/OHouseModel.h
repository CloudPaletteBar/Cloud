//
//  OHouseModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/10.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>
//户型
@interface OHouseAModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*房;
@property(nonatomic,strong)NSString <Optional>*厅;
@property(nonatomic,strong)NSString <Optional>*厨卫;
@property(nonatomic,strong)NSString <Optional>*阳台;
@property(nonatomic,strong)NSString <Optional>*花园;
@end


//朝向
@interface OHouseOModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*南;
@property(nonatomic,strong)NSString <Optional>*东;
@property(nonatomic,strong)NSString <Optional>*西;
@property(nonatomic,strong)NSString <Optional>*北;
@property(nonatomic,strong)NSString <Optional>*东南;
@property(nonatomic,strong)NSString <Optional>*东北;
@property(nonatomic,strong)NSString <Optional>*西南;
@property(nonatomic,strong)NSString <Optional>*西北;
@end

@protocol OHouseListModel @end
@interface OHouseListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*赠送面积;
@property(nonatomic,strong)NSString <Optional>*STATE;
@property(nonatomic,strong)NSString <Optional>*景观;
@property(nonatomic,strong)NSString <Optional>*采光面;
@property(nonatomic,strong)NSString <Optional>*备注;
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*楼层范围;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*朝向;
@property(nonatomic,strong)NSString <Optional>*楼栋名称;
@property(nonatomic,strong)NSString <Optional>*户型;
@property(nonatomic,strong)NSString <Optional>*赠送空间;
@property(nonatomic,strong)NSString <Optional>*价格水平;
@property(nonatomic,strong)NSString <Optional>*调查人;
@property(nonatomic,strong)NSString <Optional>*现用房号;
@property(nonatomic,strong)NSString <Optional>*噪音;
@property(nonatomic,strong)NSString <Optional>*调查时间;
@property(nonatomic,strong)NSString <Optional>*房屋结构;
@end

@interface OHouseModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,OHouseListModel>*list;
@end
