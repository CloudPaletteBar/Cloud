//
//  HomeCell.m
//  CloudPaletteBar
//
//  Created by test on 16/8/11.
//  Copyright © 2016年 test. All rights reserved.
//

#import "HomeCell.h"
#import "CloudPaletteBar.h"

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)_initCell:(NSString *)title ImageName:(NSString *)imageName Number:(NSString *)numbre{
    if ([title isEqualToString:@"我的任务"]) {
        if (![numbre isEqualToString:@"0"]) {
            self.numberLable.hidden=NO;
            self.numberLable.text=numbre;
        }else{
            self.numberLable.hidden=YES;
        }
        
    }else{
        self.numberLable.hidden=YES;
    }
    self.numberLable.layer.masksToBounds = YES;
    self.numberLable.layer.cornerRadius = self.numberLable.frame.size.width/2;
    self.cellLable.text=title;
    self.cellImageView.image=OdeSetImageName(imageName);
}
@end
