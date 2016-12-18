//
//  ObtainModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/20.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol ObtainListModel @end
@interface ObtainListModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*MY_ROWNUM;
@property(nonatomic,strong)NSString <Optional>*CONST_ENDDATE;
@property(nonatomic,strong)NSString <Optional>*楼栋编号;
@property(nonatomic,strong)NSString <Optional>*系统楼盘名称;
@property(nonatomic,strong)NSString <Optional>*系统楼栋名称;
@end

@interface ObtainModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSArray <Optional,ObtainListModel>*list;
@end
