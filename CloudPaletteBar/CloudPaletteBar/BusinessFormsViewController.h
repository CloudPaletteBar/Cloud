//
//  BusinessFormsViewController.h
//  CloudPaletteBar
//
//  Created by mhl on 16/8/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BaseViewController.h"

@interface BusinessFormsViewController : BaseViewController


@property(nonatomic,assign)NSInteger selectIndex;
@property (strong, nonatomic)void (^BlackVC)();

@end
