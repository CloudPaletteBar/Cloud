//
//  OSystemModel.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/20.
//  Copyright © 2016年 test. All rights reserved.
//

#import "OSystemModel.h"

@implementation OSystemListModel
+(JSONKeyMapper*)keyMapper {
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"ID":@"楼盘ID"}];
}
@end

@implementation OSystemModel

@end
