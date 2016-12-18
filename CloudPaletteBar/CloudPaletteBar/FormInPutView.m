//
//  FormInPutView.m
//  CloudPaletteBar
//
//  Created by test on 16/8/16.
//  Copyright © 2016年 test. All rights reserved.
//

#import "FormInPutView.h"

@implementation FormInPutView


-(void)_init:(NSString *)title WaterMark:(NSString *)waterMark{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 10)];
    self.formTextField.leftView=view;
    self.formTextField.leftViewMode=UITextFieldViewModeAlways;
    self.formTextField.placeholder=waterMark;
    self.formTitleLable.text=title;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}

@end
