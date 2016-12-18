//
//  SelectFormPickerView.m
//  CloudPaletteBar
//
//  Created by test on 16/8/17.
//  Copyright © 2016年 test. All rights reserved.
//

#import "SelectFormPickerView.h"
#import "CloudPaletteBar.h"

@interface SelectFormPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{

    NSString *selectStr;
    NSInteger selectIndex;
}
@end

@implementation SelectFormPickerView

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        selectIndex=0;
    }
    return self;
}

-(void)_init:(NSArray *)array{
    _trafficArray=array;
    
    _selectPickView.delegate = self;
    _selectPickView.dataSource = self;
}

-(void)setTrafficArray:(NSArray *)trafficArray{
        _trafficArray=trafficArray;
    selectStr =[_trafficArray objectAtIndex:selectIndex];
    [self.selectPickView reloadAllComponents];
    
    
}

- (IBAction)dissClock:(id)sender {
    [[[[UIApplication sharedApplication] delegate] window]endEditing:YES];
}

- (IBAction)fishClock:(id)sender {
  
    if (self.Clock) {
        self.Clock(selectStr);
    }
      [[[[UIApplication sharedApplication] delegate] window]endEditing:YES];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_trafficArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    if (row==0) {
//        selectStr=[_trafficArray objectAtIndex:row];
//    }
    return [_trafficArray objectAtIndex:row];
}

-(void) pickerView: (UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component{
    NSLog(@"%@",[_trafficArray objectAtIndex:row]);
    selectIndex=row;
    selectStr=[_trafficArray objectAtIndex:row];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}
@end
