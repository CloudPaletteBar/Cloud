//
//  SelectHeatView.m
//  DriverSide
//
//  Created by test on 16/7/22.
//  Copyright © 2016年 test. All rights reserved.
//

#import "SelectHeatView.h"

@implementation SelectHeatView

- (IBAction)selectClock:(id)sender {
    if (self.ClockHeat) {
        self.ClockHeat();
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}
@end
