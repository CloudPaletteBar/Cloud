//
//  HistoricalRecordModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/5.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol HistoricalRecordListModel @end
@interface HistoricalRecordListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*调查时间;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*实际楼栋名称;
@property(nonatomic,strong)NSString <Optional>*TYPE;
@property(nonatomic,strong)NSString <Optional>*任务ID;
@property(nonatomic,strong)NSString <Optional>*审核人帐号;
@property(nonatomic,strong)NSString <Optional>*TASKTYPE;
@property(nonatomic,strong)NSString <Optional>*调查人;
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*MY_ROWNUM;

@end

@interface HistoricalRecordModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,HistoricalRecordListModel>*list;

@end
