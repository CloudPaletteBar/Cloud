//
//  TaskDetailsModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/2.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol TaskDetailsListModel @end
@interface TaskDetailsListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*开始时间;
@property(nonatomic,strong)NSString <Optional>*调查公司;
@property(nonatomic,strong)NSString <Optional>*结束时间;
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*任务名称;
@property(nonatomic,strong)NSString <Optional>*优先级别;
@property(nonatomic,strong)NSString <Optional>*分配方式;
@property(nonatomic,strong)NSString <Optional>*审核人;
@property(nonatomic,strong)NSString <Optional>*任务条数;
@property(nonatomic,strong)NSString <Optional>*任务类型;
@property(nonatomic,strong)NSString <Optional>*项目名称;
@property(nonatomic,strong)NSString <Optional>*处理状态;
@property(nonatomic,strong)NSString <Optional>*项目类型;
@property(nonatomic,strong)NSString <Optional>*调查子类;
@property(nonatomic,strong)NSString <Optional>*任务负责人;
@property(nonatomic,strong)NSString <Optional>*已完成;
@property(nonatomic,strong)NSString <Optional>*审核说明;
@property(nonatomic,strong)NSString <Optional>*审核状态;
@property(nonatomic,strong)NSString <Optional>*未完成;

@end

@interface TaskDetailsModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,TaskDetailsListModel>*list;
@end
