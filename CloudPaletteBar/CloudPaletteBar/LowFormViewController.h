//
//  LowFormViewController.h
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BaseTableNoMJViewController.h"

@interface LowFormViewController : BaseTableNoMJViewController
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,strong)NSString *formID;
@property(nonatomic,strong)NSString * selectSee;

@property (strong, nonatomic)void (^BlackVC)();

@end
