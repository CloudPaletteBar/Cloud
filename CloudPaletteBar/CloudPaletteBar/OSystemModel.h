//
//  OSystemModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/20.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol OSystemListModel @end
@interface OSystemListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*楼盘ID;
@property(nonatomic,strong)NSString <Optional>*系统楼盘名称;
@property(nonatomic,strong)NSString <Optional>*MY_ROWNUM;
@property(nonatomic,strong)NSString <Optional>*实际楼盘名称;
@end


@interface OSystemModel : JSONModel
@property(nonatomic,strong)NSArray <Optional,OSystemListModel>*list;
@property(nonatomic,strong)NSString <Optional>*status;
@end
