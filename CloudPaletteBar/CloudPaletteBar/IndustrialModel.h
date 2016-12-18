//
//  IndustrialModel.h
//  CloudPaletteBar
//
//  Created by mhl on 16/9/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol IndustrialListModel   @end

@interface IndustrialModel : JSONModel
@property (strong, nonatomic)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,IndustrialListModel>*list;
@end


@interface IndustrialListModel : JSONModel

@property (strong, nonatomic)NSString <Optional>*宗地号;
@property (strong, nonatomic)NSString <Optional>*是否属于工业园区;
@property (strong, nonatomic)NSString <Optional>*园区名称;
@property (strong, nonatomic)NSString <Optional>*任务ID;
@property (strong, nonatomic)NSString <Optional>*园区规模;
@property (strong, nonatomic)NSString <Optional>*准入条件;
@property (strong, nonatomic)NSString <Optional>*准入要求;
@property (strong, nonatomic)NSString <Optional>*内部配套;
@property (strong, nonatomic)NSString <Optional>*备注;
@property (strong, nonatomic)NSString <Optional>*ID;

@end

@interface IndustrialListTypeModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*商店;
@property(nonatomic,strong)NSString <Optional>*食堂;
@property(nonatomic,strong)NSString <Optional>*办公楼;
@property(nonatomic,strong)NSString <Optional>*宿舍;
@property(nonatomic,strong)NSString <Optional>*停车场;
@property(nonatomic,strong)NSString <Optional>*其他;
@end