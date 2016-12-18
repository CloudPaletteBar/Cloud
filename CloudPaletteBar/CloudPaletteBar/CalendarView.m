//
//  CalendarView.m
//  AirLogisticsS
//
//  Created by liu_yakai on 16/5/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import "CalendarView.h"
#import "CloudPaletteBar.h"

@interface CalendarView ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSString *selectTime;
    NSInteger dateNumber;
}

@property (strong,nonatomic) NSDateFormatter *myFomatter;
@property (strong,nonatomic) NSCalendar *calendar;
@property (strong,nonatomic) NSDate *selectedDate;
@property (strong,nonatomic) NSDate *pickerStartDate;
@property (strong,nonatomic) NSDate *pickEndDate;
@property (strong,nonatomic) NSDateComponents *selectedComponents;
@property NSInteger unitFlags;
@end

@implementation CalendarView



#pragma mark - UIView Methods
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self=[super initWithCoder:aDecoder];
    if (self) {
       
    }
    return self;
    
}



#pragma mark SubView Methods
-(void)reloadWithDate:(NSInteger)numberDate{
    dateNumber=numberDate;
    self.datePickerView.delegate = self;
    self.datePickerView.dataSource = self;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    selectTime = [formatter stringFromDate:[NSDate date]];
    [self setFomatter];
    self.selectedDate = [self.myFomatter dateFromString:selectTime];
    self.selectedComponents = [self.calendar components:self.unitFlags fromDate:self.selectedDate];
    [self pickerViewSetDate:self.selectedDate];
}

#pragma mark Private Methods
-(void)setFomatter{
    self.myFomatter = [[NSDateFormatter alloc]init];
    [self.myFomatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    self.calendar = [NSCalendar currentCalendar];
    self.selectedDate = [NSDate date];
    self.pickerStartDate = [self.myFomatter dateFromString:@"1900.2.1 13:59:59"];
    self.pickEndDate = [self.myFomatter dateFromString:@"2100.12.31 13:59:59"];
    self.unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute;
}



// 模拟datepicker setdate 方法
-(void)pickerViewSetDate:(NSDate *)date{
    NSDateComponents *temComponents = [[NSDateComponents alloc]init];
    temComponents = [self.calendar components:NSCalendarUnitYear fromDate:date];
    NSInteger yearRow = [temComponents year] - 1900;
    NSInteger monthRow = [[self.calendar components:NSCalendarUnitMonth fromDate:date] month] - 1;
    NSInteger dayRow = [[self.calendar components:NSCalendarUnitDay fromDate:date] day] - 1;
    NSInteger hourRow = [[self.calendar components:NSCalendarUnitHour fromDate:date] hour];
    NSInteger minRow = [[self.calendar components:NSCalendarUnitMinute fromDate:date] minute];
    [self.datePickerView selectRow:yearRow inComponent:0 animated:YES];
    [self.datePickerView selectRow:monthRow inComponent:1 animated:YES];
    [self.datePickerView selectRow:dayRow inComponent:2 animated:YES];
    if (dateNumber>3) {
        [self.datePickerView selectRow:hourRow inComponent:3 animated:YES];
        [self.datePickerView selectRow:minRow inComponent:4 animated:YES];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}

#pragma mark - UIPickerViewDataSource Methods
- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    UILabel *dateLabel = (UILabel *)view;
    if (!dateLabel) {
        dateLabel = [[UILabel alloc] init];
        [dateLabel setFont:[UIFont systemFontOfSize:17]];
    }
    
    switch (component) {
        case 0: {
            NSDateComponents *components = [self.calendar components:NSCalendarUnitYear
                                                            fromDate:self.pickerStartDate];
            NSString *currentYear = [NSString stringWithFormat:@"%ld年", [components year] + row];
            [dateLabel setText:currentYear];
            dateLabel.textAlignment = NSTextAlignmentCenter;
            break;
        }
        case 1: {
            NSString *currentMonth = [NSString stringWithFormat:@"%ld月",(long)row+1];
            [dateLabel setText:currentMonth];
            dateLabel.textAlignment = NSTextAlignmentCenter;
            break;
        }
        case 2: {
            NSRange dateRange = [self.calendar rangeOfUnit:NSCalendarUnitDay
                                                    inUnit:NSCalendarUnitMonth
                                                   forDate:self.selectedDate];
            
            NSString *currentDay = [NSString stringWithFormat:@"%lu日", (row + 1) % (dateRange.length + 1)];
            [dateLabel setText:currentDay];
            dateLabel.textAlignment = NSTextAlignmentCenter;
            break;
        }
        case 3:{
            NSString *currentHour = [NSString stringWithFormat:@"%ld时",(long)row];
            [dateLabel setText:currentHour];
            dateLabel.textAlignment = NSTextAlignmentCenter;
            break;
        }
        case 4:{
            NSString *currentMin = [NSString stringWithFormat:@"%02ld分",row];
            [dateLabel setText:currentMin];
            dateLabel.textAlignment = NSTextAlignmentCenter;
        }
        default:
            break;
    }
    
    return dateLabel;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return dateNumber;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:{
            NSDateComponents *startCpts = [self.calendar components:NSCalendarUnitYear
                                                           fromDate:self.pickerStartDate];
            NSDateComponents *endCpts = [self.calendar components:NSCalendarUnitYear
                                                         fromDate:self.pickEndDate];
            return [endCpts year] - [startCpts year] + 1;
        }
            
        case 1:
            return 12;
        case 2:{
            NSRange dayRange = [self.calendar rangeOfUnit:NSCalendarUnitDay
                                                   inUnit:NSCalendarUnitMonth
                                                  forDate:self.selectedDate];
            return dayRange.length;
        }
        case 3:
            return 24;
        case 4:
            return 60;
        default:
            break;
    }
    return 0;
}

