//
//  OfficeQuestionnaireCell.h
//  CloudPaletteBar
//
//  Created by test on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfficeQuestionnaireCell : UITableViewCell
@property(nonatomic,copy)void (^ CellSeeClock)();
@property(nonatomic,copy)void (^ CellEditClock)();
@property(nonatomic,copy)void (^ CellDeleteClock)();
@property(nonatomic,copy)void (^ CellBanClock)();
@property(nonatomic,copy)void (^ CellHouseClock)();
@end
