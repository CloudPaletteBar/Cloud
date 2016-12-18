//
//  ShopsViewTableViewCell.h
//  CloudPaletteBar
//
//  Created by mhl on 16/9/22.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommerciaEstateModel.h"

@interface ShopsViewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

-(void)laodData:(CommerciaEstateListModel *)dict;

@property(nonatomic,strong)void (^SelectViewButton)(NSString *str, NSString *str2);

@end
