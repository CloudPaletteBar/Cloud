//
//  LowInvestigationView.m
//  CloudPaletteBar
//
//  Created by test on 16/8/25.
//  Copyright © 2016年 test. All rights reserved.
//

#import "LowInvestigationView.h"

@implementation LowInvestigationView

-(void)_init:(NSString *)title OpenClose:(BOOL)openClose{
    self.titleLable.text=title;
    self.titleSwitch.on=openClose;
}
- (IBAction)switchClock:(id)sender {
    
    if (self.Clock) {
        UISwitch *swotch=(UISwitch *)sender;
        self.Clock(swotch.on);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}
@end
