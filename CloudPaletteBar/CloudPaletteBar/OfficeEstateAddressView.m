//
//  OfficeEstateAddressView.m
//  CloudPaletteBar
//
//  Created by test on 16/8/17.
//  Copyright © 2016年 test. All rights reserved.
//

#import "OfficeEstateAddressView.h"

@implementation OfficeEstateAddressView

-(void)_init:(NSString *)addressTitle WeatherMarkAddress:(NSString *)weatherMarkAddress AreaTitle:(NSString *)areaTitle WeatherMarkArea:(NSString *)weatherMarkArea RoundTitle:(NSString *)roundTitle WeatherMarkRound:(NSString *)weatherMarkRound EndTiele:(NSString *)endTitle{
    self.addressTitleLable.text=addressTitle;
    self.addressTextField.placeholder=weatherMarkAddress;
    self.areaLable.text=areaTitle;
    self.areaTextField.placeholder=weatherMarkArea;
    self.roundLable.text=roundTitle;
    self.roundTextField.placeholder=weatherMarkRound;
    self.endLable.text=endTitle;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.addressTextField.leftViewMode=UITextFieldViewModeAlways;
    self.addressTextField.leftView=view;
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.areaTextField.leftViewMode=UITextFieldViewModeAlways;
    self.areaTextField.leftView=view1;
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.roundTextField.leftViewMode=UITextFieldViewModeAlways;
    self.roundTextField.leftView=view2;
    
}
-(void)_initText:(NSString *)address Area:(NSString *)area Round:(NSString *)round{
    self.addressTextField.text=address;
    self.areaTextField.text=area;
    self.roundTextField.text=round;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}
@end
