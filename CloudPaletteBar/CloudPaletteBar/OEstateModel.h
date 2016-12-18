//
//  OEstateModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/10.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>



//运动设施
@interface OEstateMotionModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*网球场;
@property(nonatomic,strong)NSString <Optional>*羽毛球场;
@property(nonatomic,strong)NSString <Optional>*篮球场;
@property(nonatomic,strong)NSString <Optional>*乒乓球台;
@property(nonatomic,strong)NSString <Optional>*室内泳池;
@property(nonatomic,strong)NSString <Optional>*室外泳池;
@property(nonatomic,strong)NSString <Optional>*室内健身房;
@property(nonatomic,strong)NSString <Optional>*桌球;
@property(nonatomic,strong)NSString <Optional>*其它;
@end

//活动设施
@interface OEstateActivityModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*图书馆;
@property(nonatomic,strong)NSString <Optional>*棋牌室;
@property(nonatomic,strong)NSString <Optional>*健身设施;
@property(nonatomic,strong)NSString <Optional>*儿童活动场所;
@property(nonatomic,strong)NSString <Optional>*多功能活动中心;
@property(nonatomic,strong)NSString <Optional>*其它;
@end

//安保情况
@interface OEstateSecurityModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*小时保安;
@property(nonatomic,strong)NSString <Optional>*定时巡逻;
@property(nonatomic,strong)NSString <Optional>*闭路电视监控系统;
@property(nonatomic,strong)NSString <Optional>*智能IC卡门禁系统;
@property(nonatomic,strong)NSString <Optional>*可视门禁系统;
@property(nonatomic,strong)NSString <Optional>*智能车场管理系统;
@property(nonatomic,strong)NSString <Optional>*红外防盗报警系统;
@end

//不利因素
@interface OEstateDisadvantageModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*城中村;
@property(nonatomic,strong)NSString <Optional>*加油站;
@property(nonatomic,strong)NSString <Optional>*工厂;
@property(nonatomic,strong)NSString <Optional>*污水处理厂;
@property(nonatomic,strong)NSString <Optional>*电厂;
@property(nonatomic,strong)NSString <Optional>*高压线;
@property(nonatomic,strong)NSString <Optional>*铁路;
@property(nonatomic,strong)NSString <Optional>*垃圾站;
@property(nonatomic,strong)NSString <Optional>*其它;
@end

//楼盘景观设施
@interface OEstateSceneryModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*草坪;
@property(nonatomic,strong)NSString <Optional>*花园花架;
@property(nonatomic,strong)NSString <Optional>*凉亭;
@property(nonatomic,strong)NSString <Optional>*水池喷泉 ;
@property(nonatomic,strong)NSString <Optional>*回廊;
@property(nonatomic,strong)NSString <Optional>*雕塑;
@property(nonatomic,strong)NSString <Optional>*休闲桌椅;
@property(nonatomic,strong)NSString <Optional>*假山;
@end

//楼盘外观照片
//楼栋平面图
//景观图
@interface OEstateStandardPhModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*zhaopian1;
@property(nonatomic,strong)NSString <Optional>*zhaopian2;
@property(nonatomic,strong)NSString <Optional>*zhaopian3;
@property(nonatomic,strong)NSString <Optional>*zhaopian4;
@property(nonatomic,strong)NSString <Optional>*zhaopian5;
@end


@protocol OEstateListModel @end
@interface OEstateListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*运动设施;
@property(nonatomic,strong)NSString <Optional>*高尔夫球场名称;
@property(nonatomic,strong)NSString <Optional>*运动设施其它;
@property(nonatomic,strong)NSString <Optional>*小学名称;
@property(nonatomic,strong)NSString <Optional>*楼盘外观照片;
@property(nonatomic,strong)NSString <Optional>*楼盘景观设施;
@property(nonatomic,strong)NSString <Optional>*竣工年代;
@property(nonatomic,strong)NSString <Optional>*地理位置2;
@property(nonatomic,strong)NSString <Optional>*商场;
@property(nonatomic,strong)NSString <Optional>*幼儿园;
@property(nonatomic,strong)NSString <Optional>*超市;
@property(nonatomic,strong)NSString <Optional>*山景;
@property(nonatomic,strong)NSString <Optional>*河流湖泊名称;
@property(nonatomic,strong)NSString <Optional>*STATE;
@property(nonatomic,strong)NSString <Optional>*会所个数;
@property(nonatomic,strong)NSString <Optional>*超市名称;
@property(nonatomic,strong)NSString <Optional>*社区医院名称;
@property(nonatomic,strong)NSString <Optional>*开发商;
@property(nonatomic,strong)NSString <Optional>*海滨名称;
@property(nonatomic,strong)NSString <Optional>*高尔夫球场;
@property(nonatomic,strong)NSString <Optional>*楼盘其它特点;
@property(nonatomic,strong)NSString <Optional>*海滨;
@property(nonatomic,strong)NSString <Optional>*公园名称;
@property(nonatomic,strong)NSString <Optional>*调查人;
@property(nonatomic,strong)NSString <Optional>*商场名称;
@property(nonatomic,strong)NSString <Optional>*安保情况;
@property(nonatomic,strong)NSString <Optional>*小学;
@property(nonatomic,strong)NSString <Optional>*中学名称;
@property(nonatomic,strong)NSString <Optional>*不利因素;
@property(nonatomic,strong)NSString <Optional>*社区医院;
@property(nonatomic,strong)NSString <Optional>*楼栋平面图;
@property(nonatomic,strong)NSString <Optional>*专业绿化养护管理;
@property(nonatomic,strong)NSString <Optional>*学位;
@property(nonatomic,strong)NSString <Optional>*系统楼盘编号;
@property(nonatomic,strong)NSString <Optional>*不利因素其它;
@property(nonatomic,strong)NSString <Optional>*容积率;
@property(nonatomic,strong)NSString <Optional>*河流湖泊;
@property(nonatomic,strong)NSString <Optional>*车位总数;
@property(nonatomic,strong)NSString <Optional>*物业管理费;
@property(nonatomic,strong)NSString <Optional>*中学;
@property(nonatomic,strong)NSString <Optional>*托儿所名称;
@property(nonatomic,strong)NSString <Optional>*露天车位数;
@property(nonatomic,strong)NSString <Optional>*绿地率;
@property(nonatomic,strong)NSString <Optional>*会所;
@property(nonatomic,strong)NSString <Optional>*活动设施;
@property(nonatomic,strong)NSString <Optional>*公园;
@property(nonatomic,strong)NSString <Optional>*山景名称;
@property(nonatomic,strong)NSString <Optional>*人文景观广场;
@property(nonatomic,strong)NSString <Optional>*物业公司;
@property(nonatomic,strong)NSString <Optional>*学位名称;
@property(nonatomic,strong)NSString <Optional>*活动设施其它;
@property(nonatomic,strong)NSString <Optional>*托儿所;
@property(nonatomic,strong)NSString <Optional>*占地面积;
@property(nonatomic,strong)NSString <Optional>*幼儿园名称;
@property(nonatomic,strong)NSString <Optional>*调查时间;
@property(nonatomic,strong)NSString <Optional>*人文景观广场名称;
@property(nonatomic,strong)NSString <Optional>*实际楼盘名称;
@property(nonatomic,strong)NSString <Optional>*地理位置1;
@property(nonatomic,strong)NSString <Optional>*室内车位数;
@property(nonatomic,strong)NSString <Optional>*系统楼盘名称;

@end


@interface OEstateModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,OEstateListModel>*list;
@end