//每次修改都要执行的方法
-(void)changeDateLabel{
    self.selectedDate = [self.calendar dateFromComponents:self.selectedComponents];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    selectTime = [dateFormatter stringFromDate:self.selectedDate];
   }

#pragma mark - UIPickerViewDelegate Methods
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            NSInteger year = 1900 + row ;
            [self.selectedComponents setYear:year];
            [self changeDateLabel];
        }
            break;
        case 1:
        {
//            [self.selectedComponents setMonth:row+1];
//            [self changeDateLabel];
            
            if (row +1 == 2) {
                
                [self.datePickerView selectRow:27 inComponent:2 animated:YES];
                [self.selectedComponents setDay:28];
                [self.selectedComponents setMonth:row+1];
                [self changeDateLabel];
            }
            else
            {
                [self.datePickerView selectRow:28 inComponent:2 animated:YES];
                [self.selectedComponents setDay:29];
                [self.selectedComponents setMonth:row+1];
                [self changeDateLabel];
            }

        }
            break;
        case 2:
        {
            [self.selectedComponents setDay:row +1];
            [self changeDateLabel];
        }
            break;
        case 3:
        {
            [self.selectedComponents setHour:row];
            [self changeDateLabel];
        }
            break;
        case 4:
        {
            [self.selectedComponents setMinute:row];
            [self changeDateLabel];
        }
    }
    [self.datePickerView reloadAllComponents];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    return 35.0;
}

- (IBAction)diss:(id)sender {
    [[[[UIApplication sharedApplication] delegate] window] endEditing:YES];
}
- (IBAction)carryOut:(id)sender {
    if (self.ClockDate) {
//        NSString *timeSp = [NSString stringWithFormat:@"%d", (long)[self.selectedDate timeIntervalSince1970]];
//        NSLog(@"%@",timeSp);
               self.ClockDate([NSString stringWithFormat:@"%ld", (long)[self.selectedDate timeIntervalSince1970]]);
    }
//    NSLog(@"%@",destDateString);
    [[[[UIApplication sharedApplication] delegate] window] endEditing:YES];
}

@end
