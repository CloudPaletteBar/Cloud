//
//  TaskDetailsCell.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/2.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskDetailsModel.h"

@interface TaskDetailsCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UILabel *titleLable;
//@property (weak, nonatomic) IBOutlet UILabel *completeLable;
//@property (weak, nonatomic) IBOutlet UILabel *unfinishedLable;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
-(void)_init:(NSString *)title Cell:(TaskDetailsListModel *)taskDetailsListModel;
@end
