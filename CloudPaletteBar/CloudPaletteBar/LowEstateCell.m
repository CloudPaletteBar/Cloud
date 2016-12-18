//
//  LowEstateCell.m
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "LowEstateCell.h"

@interface LowEstateCell(){
    UIView *lowPropertyView;
}

@end


@implementation LowEstateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    lowPropertyView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)_cellInit:(NSString *)title Weather:(NSString *)weather{
//    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
//    self.cellTextField.leftView=view;
    self.cellTextField.leftViewMode=UITextFieldViewModeAlways;
    self.cellTextField.leftView=lowPropertyView;
    self.cellTextField.leftViewMode=UITextFieldViewModeAlways;
    self.cellLable.text=title;
    self.cellTextField.placeholder=weather;
}

@end
