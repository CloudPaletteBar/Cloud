//
//  OrdinaryFormViewController.m
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "OrdinaryFormViewController.h"
#import "FormSelectView.h"
#import "CloudPaletteBar.h"
#import "OrdinaryEstateViewController.h"
#import "OrdinaryBanViewController.h"
#import "OrdinaryHouseViewController.h"

@interface OrdinaryFormViewController ()

@end

@implementation OrdinaryFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initUI];
}
-(void)_initUI{
    NSArray *array=@[@"普通住宅楼盘数据录入",@"普通住宅楼栋数据录入",@"普通住宅房屋数据录入"];
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
    OrdinaryEstateViewController *ordinaryEstateViewController=[[OrdinaryEstateViewController alloc]init];
    ordinaryEstateViewController.estateID=self.formID;
    ordinaryEstateViewController.selectSee=self.selectSee;
    ordinaryEstateViewController.selectIndex=self.selectIndex;
    OrdinaryBanViewController *ordinaryBanViewController=[[OrdinaryBanViewController alloc]init];
    ordinaryBanViewController.estateID=self.formID;
    ordinaryBanViewController.selectSee=self.selectSee;
     ordinaryBanViewController.selectIndex=self.selectIndex;
    OrdinaryHouseViewController *ordinaryHouseViewController=[[OrdinaryHouseViewController alloc]init];
    ordinaryHouseViewController.estateID=self.formID;
    ordinaryHouseViewController.selectSee=self.selectSee;
    ordinaryHouseViewController.selectIndex=self.selectIndex;
    return @[ordinaryEstateViewController,ordinaryBanViewController,ordinaryHouseViewController];
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
