//
//  OfficeEstateModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>



@protocol OfficeEstateListModel
@end
@interface OfficeEstateListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*开发商;
@property(nonatomic,strong)NSString <Optional>*楼盘别名;
@property(nonatomic,strong)NSString <Optional>*备注;
@property(nonatomic,strong)NSString <Optional>*调查时间;
@property(nonatomic,strong)NSString <Optional>*审核人;
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*审核时间;
@property(nonatomic,strong)NSString <Optional>*系统楼盘名称;
@property(nonatomic,strong)NSString <Optional>*调查人;
@property(nonatomic,strong)NSString <Optional>*查勘人;
@property(nonatomic,strong)NSString <Optional>*任务ID;
@property(nonatomic,strong)NSString <Optional>*查勘日期;
@property(nonatomic,strong)NSString <Optional>*地理位置1;
@property(nonatomic,strong)NSString <Optional>*STATE;
@property(nonatomic,strong)NSString <Optional>*总楼栋数;
@property(nonatomic,strong)NSString <Optional>*实际楼盘名称;
@property(nonatomic,strong)NSString <Optional>*交通便利程度;
@property(nonatomic,strong)NSString <Optional>*系统楼盘编号;
@property(nonatomic,strong)NSString <Optional>*地理位置2;
@end

@interface OfficeEstateModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,OfficeEstateListModel> *list;
@end
