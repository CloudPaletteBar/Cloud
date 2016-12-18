//
//  LoginModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/29.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol LoginRoleModel @end
@interface LoginRoleModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*roleName;
@end

@interface LoginModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*message;
@property(nonatomic,strong)NSArray <Optional,LoginRoleModel>*role;
@property(nonatomic,strong)NSString <Optional>*taskNum;
@property(nonatomic,strong)NSString <Optional>*usertype;
@end
