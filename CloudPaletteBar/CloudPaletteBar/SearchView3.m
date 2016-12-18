//
//  SearchView3.m
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/9/4.
//  Copyright © 2016年 test. All rights reserved.
//

#import "SearchView3.h"
#import "FormSelectTableView.h"
#import "CloudPaletteBar.h"
#import "BaseView.h"
#import "NetworkManager.h"

@implementation SearchView3
{
    BOOL selectBool;
    FormSelectTableView *formSelectTableView;
}


-(void)loadOtherView{
    [self layerView:self.categoryButton];
    [self layerView:self.startTime];
    [self layerView:self.searchButton];
    formSelectTableView=[[FormSelectTableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-150)];
    formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
        [_categoryButton setTitle:selectStr forState:UIControlStateNormal];
    };
}
-(void)layerView:(UIView *)view{
    view.layer.cornerRadius = 3.0;
}

-(void)buttonImage:(BOOL)sender{
    [self endEditing:YES];
    
    if (sender) {
        if (self.PulldownButton) {
            self.PulldownButton(@"上");
            self.searchBar.hidden = YES;
            self.searchButton.hidden = NO;
            self.classifyView.hidden = NO;
            [self.imageButton setImage:[UIImage imageNamed:@"矢量智能对象-副本-19"] forState:UIControlStateNormal];
        }
    }else{
        if (self.PulldownButton) {
            self.PulldownButton(@"下");
            self.searchButton.hidden = YES;
            self.searchBar.hidden = NO;
            self.classifyView.hidden = YES;
            [self.imageButton setImage:[UIImage imageNamed:@"矢量智能对象-副本-18"] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)clickButton:(UIButton *)sender {
    selectBool = !selectBool;
    [self buttonImage:selectBool];
}


//点击搜索按钮
- (IBAction)SearchButton:(UIButton *)sender {
    
    selectBool = !selectBool;
    [self buttonImage:selectBool];
    
    if (self.SearchData) {
        self.SearchData(self.categoryButton.titleLabel.text, self.startTime.titleLabel.text);
    }
}



-(IBAction)selectButton:(UIButton *)sender{
    
    [self endEditing:YES];
    
    switch (sender.tag) {
        case 501:{
            formSelectTableView.formSelectArray=[NetworkManager _readInit:@"Region"];
            [[BaseView baseShar]_initPop:formSelectTableView Type:1];
        }
            break;
        case 502:{
            [self timePicker:502];
        }
            break;
    }
}

-(void)timePicker:(int)number
{
    if (_selectDatePicker == nil) {
        _selectDatePicker = [[MHDatePicker alloc] init];
        _selectDatePicker.isBeforeTime = YES;
        _selectDatePicker.datePickerMode = UIDatePickerModeDate;
        
        __weak typeof(self) weakSelf = self;
        [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
            
            NSString *timeStr = [NSString stringWithFormat:@"%@",selectedDate];
            NSLog(@"%@",timeStr);
            [weakSelf.startTime setTitle:[timeStr substringToIndex:10] forState:UIControlStateNormal];
            
        }];
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
