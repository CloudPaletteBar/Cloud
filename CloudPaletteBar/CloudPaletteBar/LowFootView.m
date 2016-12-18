//
//  LowFootView.m
//  CloudPaletteBar
//
//  Created by test on 16/8/25.
//  Copyright © 2016年 test. All rights reserved.
//

#import "LowFootView.h"

@implementation LowFootView

- (IBAction)saveClock:(id)sender {
    if (self.SaveClock) {
        [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
        self.SaveClock();
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}
@end
