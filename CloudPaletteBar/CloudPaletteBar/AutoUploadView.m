//
//  AutoUploadCell.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import "AutoUploadView.h"

@implementation AutoUploadView

-(void)_init:(BOOL)colesOrOpen Title:(NSString *)title{
    self.autoSwitch.on=colesOrOpen;
    self.titleLable.text=title;
}

- (IBAction)autoClock:(id)sender {
    if (self.Clock) {
        UISwitch *swith=(UISwitch *)sender;
        self.Clock(swith.isOn);
    }
}


@end
