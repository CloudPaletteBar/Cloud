//
//  MyViewController.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/10.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MyViewController.h"
#import "SegmentMenuVc.h"
#import "CloudPaletteBar.h"
#import "FishTaskViewController.h"
#import "AllTasksViewController.h"
#import "UpcomingTasksViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SegmentMenuVc *segmentMenuVc=[[SegmentMenuVc alloc]initWithFrame:CGRectMake(0, 64, screen_width, 40)];
    segmentMenuVc.selectIndex=0;
    [self.view addSubview:segmentMenuVc];
    [segmentMenuVc addSubVc:[self _InitController] subTitles:@[@"待办任务",@"全部任务",@"已办任务"]];
    
    
}

-(NSArray *)_InitController{
    FishTaskViewController *fishTaskViewController=[[FishTaskViewController alloc]init];
    AllTasksViewController *allTasksViewController=[[AllTasksViewController alloc]init];
    UpcomingTasksViewController *upcomingTasksViewController=[[UpcomingTasksViewController alloc]init];
    return @[upcomingTasksViewController,allTasksViewController,fishTaskViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
