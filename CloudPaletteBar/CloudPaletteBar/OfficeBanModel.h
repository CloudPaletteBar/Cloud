//
//  OfficeBanModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

//@interface OfficeBanListPhModel : JSONModel
//@property(nonatomic,strong)NSString <Optional>*zhaopian1;
//@property(nonatomic,strong)NSString <Optional>*zhaopian2;
//@property(nonatomic,strong)NSString <Optional>*zhaopian3;
//@property(nonatomic,strong)NSString <Optional>*zhaopian4;
//@property(nonatomic,strong)NSString <Optional>*zhaopian5;
//@end
//
////外墙照片
//@interface OfficeBanListAbroadPhModel : JSONModel
//@property(nonatomic,strong)NSString <Optional>*zhaopian1;
//@property(nonatomic,strong)NSString <Optional>*zhaopian2;
//@property(nonatomic,strong)NSString <Optional>*zhaopian3;
//@property(nonatomic,strong)NSString <Optional>*zhaopian4;
//@property(nonatomic,strong)NSString <Optional>*zhaopian5;
//@end
//
////标准层平面图
//@interface OfficeBanListPlanePhModel : JSONModel
//@property(nonatomic,strong)NSString <Optional>*zhaopian1;
//@property(nonatomic,strong)NSString <Optional>*zhaopian2;
//@property(nonatomic,strong)NSString <Optional>*zhaopian3;
//@property(nonatomic,strong)NSString <Optional>*zhaopian4;
//@property(nonatomic,strong)NSString <Optional>*zhaopian5;
//@end

//标准层装修照片
@interface OfficeBanListStandardPhModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*zhaopian1;
@property(nonatomic,strong)NSString <Optional>*zhaopian2;
@property(nonatomic,strong)NSString <Optional>*zhaopian3;
@property(nonatomic,strong)NSString <Optional>*zhaopian4;
@property(nonatomic,strong)NSString <Optional>*zhaopian5;
@end
//主要用途
@interface OfficeBanListMainModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*酒店住宿;
@property(nonatomic,strong)NSString <Optional>*住宅;
@property(nonatomic,strong)NSString <Optional>*零售商业;
@property(nonatomic,strong)NSString <Optional>*工业;
@property(nonatomic,strong)NSString <Optional>*其它;
@property(nonatomic,strong)NSString <Optional>*办公;
@end
//内部配套
@interface OfficeBanListInsideModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*会议中心;
@property(nonatomic,strong)NSString <Optional>*银行;
@property(nonatomic,strong)NSString <Optional>*购物中心;
@property(nonatomic,strong)NSString <Optional>*空中花园;
@property(nonatomic,strong)NSString <Optional>*餐饮;
@property(nonatomic,strong)NSString <Optional>*便利店;
@property(nonatomic,strong)NSString <Optional>*酒店宾馆;
@property(nonatomic,strong)NSString <Optional>*商务中心;
@property(nonatomic,strong)NSString <Optional>*健身中心;
@property(nonatomic,strong)NSString <Optional>*其它;
@end

//租售模式
@interface OfficePatternListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*自持自用;
@property(nonatomic,strong)NSString <Optional>*统一出租;
@property(nonatomic,strong)NSString <Optional>*租售混合;
@property(nonatomic,strong)NSString <Optional>*其它;
@end

@protocol OfficeBanListModel @end
@interface OfficeBanListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*空置率;
@property(nonatomic,strong)NSString <Optional>*任务ID;
@property(nonatomic,strong)NSString <Optional>*办公楼栋类型;
@property(nonatomic,strong)NSString <Optional>*大堂装修情况;
@property(nonatomic,strong)NSString <Optional>*空调类型;
@property(nonatomic,strong)NSString <Optional>*调查时间;
@property(nonatomic,strong)NSString <Optional>*审核人;
@property(nonatomic,strong)NSString <Optional>*内部配套其它;
@property(nonatomic,strong)NSString <Optional>*售价;
@property(nonatomic,strong)NSString <Optional>*实际楼栋名称;
@property(nonatomic,strong)NSString <Optional>*货梯数量;
@property(nonatomic,strong)NSString <Optional>*楼盘ID;
@property(nonatomic,strong)NSString <Optional>*主要用途其它;
@property(nonatomic,strong)NSString <Optional>*外墙保养情况;
@property(nonatomic,strong)NSString <Optional>*楼盘名称;
@property(nonatomic,strong)NSString <Optional>*竣工时间;
@property(nonatomic,strong)NSString <Optional>*办公楼层;
@property(nonatomic,strong)NSString <Optional>*地下停车位;
@property(nonatomic,strong)NSString <Optional>*物业管理公司;
@property(nonatomic,strong)NSString <Optional>*竣工时间准确性;
@property(nonatomic,strong)NSString <Optional>*标准层装修情况;
@property(nonatomic,strong)NSString <Optional>*基本信息备注;
@property(nonatomic,strong)NSString <Optional>*大堂保养情况;
@property(nonatomic,strong)NSString <Optional>*大堂照片;
@property(nonatomic,strong)NSString <Optional>*主要用途;
@property(nonatomic,strong)NSString <Optional>*内部配套;
@property(nonatomic,strong)NSString <Optional>*地上楼层;
@property(nonatomic,strong)NSString <Optional>*物业管理费;
@property(nonatomic,strong)NSString <Optional>*客梯数量;
@property(nonatomic,strong)NSString <Optional>*标准层保养情况;
@property(nonatomic,strong)NSString <Optional>*物业管理备注;
@property(nonatomic,strong)NSString <Optional>*租金;
@property(nonatomic,strong)NSString <Optional>*STATE;
@property(nonatomic,strong)NSString <Optional>*租售模式;
@property(nonatomic,strong)NSString <Optional>*外墙照片;
@property(nonatomic,strong)NSString <Optional>*标准层平面图;
@property(nonatomic,strong)NSString <Optional>*楼栋类型其它;
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*配套设施备注;
@property(nonatomic,strong)NSString <Optional>*包含中央空调费;
@property(nonatomic,strong)NSString <Optional>*租售模式其它;
@property(nonatomic,strong)NSString <Optional>*审核时间;
@property(nonatomic,strong)NSString <Optional>*系统楼栋名称;
@property(nonatomic,strong)NSString <Optional>*标准层装修照片;
@property(nonatomic,strong)NSString <Optional>*地上停车位;
@property(nonatomic,strong)NSString <Optional>*物业管理评价;
@property(nonatomic,strong)NSString <Optional>*装修情况备注;
@property(nonatomic,strong)NSString <Optional>*外墙装修情况;
@property(nonatomic,strong)NSString <Optional>*租售情况备注;
@property(nonatomic,strong)NSString <Optional>*调查人;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*地下楼层;
@property(nonatomic,strong)NSString <Optional>*无法调查说明;
@property(nonatomic,strong)NSString <Optional>*主要用途备注;

@end

@interface OfficeBanModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,OfficeBanListModel>*list;
@end
