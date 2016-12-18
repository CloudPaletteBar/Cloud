//
//  ProgectManageView2.h
//  CloudPaletteBar
//
//  Created by Apple on 15/10/26.
//  Copyright © 2015年 cloudnetwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRGCalendarView.h"

@protocol ProgectManageDelegate;

@interface ProgectManageView2 : UIView <VRGCalendarViewDelegate>

@property (strong, nonatomic) id delegate;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *projectTypeBut;

@property (weak, nonatomic) IBOutlet UIButton *startTimeBut;
@property (weak, nonatomic) IBOutlet UIButton *overTimeBut;
@property (weak, nonatomic) IBOutlet UIButton *queryBut;
@property (weak, nonatomic) IBOutlet UIButton *cleckButon;


+(instancetype)progectView2;
-(instancetype)initWithProject2;

-(IBAction)selectorButton2:(UIButton *)sender;

@end

@protocol ProgectManage2Delegate

-(void)didSelectProgectManage2;

@end