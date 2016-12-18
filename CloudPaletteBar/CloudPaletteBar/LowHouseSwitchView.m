//
//  LowHouseSwitchView.m
//  CloudPaletteBar
//
//  Created by test on 16/8/26.
//  Copyright © 2016年 test. All rights reserved.
//

#import "LowHouseSwitchView.h"

@implementation LowHouseSwitchView

-(void)_init:(NSString *)title Title1:(NSString *)title1 TitleSwitch:(BOOL)titleOpen TitleSwitch1:(BOOL)titleOpen1{
    if (title1.length==0) {
        self.titleSwitch1.hidden=YES;
    }else{
        self.titleSwitch1.hidden=NO;
    }
    self.titleLable.text=title;
    self.titleLable1.text=title1;
    self.titleSwitch.on=titleOpen;
    self.titleSwitch1.on=titleOpen1;
    self.titleSwitch.tag=self.tag+1;
    self.titleSwitch1.tag=self.tag+100;
}
- (IBAction)clock:(id)sender {
    if (self.Clock) {
        UISwitch *switchView=(UISwitch *)sender;
        self.Clock(switchView.tag,switchView.on);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}

@end
