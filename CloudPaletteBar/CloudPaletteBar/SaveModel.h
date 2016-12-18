//
//  SaveModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/7.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SaveModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSString <Optional>*ID;
@property(nonatomic,strong)NSString <Optional>*message;

@end
