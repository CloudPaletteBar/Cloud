//
//  ManualUploadCell.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import "ManualUploadView.h"

@implementation ManualUploadView

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (IBAction)upClock:(id)sender {
    if (self.Clock) {
        self.Clock();
    }
}


@end
