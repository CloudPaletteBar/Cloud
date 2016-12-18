//
//  ViewCell.m
//  demo
//
//  Created by liu_yakai on 16/10/11.
//  Copyright © 2016年 liu_yakai. All rights reserved.
//

#import "ViewCell.h"

@implementation ViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)delectClock:(id)sender {
    UIButton *button=(UIButton *)sender;
    if (self.Clock) {
        self.Clock(button.tag);
    }
}

@end
