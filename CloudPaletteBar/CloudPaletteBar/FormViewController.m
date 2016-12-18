//
//  FormViewController.m
//  CloudPaletteBar
//
//  Created by test on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "FormViewController.h"
#import "FormSelectView.h"
#import "CloudPaletteBar.h"
#import "OfficeBanViewController.h"
#import "OfficeEstateViewController.h"
#import "OfficeHouseViewController.h"

@interface FormViewController ()

@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array=@[@"办公楼盘数据录入",@"办公楼栋数据录入",@"办公房屋数据录入"];
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
    OfficeEstateViewController *officeEstateViewController=[[OfficeEstateViewController alloc]init];
    officeEstateViewController.estateID=self.formID;
    officeEstateViewController.selectSee=self.selectSee;
    officeEstateViewController.selectIndex=self.selectIndex;
    OfficeBanViewController *officeBanViewController=[[OfficeBanViewController alloc]init];
    officeBanViewController.estateID=self.formID;
    officeBanViewController.selectSee=self.selectSee;
    officeBanViewController.selectIndex=self.selectIndex;
    OfficeHouseViewController *officeHouseViewController=[[OfficeHouseViewController alloc]init];
    officeHouseViewController.estateID=self.formID;
    officeHouseViewController.selectSee=self.selectSee;
    officeHouseViewController.selectIndex=self.selectIndex;
    return @[officeEstateViewController,officeBanViewController,officeHouseViewController];
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
