//
//  CalendarView.h
//  AirLogisticsS
//
//  Created by liu_yakai on 16/5/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NYDateTimeDelegate;

@interface CalendarView : UIView
@property(nonatomic,strong)void (^ClockDate)(NSString * dateStr);
@property (assign, nonatomic) id<NYDateTimeDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *datePickerView;

-(void)reloadWithDate:(NSInteger)numberDate;
-(void)pickerViewSetDate:(NSDate *)date;

@end

@protocol NYDateTimeDelegate <NSObject>
//更改内容
-(void)oneTimePickerValueChanged:(NSString *)dateString;


@end
