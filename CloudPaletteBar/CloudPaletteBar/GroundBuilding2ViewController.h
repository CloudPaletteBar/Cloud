//
//  GroundBuilding2ViewController.h
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/8/25.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BaseViewController.h"

@interface GroundBuilding2ViewController : BaseViewController


@property (strong, nonatomic)IBOutlet UIScrollView *buil2ScrollView;
@property (strong, nonatomic)IBOutlet UIView *contentView;


@property (strong, nonatomic)NSString *strId;
@property (strong, nonatomic)NSString *taskId;
@property (nonatomic,assign)NSInteger selectIndex;


@end
