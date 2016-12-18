//
//  LowHouseSwitchView.h
//  CloudPaletteBar
//
//  Created by test on 16/8/26.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LowHouseSwitchView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UISwitch *titleSwitch;
@property (weak, nonatomic) IBOutlet UILabel *titleLable1;
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLable;
@property (weak, nonatomic) IBOutlet UISwitch *titleSwitch1;
-(void)_init:(NSString *)title Title1:(NSString *)title1 TitleSwitch:(BOOL)titleOpen TitleSwitch1:(BOOL)titleOpen1;
@property(nonatomic,copy)void (^Clock)(NSInteger indexSwitch,BOOL open);
@end
