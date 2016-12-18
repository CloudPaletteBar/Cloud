//
//  OutModel.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/14.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface OutModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSString <Optional>*message;
@end
