//
//  OfficeHeatView.m
//  CloudPaletteBar
//
//  Created by test on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "OfficeHeatView.h"

@implementation OfficeHeatView

-(void)_init:(NSString *)estateNumber EstateName:(NSString *)estateName EstatePeople:(NSString *)estatePeople{
    self.officePeopleLable.text=estatePeople;
    self.officeNameLable.text=estateName;
    self.officeNumberLable.text=estateNumber;
}

@end
