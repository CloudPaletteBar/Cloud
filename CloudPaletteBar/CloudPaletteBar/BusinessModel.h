//
//  BusinessModel.h
//  CloudPaletteBar
//
//  Created by mhl on 16/8/31.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol  BusinessModelListModel @end

@interface BusinessModelListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*实际楼盘名称;
@property(nonatomic,strong)NSString <Optional>*实际名称;
@property(nonatomic,strong)NSString <Optional>*调查人;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*楼层;
@property(nonatomic,strong)NSString <Optional>*楼栋名称;
@property(nonatomic,strong)NSString <Optional>*现场商铺号;

@end
@interface BusinessModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*count;
@property(nonatomic,strong)NSString <Optional>*pageNo;
@property(nonatomic,strong)NSString <Optional>*pageSize;

@property(nonatomic,strong)NSArray <Optional,BusinessModelListModel>*list;
@end
