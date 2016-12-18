//
//  LowHouseModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/9.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>
//朝向
@interface LowHouseOrientationModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*南;
@property(nonatomic,strong)NSString <Optional>*东;
@property(nonatomic,strong)NSString <Optional>*西;
@property(nonatomic,strong)NSString <Optional>*北;
@property(nonatomic,strong)NSString <Optional>*东南;
@property(nonatomic,strong)NSString <Optional>*东北;
@property(nonatomic,strong)NSString <Optional>*西南;
@property(nonatomic,strong)NSString <Optional>*西北;
@end

//户型结构
@interface LowHouseStructureModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*房;
@property(nonatomic,strong)NSString <Optional>*厅;
@property(nonatomic,strong)NSString <Optional>*厨卫;
@property(nonatomic,strong)NSString <Optional>*阳台;
@property(nonatomic,strong)NSString <Optional>*花园;
@end

//照片
@interface LowHouseStandardPhModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*zhaopian1;
@property(nonatomic,strong)NSString <Optional>*zhaopian2;
@property(nonatomic,strong)NSString <Optional>*zhaopian3;
@property(nonatomic,strong)NSString <Optional>*zhaopian4;
@property(nonatomic,strong)NSString <Optional>*zhaopian5;
@end

@protocol LowHouseListModel @end
@interface LowHouseListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*阁楼面积;
@property(nonatomic,strong)NSString <Optional>*电梯个数;
@property(nonatomic,strong)NSString <Optional>*私家泳池个数;
@property(nonatomic,strong)NSString <Optional>*私家花园面积;
@property(nonatomic,strong)NSString <Optional>*已拆分;
@property(nonatomic,strong)NSString <Optional>*实用面积;
@property(nonatomic,strong)NSString <Optional>*户型图;
@property(nonatomic,strong)NSString <Optional>*山景;
@property(nonatomic,strong)NSString <Optional>*备注;
@property(nonatomic,strong)NSString <Optional>*房屋编号;
@property(nonatomic,strong)NSString <Optional>*所在楼层;
@property(nonatomic,strong)NSString <Optional>*STATE;
@property(nonatomic,strong)NSString <Optional>*露台空中花园;
@property(nonatomic,strong)NSString <Optional>*私家车位车库;
@property(nonatomic,strong)NSString <Optional>*调查人;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*挑高阳台;
@property(nonatomic,strong)NSString <Optional>*阁楼;
@property(nonatomic,strong)NSString <Optional>*审核时间;
@property(nonatomic,strong)NSString <Optional>*楼栋名称;
@property(nonatomic,strong)NSString <Optional>*已合并;
@property(nonatomic,strong)NSString <Optional>*审核人;
@property(nonatomic,strong)NSString <Optional>*人文景观;
@property(nonatomic,strong)NSString <Optional>*户型结构;
@property(nonatomic,strong)NSString <Optional>*河流湖泊;
@property(nonatomic,strong)NSString <Optional>*物业管理费;
@property(nonatomic,strong)NSString <Optional>*联排别墅;
@property(nonatomic,strong)NSString <Optional>*总赠送面积;
@property(nonatomic,strong)NSString <Optional>*装修程度;
@property(nonatomic,strong)NSString <Optional>*叠墅洋房;
@property(nonatomic,strong)NSString <Optional>*露台面积;
@property(nonatomic,strong)NSString <Optional>*电梯;
@property(nonatomic,strong)NSString <Optional>*公园;
@property(nonatomic,strong)NSString <Optional>*楼栋外观图;
@property(nonatomic,strong)NSString <Optional>*采光;
@property(nonatomic,strong)NSString <Optional>*中央空调个数;
@property(nonatomic,strong)NSString <Optional>*朝向;
@property(nonatomic,strong)NSString <Optional>*调查时间;
@property(nonatomic,strong)NSString <Optional>*挑高阳台面积;
@property(nonatomic,strong)NSString <Optional>*私家花园庭院;
@property(nonatomic,strong)NSString <Optional>*中央空调;
@property(nonatomic,strong)NSString <Optional>*任务ID;
@property(nonatomic,strong)NSString <Optional>*系统房号;
@property(nonatomic,strong)NSString <Optional>*私家车位个数;
@property(nonatomic,strong)NSString <Optional>*现用房号;
@property(nonatomic,strong)NSString <Optional>*赠送其它;
@property(nonatomic,strong)NSString <Optional>*价格;
@property(nonatomic,strong)NSString <Optional>*通风;
@property(nonatomic,strong)NSString <Optional>*私家泳池;
@property(nonatomic,strong)NSString <Optional>*建筑面积;
@property(nonatomic,strong)NSString <Optional>*海景;
@property(nonatomic,strong)NSString <Optional>*楼盘编号;
@property(nonatomic,strong)NSString <Optional>*景观图;
@property(nonatomic,strong)NSString <Optional>*高尔夫景观;
@end

@interface LowHouseModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,LowHouseListModel>*list;
@end
