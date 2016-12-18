//
//  LowInvestigationView.h
//  CloudPaletteBar
//
//  Created by test on 16/8/25.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LowInvestigationView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UISwitch *titleSwitch;

@property(nonatomic,copy)void (^ Clock)(BOOL open);

-(void)_init:(NSString *)title OpenClose:(BOOL)openClose;
@end
