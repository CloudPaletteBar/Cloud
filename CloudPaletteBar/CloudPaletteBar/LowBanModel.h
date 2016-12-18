//
//  LowBanModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/9.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol  LowBanListModel @end
@interface LowBanListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*楼盘名称;
@property(nonatomic,strong)NSString <Optional>*STATE;
@property(nonatomic,strong)NSString <Optional>*审核人;
@property(nonatomic,strong)NSString <Optional>*调查人;
@property(nonatomic,strong)NSString <Optional>*任务ID;
@property(nonatomic,strong)NSString <Optional>*联排别墅数量;
@property(nonatomic,strong)NSString <Optional>*系统楼栋名称;
@property(nonatomic,strong)NSString <Optional>*调查时间;
@property(nonatomic,strong)NSString <Optional>*楼盘ID;
@property(nonatomic,strong)NSString <Optional>*地上楼层;
@property(nonatomic,strong)NSString <Optional>*竣工年代;
@property(nonatomic,strong)NSString <Optional>*建筑形态;
@property(nonatomic,strong)NSString <Optional>*地下楼层;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*总楼层;
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*实际楼栋名称;
@property(nonatomic,strong)NSString <Optional>*备注;
@property(nonatomic,strong)NSString <Optional>*相对位置;
@property(nonatomic,strong)NSString <Optional>*审核时间;
@property(nonatomic,strong)NSString <Optional>*无法调查说明;

@end

@interface LowBanModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,LowBanListModel>*list;
@end
