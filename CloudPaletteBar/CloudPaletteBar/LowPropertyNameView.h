//
//  LowPropertyNameView.h
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LowPropertyNameView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
-(void)_init:(NSString *)title Weather:(NSString *)weather;
@property(nonatomic,copy)void (^ ClockLow)(NSInteger Tag);
@end
