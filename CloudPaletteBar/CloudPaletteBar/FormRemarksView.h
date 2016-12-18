//
//  FormRemarksView.h
//  CloudPaletteBar
//
//  Created by test on 16/8/17.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormRemarksView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UITextView *titleTextfield;
@property(nonatomic,copy)void (^ ClockSave)(NSString *str);

-(void)_init:(NSString *)title;
@end
