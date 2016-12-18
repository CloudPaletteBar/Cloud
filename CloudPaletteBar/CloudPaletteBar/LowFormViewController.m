//
//  LowFormViewController.m
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "LowFormViewController.h"
#import "FormSelectView.h"
#import "CloudPaletteBar.h"
#import "LowEstateViewController.h"
#import "LowBanViewController.h"
#import "LowHouseViewController.h"

@interface LowFormViewController ()

@end

@implementation LowFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initUI];
}

-(void)_initUI{
    NSArray *array=@[@"低密度住宅楼盘数据录入",@"低密度住宅楼栋数据录入",@"低密度住宅房屋数据录入"];
    __weak typeof(self)SelfWeek=self;
    self.title=[array objectAtIndex:self.selectIndex];
    FormSelectView *formSelectView=[[FormSelectView alloc]initWithFrame:CGRectMake(0, 64, screen_width, 50)];
    formSelectView.ClockTitle=^(NSInteger index){
        SelfWeek.title=[array objectAtIndex:index];
    };
    formSelectView.tag=100;
    formSelectView.selectIndex=self.selectIndex;
    [self.view addSubview:formSelectView];
    NSMutableArray *lineArray=[NSMutableArray arrayWithObjects:@"no_select_line_Image",@"no_select_line_Image",@"", nil];
    NSMutableArray *imageNameArray=[NSMutableArray arrayWithObjects:@"no_select_Image",@"no_select_Image",@"no_select_Image", nil];
    
    [formSelectView addSubVc:[self _InitController] subTitles:@[@"楼盘",@"楼栋",@"房屋"] LineArray:lineArray ImageNameArray:imageNameArray];
}

-(NSArray *)_InitController{
    NSLog(@"%d",self.selectIndex);
    LowEstateViewController *lowEstateViewController=[[LowEstateViewController alloc]init];
    lowEstateViewController.estateID=self.formID;
    lowEstateViewController.selectSee=self.selectSee;
    lowEstateViewController.selectIndex=self.selectIndex;
    LowBanViewController *lowBanViewController=[[LowBanViewController alloc]init];
    lowBanViewController.estateID=self.formID;
    lowBanViewController.selectSee=self.selectSee;
    lowBanViewController.selectIndex=self.selectIndex;
    LowHouseViewController *lowHouseViewController=[[LowHouseViewController alloc]init];
    lowHouseViewController.estateID=self.formID;
    lowHouseViewController.selectSee=self.selectSee;
    lowHouseViewController.selectIndex=self.selectIndex;
    return @[lowEstateViewController,lowBanViewController,lowHouseViewController];
}

-(void)blackVC{
    if (self.BlackVC) {
        self.BlackVC();
    }
    [self.navigationController popViewControllerAnimated:YES];
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
