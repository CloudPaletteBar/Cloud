//
//  OBanModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/10.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol OBanListModel @end
@interface OBanListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*调查时间;
@property(nonatomic,strong)NSString <Optional>*STATE;
@property(nonatomic,strong)NSString <Optional>*备注;
@property(nonatomic,strong)NSString <Optional>*实际楼栋名称;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*梯位户数比;
@property(nonatomic,strong)NSString <Optional>*调查人;
@property(nonatomic,strong)NSString <Optional>*楼层差价;
@property(nonatomic,strong)NSString <Optional>*系统楼栋名称;
@property(nonatomic,strong)NSString <Optional>*楼盘编号;
@property(nonatomic,strong)NSString <Optional>*楼盘名称;
@property(nonatomic,strong)NSString <Optional>*每层价格相差;
@property(nonatomic,strong)NSString <Optional>*无法调查说明;

@end


@interface OBanModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,OBanListModel>*list;
@end
