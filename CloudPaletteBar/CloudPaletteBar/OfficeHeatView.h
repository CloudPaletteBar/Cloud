//
//  OfficeHeatView.h
//  CloudPaletteBar
//
//  Created by test on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfficeHeatView : UIView
@property (weak, nonatomic) IBOutlet UILabel *officeNumberLable;
@property (weak, nonatomic) IBOutlet UILabel *officeNameLable;
@property (weak, nonatomic) IBOutlet UILabel *officePeopleLable;

-(void)_init:(NSString *)estateNumber EstateName:(NSString *)estateName EstatePeople:(NSString *)estatePeople;
@end
