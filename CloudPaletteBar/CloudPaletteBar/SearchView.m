//
//  SearchView.m
//  搜索
//
//  Created by mhl on 16/8/15.
//  Copyright © 2016年 mhl. All rights reserved.
//

#import "SearchView.h"


@implementation SearchView
{
    BOOL selectBool;
}


-(void)loadOtherView{
    [self layerView:self.nameField];
    [self layerView:self.areaButton];
    [self layerView:self.categoryButton];
    [self layerView:self.startTime];
    [self layerView:self.endTime];
    [self layerView:self.searchButton];
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
        self.SearchData(self.nameField.text, self.areaButton.titleLabel.text, self.categoryButton.titleLabel.text, self.startTime.titleLabel.text, self.endTime.titleLabel.text);
    }
}



-(IBAction)selectButton:(UIButton *)sender{
    
    [self endEditing:YES];
    
    switch (sender.tag) {
        case 500:{
            
        }
            break;
        case 501:{
            
        }
            break;
        case 502:{
            [self timePicker:502];
        }
            break;
        case 503:{
            [self timePicker:503];
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
            if (number == 502) {
                [weakSelf.startTime setTitle:[timeStr substringToIndex:10] forState:UIControlStateNormal];
            }else{
                [weakSelf.endTime setTitle:[timeStr substringToIndex:10] forState:UIControlStateNormal];
            }
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
