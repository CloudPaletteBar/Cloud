//
//  LowEstateModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/9.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

//商业配套
@interface LowEstateBusinessModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*大型商场;
@property(nonatomic,strong)NSString <Optional>*知名超市;
@property(nonatomic,strong)NSString <Optional>*商业街;
@property(nonatomic,strong)NSString <Optional>*高级会所;
@property(nonatomic,strong)NSString <Optional>*很少商业配套;
@end

//景观设施
@interface LowEstateLandscapeModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*带大面积中心花园;
@property(nonatomic,strong)NSString <Optional>*带大面积中心广场;
@property(nonatomic,strong)NSString <Optional>*带大面积中心湖泊;
@property(nonatomic,strong)NSString <Optional>*大面积其他水体如溪流瀑布;
@property(nonatomic,strong)NSString <Optional>*成规模种树;
@property(nonatomic,strong)NSString <Optional>*大面积草坪;
@property(nonatomic,strong)NSString <Optional>*大面积园;
@end

//运动设施
@interface LowEstateMovementModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*网球场;
@property(nonatomic,strong)NSString <Optional>*高尔夫球场;
@property(nonatomic,strong)NSString <Optional>*篮球场;
@property(nonatomic,strong)NSString <Optional>*室内泳池;
@property(nonatomic,strong)NSString <Optional>*室外泳池;
@property(nonatomic,strong)NSString <Optional>*健身会所;
@property(nonatomic,strong)NSString <Optional>*登山私;

@end

//照片
@interface LowEstateStandardPhModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*zhaopian1;
@property(nonatomic,strong)NSString <Optional>*zhaopian2;
@property(nonatomic,strong)NSString <Optional>*zhaopian3;
@property(nonatomic,strong)NSString <Optional>*zhaopian4;
@property(nonatomic,strong)NSString <Optional>*zhaopian5;
@end

@protocol LowEstateListModel @end
@interface LowEstateListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*运动设施;
@property(nonatomic,strong)NSString <Optional>*楼盘特色;
@property(nonatomic,strong)NSString <Optional>*运动设施其它;
@property(nonatomic,strong)NSString <Optional>*公园名称;
@property(nonatomic,strong)NSString <Optional>*景观设施;
@property(nonatomic,strong)NSString <Optional>*详细地址1;
@property(nonatomic,strong)NSString <Optional>*楼盘别名;
@property(nonatomic,strong)NSString <Optional>*竣工年代;
@property(nonatomic,strong)NSString <Optional>*幼儿园;
@property(nonatomic,strong)NSString <Optional>*海滨名称;
@property(nonatomic,strong)NSString <Optional>*河流湖泊名称;
@property(nonatomic,strong)NSString <Optional>*山景名称;
@property(nonatomic,strong)NSString <Optional>*园林别墅;
@property(nonatomic,strong)NSString <Optional>*STATE;
@property(nonatomic,strong)NSString <Optional>*开发商;
@property(nonatomic,strong)NSString <Optional>*立面材质其它;
@property(nonatomic,strong)NSString <Optional>*楼盘效果图;
@property(nonatomic,strong)NSString <Optional>*调查人;
@property(nonatomic,strong)NSString <Optional>*小学学位;
@property(nonatomic,strong)NSString <Optional>*详细地址2;
@property(nonatomic,strong)NSString <Optional>*物管费备注;
@property(nonatomic,strong)NSString <Optional>*城市核心区别墅;
@property(nonatomic,strong)NSString <Optional>*不利因素;
@property(nonatomic,strong)NSString <Optional>*审核时间;
@property(nonatomic,strong)NSString <Optional>*物管公司;
@property(nonatomic,strong)NSString <Optional>*高尔夫别墅;
@property(nonatomic,strong)NSString <Optional>*审核人;
@property(nonatomic,strong)NSString <Optional>*高尔夫名称;
@property(nonatomic,strong)NSString <Optional>*系统楼盘编号;
@property(nonatomic,strong)NSString <Optional>*配套设施图;
@property(nonatomic,strong)NSString <Optional>*河流湖泊别墅;
@property(nonatomic,strong)NSString <Optional>*容积率;
@property(nonatomic,strong)NSString <Optional>*建筑风格;
@property(nonatomic,strong)NSString <Optional>*海滨别墅;
@property(nonatomic,strong)NSString <Optional>*公园别墅;
@property(nonatomic,strong)NSString <Optional>*物业管理费;
@property(nonatomic,strong)NSString <Optional>*其它特色配套;
@property(nonatomic,strong)NSString <Optional>*露天车位;
@property(nonatomic,strong)NSString <Optional>*绿地率;
@property(nonatomic,strong)NSString <Optional>*室内车位;
@property(nonatomic,strong)NSString <Optional>*建筑风格其它;
@property(nonatomic,strong)NSString <Optional>*楼盘类型;
@property(nonatomic,strong)NSString <Optional>*中学学位;
@property(nonatomic,strong)NSString <Optional>*城市核心区名称;
@property(nonatomic,strong)NSString <Optional>*内外部景观图;
@property(nonatomic,strong)NSString <Optional>*立面材质;
@property(nonatomic,strong)NSString <Optional>*商业配套;
@property(nonatomic,strong)NSString <Optional>*其它资源;
@property(nonatomic,strong)NSString <Optional>*托儿所;
@property(nonatomic,strong)NSString <Optional>*调查时间;
@property(nonatomic,strong)NSString <Optional>*任务ID;
@property(nonatomic,strong)NSString <Optional>*实际楼盘名称;
@property(nonatomic,strong)NSString <Optional>*建筑密度;
@property(nonatomic,strong)NSString <Optional>*楼盘平面图;
@property(nonatomic,strong)NSString <Optional>*公共车位;
@property(nonatomic,strong)NSString <Optional>*系统楼盘名称;
@property(nonatomic,strong)NSString <Optional>*山景别墅;
@end


@interface LowEstateModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,LowEstateListModel>*list;
@end
