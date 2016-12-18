//
//  FirstCell.h
//  CloudPaletteBar
//
//  Created by test on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessModel.h"
#import "IndustryQuestionnaireModel.h"

@interface FirstCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;


@property(nonatomic,copy)void (^ HeatClock)(NSInteger indexCell);


-(void)laodData:(BusinessModelListModel *)dict andMakeType:(NSString *)makeType;
-(void)laodData2:(IndustryQuestionnaireListModel *)dict andMakeType:(NSString *)makeType;

@end
