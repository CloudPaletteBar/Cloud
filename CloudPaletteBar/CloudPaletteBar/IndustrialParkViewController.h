//
//  IndustrialParkViewController.h
//  
//
//  Created by 李卫振 on 16/8/25.
//
//

#import "BaseViewController.h"

@interface IndustrialParkViewController : BaseViewController


@property (strong, nonatomic)IBOutlet UIScrollView *industrialScrollView;
@property (strong, nonatomic)IBOutlet UIView *contentView;


@property (strong, nonatomic)NSString *strId;
@property (strong, nonatomic)NSString *taskId;
@property (nonatomic,assign)NSInteger selectIndex;


@end
