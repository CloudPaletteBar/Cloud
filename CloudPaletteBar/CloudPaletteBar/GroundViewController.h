//
//  GroundViewController.h
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/8/25.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BaseViewController.h"

@interface GroundViewController : BaseViewController


@property (strong, nonatomic)IBOutlet UIScrollView *groundScrollView;
@property (strong, nonatomic)IBOutlet UIView *contentView;

@property (strong, nonatomic)NSString *strId;
@property (strong, nonatomic)NSString *taskId;
@property (nonatomic,assign)NSInteger selectIndex;

@end
