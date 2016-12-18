//
//  UpcomingTasksModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/31.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol UpcomingTasksListModel @end
@interface UpcomingTasksListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*MY_ROWNUM;
@property(nonatomic,strong)NSString <Optional>*TASKID;
@property(nonatomic,strong)NSString <Optional>*任务名称;
@property(nonatomic,strong)NSString <Optional>*结束时间;
@property(nonatomic,strong)NSString <Optional>*任务完成百分比;

@end


@interface UpcomingTasksModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*allNum;
@property(nonatomic,strong)NSString <Optional>*count;
@property(nonatomic,strong)NSString <Optional>*inDoNum;
@property(nonatomic,strong)NSArray <Optional,UpcomingTasksListModel>*list;
@end
