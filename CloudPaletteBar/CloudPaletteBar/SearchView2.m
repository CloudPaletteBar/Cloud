//
//  SearchView2.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/17.
//  Copyright © 2016年 test. All rights reserved.
//

#import "SearchView2.h"
#import "zySheetPickerView.h"

@implementation SearchView2
{
    BOOL selectBool;
}

-(void)loadOtherView{
    [self layerView:self.textField1];
    [self layerView:self.textButton];
    [self layerView:self.textField2];
    [self layerView:self.searchButton2];
    [self layerView:self.addedButton];
}
-(void)layerView:(UIView *)view{
    view.layer.cornerRadius = 3.0;
}


-(void)buttonImage:(BOOL)sender{
    [self endEditing:YES];
    
    if (sender) {
        if (self.PulldownButton) {
            self.PulldownButton(@"上");
            self.searchBar2.hidden = YES;
            self.imageButton2.hidden = YES;
            self.searchButton2.hidden = NO;
            self.classifyView2.hidden = NO;
            [self.imageButton setImage:[UIImage imageNamed:@"矢量智能对象-副本-19"] forState:UIControlStateNormal];
        }
    }else{
        if (self.PulldownButton) {
            self.PulldownButton(@"下");
            self.searchButton2.hidden = YES;
            self.searchBar2.hidden = NO;
            self.imageButton2.hidden = NO;
            self.classifyView2.hidden = YES;
            [self.imageButton setImage:[UIImage imageNamed:@"矢量智能对象-副本-18"] forState:UIControlStateNormal];
        }
    }
}



- (IBAction)clickButton2:(UIButton *)sender {
    selectBool = !selectBool;
    [self buttonImage:selectBool];
}

- (IBAction)SearchButton2:(UIButton *)sender {
    
    selectBool = !selectBool;
//    [self buttonImage:selectBool];
    
    if (self.SearchData) {
        self.SearchData(self.textField1.text, self.textField2.text);
    }
}


-(IBAction)selectButton2:(UIButton *)sender{
    
    [self endEditing:YES];
    NSArray *array = @[@"所有",@"罗湖",@"福田",@"南山",@"龙华新区",@"龙岗",@"宝安",@"盐田",@"坪山新区",@"光明新区",@"大鹏新区"];
    
    zySheetPickerView *pickerView = [zySheetPickerView ZYSheetStringPickerWithTitle:array andHeadTitle:@"" Andcall:^(zySheetPickerView *pickerView, NSString *choiceString) {
        self.textField1.text = choiceString;
        [pickerView dismissPicker];
    }];
    [pickerView show];
}


- (IBAction)addedButton:(UIButton *)sender {
    
    if (selectBool) {
        selectBool = !selectBool;
        [self buttonImage:selectBool];
    }
    
    if (_addedPush) {
        self.addedPush();
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
