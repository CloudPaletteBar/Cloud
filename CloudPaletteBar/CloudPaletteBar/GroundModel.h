//
//  GroundModel.h
//  CloudPaletteBar
//
//  Created by mhl on 16/9/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol GroundListModel   @end


@interface GroundModel : JSONModel
@property (strong, nonatomic)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,GroundListModel>*list;
@end


@interface GroundListModel : JSONModel

@property (strong, nonatomic)NSString <Optional>*调查人;
@property (strong, nonatomic)NSString <Optional>*调查时间;
@property (strong, nonatomic)NSString <Optional>*宗地编号;
@property (strong, nonatomic)NSString <Optional>*任务ID;
@property (strong, nonatomic)NSString <Optional>*行政区;
@property (strong, nonatomic)NSString <Optional>*街道办;
@property (strong, nonatomic)NSString <Optional>*标准分区;
@property (strong, nonatomic)NSString <Optional>*组别名称;
@property (strong, nonatomic)NSString <Optional>*备注;
@property (strong, nonatomic)NSString <Optional>*ID;

@end
