//
//  HouseSelectView.h
//  CloudPaletteBar
//
//  Created by test on 16/8/22.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVSwitch.h"
//xib 不可用
@interface HouseSelectView : UITableViewHeaderFooterView
@property (strong, nonatomic)  UILabel *titleLable;
@property (strong, nonatomic) DVSwitch *dVSwitch;
@property(nonatomic,strong)UILabel *cellLable;

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier DataArray:(NSArray *)dataArray;
@property(nonatomic,copy)void (^ ClockSelect)(NSInteger selectIndex,NSInteger Tag);

-(void)_init:(NSArray *)titles Title:(NSString *)title SelectIndex:(NSInteger)selectIndex;
-(void)_init:(NSString *)title SelectIndex:(NSInteger)selectIndex;
@end
