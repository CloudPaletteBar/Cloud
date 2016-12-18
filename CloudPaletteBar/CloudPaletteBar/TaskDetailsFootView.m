//
//  TaskDetailsFootView.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import "TaskDetailsFootView.h"

@implementation TaskDetailsFootView
- (IBAction)executeTaskClock:(id)sender {
    if (self.TaskExecuteTask) {
        self.TaskExecuteTask();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
