//
//  LowPackView.m
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "LowPackView.h"

@interface LowPackView (){
    UIView *lowPropertyView;
}

@end

@implementation LowPackView

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        lowPropertyView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
    }
    return self;
}

-(void)_init:(NSString *)title Weather:(NSString *)weather InPutView:(UIView *)inPutView{
    self.titleLable.text=title;
    self.titleTextField.placeholder=weather;
    self.titleTextField.leftViewMode=UITextFieldViewModeAlways;
    self.titleTextField.leftView=lowPropertyView;
    self.titleTextField.tintColor=[UIColor clearColor];
    self.titleTextField.inputView=inPutView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}

@end
