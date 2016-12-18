//
//  SettingCell.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellLable;
-(void)_initCell:(NSDictionary *)dic;
@end
