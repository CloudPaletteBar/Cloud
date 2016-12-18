//
//  LowSelectDateView.m
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "LowSelectDateView.h"
#import "NetworkManager.h"
#import "CloudPaletteBar.h"


@interface LowSelectDateView ()
{
    UIView *viewLeft;
}

@end
@implementation LowSelectDateView

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
    }
    return self;
}

-(void)_init:(NSString *)title InPutView:(UIView *)inputView{
    self.selectDateLable.text=title;
    self.titleTextField.text=[NetworkManager countTimeStr];
    self.titleTextField.tintColor=[UIColor clearColor];
    self.titleTextField.inputView=inputView;
    self.titleTextField.leftView=viewLeft;
    self.titleTextField.leftViewMode=UITextFieldViewModeAlways;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}



@end
