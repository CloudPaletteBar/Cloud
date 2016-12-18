//
//  TaskCell.h
//  CloudPaletteBar
//
//  Created by test on 16/8/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpcomingTasksModel.h"

@interface TaskCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellNumberLable;
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *cellTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *completeLable;

-(void)cell_init:(UpcomingTasksListModel *)upcomingTasksListModel;
@end
