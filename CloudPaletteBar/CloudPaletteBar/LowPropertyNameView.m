//
//  LowPropertyNameView.m
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "LowPropertyNameView.h"

@interface LowPropertyNameView (){
    UIView *lowPropertyView;
}

@end

@implementation LowPropertyNameView

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        lowPropertyView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
    }
    return self;
}

-(void)_init:(NSString *)title Weather:(NSString *)weather{
    self.titleTextField.userInteractionEnabled=NO;
    self.titleLable.text=title;
    self.titleTextField.placeholder=weather;
    self.titleTextField.leftView=lowPropertyView;
    self.titleTextField.leftViewMode=UITextFieldViewModeAlways;
}

- (IBAction)Clock:(id)sender {
    if (self.ClockLow) {
        self.ClockLow(self.tag);
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}
@end
