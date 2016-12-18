//
//  LowEstateCell.h
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LowEstateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *cellTextField;
@property (weak, nonatomic) IBOutlet UILabel *cellLable;
-(void)_cellInit:(NSString *)title Weather:(NSString *)weather;
@end
