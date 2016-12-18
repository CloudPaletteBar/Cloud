//
//  FormRemarksView.m
//  CloudPaletteBar
//
//  Created by test on 16/8/17.
//  Copyright © 2016年 test. All rights reserved.
//

#import "FormRemarksView.h"

@implementation FormRemarksView

- (IBAction)saveClock:(id)sender {
    if (self.ClockSave) {
        self.ClockSave(self.titleTextfield.text);
    }
}

-(void)_init:(NSString *)title{
    self.titleLable.text=title;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}
@end
