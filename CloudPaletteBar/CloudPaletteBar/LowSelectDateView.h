//
//  LowSelectDateView.h
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LowSelectDateView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *selectDateLable;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;


-(void)_init:(NSString *)title InPutView:(UIView *)inputView;
@end
