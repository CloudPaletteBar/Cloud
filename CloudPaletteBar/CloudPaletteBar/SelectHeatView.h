//
//  SelectHeatView.h
//  DriverSide
//
//  Created by test on 16/7/22.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectHeatView : UIView
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property(nonatomic,strong)void (^ClockHeat)();
@end
