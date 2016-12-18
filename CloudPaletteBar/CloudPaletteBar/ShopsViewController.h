//
//  ShopsViewController.h
//  CloudPaletteBar
//
//  Created by mhl on 16/8/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BaseViewController.h"

@interface ShopsViewController : BaseViewController



@property (strong, nonatomic)IBOutlet UIScrollView *buil4ScrollView;
@property (strong, nonatomic)IBOutlet UIView *contentView;


@property (strong, nonatomic)NSString *taskID;
@property (strong, nonatomic)NSString *strId;
@property (nonatomic,assign)NSInteger selectIndex;

@end
