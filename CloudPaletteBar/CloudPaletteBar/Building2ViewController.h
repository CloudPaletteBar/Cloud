//
//  Building2ViewController.h
//  CloudPaletteBar
//
//  Created by mhl on 16/8/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BaseViewController.h"
#import "DVSwitch.h"

@interface Building2ViewController : BaseViewController

@property (strong, nonatomic)IBOutlet UIScrollView *buil2ScrollView;
@property (strong, nonatomic)IBOutlet UIView *contentView;

@property (strong, nonatomic)NSString *strId;
@property (strong, nonatomic)NSString *taskId;
@property (nonatomic,assign)NSInteger selectIndex;

@end
