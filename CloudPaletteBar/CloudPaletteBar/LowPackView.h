//
//  LowPackView.h
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LowPackView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
-(void)_init:(NSString *)title Weather:(NSString *)weather InPutView:(UIView *)inPutView;
@end
