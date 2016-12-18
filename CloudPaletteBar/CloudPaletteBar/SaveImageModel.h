//
//  SaveImageModel.h
//  CloudPaletteBar
//
//  Created by test on 16/8/20.
//  Copyright © 2016年 test. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SaveImageModel : JSONModel
//图片路径
@property(nonatomic,strong)NSString <Optional>*imagePath;
//任务id
@property(nonatomic,strong)NSString <Optional>* tackId;
//图片类型
@property(nonatomic,strong)NSString <Optional>*imageType;

@property(nonatomic,strong)NSString <Optional>*imageState;
@property(nonatomic,strong)NSString <Optional>*imageName;
@property(nonatomic,strong)NSString <Optional>*orderType;
//表单id
@property(nonatomic,strong)NSString <Optional>*ID;
@end
