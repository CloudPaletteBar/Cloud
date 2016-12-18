//
//  AutoUploadCell.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoUploadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UISwitch *autoSwitch;
-(void)_init:(BOOL)colesOrOpen Title:(NSString *)title;

@property(nonatomic,copy)void (^ Clock)(BOOL OpenOrClose);
@end
