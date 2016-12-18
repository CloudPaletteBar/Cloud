//
//  BuildingView2TableViewCell.h
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/9/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuildingView2TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

-(void)laodData:(NSString *)str;

@property(nonatomic,strong)void (^SelectViewButton)(NSString *str);

@end
