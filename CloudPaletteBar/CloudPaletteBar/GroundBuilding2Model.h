//
//  GroundBuilding2Model.h
//  CloudPaletteBar
//
//  Created by mhl on 16/9/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol GroundBuilding2ListModel  @end

@interface GroundBuilding2Model : JSONModel
@property (strong, nonatomic)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,GroundBuilding2ListModel>*list;
@end


@interface GroundBuilding2ListModel : JSONModel

@property (strong, nonatomic)NSString <Optional>*备注;
@property (strong, nonatomic)NSString <Optional>*ID;
@property (strong, nonatomic)NSString <Optional>*工业楼盘ID;
@property (strong, nonatomic)NSString <Optional>*工业楼盘名称;
@property (strong, nonatomic)NSString <Optional>*楼栋编号;
@property (strong, nonatomic)NSString <Optional>*系统楼栋名称;
@property (strong, nonatomic)NSString <Optional>*实际楼栋名称;
@property (strong, nonatomic)NSString <Optional>*竣工时间;
@property (strong, nonatomic)NSString <Optional>*竣工时间准确性;
@property (strong, nonatomic)NSString <Optional>*楼栋总层数;
@property (strong, nonatomic)NSString <Optional>*地上层数;
@property (strong, nonatomic)NSString <Optional>*地下层数;
@property (strong, nonatomic)NSString <Optional>*成新率;
@property (strong, nonatomic)NSString <Optional>*电梯;
@property (strong, nonatomic)NSString <Optional>*电梯数量;
@property (strong, nonatomic)NSString <Optional>*建筑结构;
@property (strong, nonatomic)NSString <Optional>*外墙装修情况;
@property (strong, nonatomic)NSString <Optional>*外墙保养情况;
@property (strong, nonatomic)NSString <Optional>*内墙装修情况;
@property (strong, nonatomic)NSString <Optional>*内墙保养情况;
@property (strong, nonatomic)NSString <Optional>*天棚装修情况;
@property (strong, nonatomic)NSString <Optional>*天棚保养情况;
@property (strong, nonatomic)NSString <Optional>*楼地面装修情况;
@property (strong, nonatomic)NSString <Optional>*楼地面保养情况;
@property (strong, nonatomic)NSString <Optional>*入户门装修情况;
@property (strong, nonatomic)NSString <Optional>*入户门保养情况;
@property (strong, nonatomic)NSString <Optional>*窗装修情况;
@property (strong, nonatomic)NSString <Optional>*窗保养情况;
@property (strong, nonatomic)NSString <Optional>*物管公司;
@property (strong, nonatomic)NSString <Optional>*物管公司名称;
@property (strong, nonatomic)NSString <Optional>*物管公司数据来源;
@property (strong, nonatomic)NSString <Optional>*物业管理费;
@property (strong, nonatomic)NSString <Optional>*物业管理费数据来源;
@property (strong, nonatomic)NSString <Optional>*停车位;
@property (strong, nonatomic)NSString <Optional>*地上停车位;
@property (strong, nonatomic)NSString <Optional>*地下停车位;
@property (strong, nonatomic)NSString <Optional>*设施安装情况;
@property (strong, nonatomic)NSString <Optional>*配套服务设施;
@property (strong, nonatomic)NSString <Optional>*交通便捷度;
@property (strong, nonatomic)NSString <Optional>*临街类型;
@property (strong, nonatomic)NSString <Optional>*楼栋类型;
@property (strong, nonatomic)NSString <Optional>*厂房仓储类型;
@property (strong, nonatomic)NSString <Optional>*产业集聚度;
@property (strong, nonatomic)NSString <Optional>*产业类型;
@property (strong, nonatomic)NSString <Optional>*企业名称;
@property (strong, nonatomic)NSString <Optional>*企业行业类别;
@property (strong, nonatomic)NSString <Optional>*办公装修档次;
@property (strong, nonatomic)NSString <Optional>*宿舍装修档次;
@property (strong, nonatomic)NSString <Optional>*宿舍是否独立卫生间;
@property (strong, nonatomic)NSString <Optional>*工业配套;
@property (strong, nonatomic)NSString <Optional>*楼栋外观照片;
@property (strong, nonatomic)NSString <Optional>*无法调查说明;//个案没有。
@property (strong, nonatomic)NSString <Optional>*宗地号;
@property (strong, nonatomic)NSString <Optional>*是否独栋;//0就不是 1就是

@end


@interface GroundBuilding2ListTypeModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*电气;
@property(nonatomic,strong)NSString <Optional>*消防;
@property(nonatomic,strong)NSString <Optional>*给排水;
@property(nonatomic,strong)NSString <Optional>*弱电;
@property(nonatomic,strong)NSString <Optional>*空调;
@property(nonatomic,strong)NSString <Optional>*变配电;
@end

@interface GroundBuilding2ListType2Model : JSONModel
@property(nonatomic,strong)NSString <Optional>*食堂;
@property(nonatomic,strong)NSString <Optional>*变电房;
@property(nonatomic,strong)NSString <Optional>*门卫室;
@property(nonatomic,strong)NSString <Optional>*锅炉房;
@property(nonatomic,strong)NSString <Optional>*其他;
@end







