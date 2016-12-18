//
//  FormInPutView.h
//  CloudPaletteBar
//
//  Created by test on 16/8/16.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormInPutView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *formTitleLable;
@property (weak, nonatomic) IBOutlet UITextField *formTextField;

-(void)_init:(NSString *)title WaterMark:(NSString *)waterMark;
@end
