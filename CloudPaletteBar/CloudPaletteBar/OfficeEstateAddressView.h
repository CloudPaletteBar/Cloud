//
//  OfficeEstateAddressView.h
//  CloudPaletteBar
//
//  Created by test on 16/8/17.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfficeEstateAddressView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *addressTitleLable;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UILabel *areaLable;
@property (weak, nonatomic) IBOutlet UITextField *areaTextField;
@property (weak, nonatomic) IBOutlet UILabel *roundLable;
@property (weak, nonatomic) IBOutlet UITextField *roundTextField;
@property (weak, nonatomic) IBOutlet UILabel *endLable;


-(void)_init:(NSString *)addressTitle WeatherMarkAddress:(NSString *)weatherMarkAddress AreaTitle:(NSString *)areaTitle WeatherMarkArea:(NSString *)weatherMarkArea RoundTitle:(NSString *)roundTitle WeatherMarkRound:(NSString *)weatherMarkRound EndTiele:(NSString *)endTitle;
-(void)_initText:(NSString *)address Area:(NSString *)area Round:(NSString *)round;
@end
