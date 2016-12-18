//
//  IndustryFromsViewController.m
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/8/25.
//  Copyright © 2016年 test. All rights reserved.
//

#import "IndustryFromsViewController.h"
#import "FormSelectView.h"
#import "GroundViewController.h"
#import "IndustrialParkViewController.h"
#import "GroundBuilding1ViewController.h"
#import "GroundBuilding2ViewController.h"
#import "GroundBuilding3ViewController.h"
#import "GroundBuilding4ViewController.h"


@interface IndustryFromsViewController ()
{
    FormSelectView *formSelectView;
}
@end

@implementation IndustryFromsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self formsView];
    // Do any additional setup after loading the view.
}

-(void)formsView{
    if (formSelectView == nil) {
        NSArray *array=@[@"工业宗地数据录入",@"工业园数据录入",@"工业楼盘数据录入",@"工业楼栋数据录入",@"工业楼层数据录入",@"工业房屋数据录入"];
        __weak typeof(self)SelfWeek=self;
        self.title=[array objectAtIndex:self.selectIndex];
        formSelectView=[[FormSelectView alloc]initWithFrame:CGRectMake(0, 70, MainScreenWidth, 50)];
        formSelectView.tag=100;
        formSelectView.ClockTitle=^(NSInteger index){
            SelfWeek.title=[array objectAtIndex:index];
        };
        formSelectView.selectIndex=self.selectIndex;
        [self.view addSubview:formSelectView];
        NSMutableArray *lineArray=[NSMutableArray arrayWithObjects:@"no_select_line_Image",@"no_select_line_Image",@"no_select_line_Image", @"no_select_line_Image", @"no_select_line_Image", @"", nil];
        NSMutableArray *imageNameArray=[NSMutableArray arrayWithObjects:@"no_select_Image",@"no_select_Image",@"no_select_Image", @"no_select_Image",@"no_select_Image",@"no_select_Image",nil];
        
        [formSelectView addSubVc:[self _InitController] subTitles:@[@"宗地",@"工业园",@"楼盘",@"楼栋",@"楼层",@"房屋"] LineArray:lineArray ImageNameArray:imageNameArray];
    }
}

-(NSArray *)_InitController{
    GroundViewController *groundVC = [[GroundViewController alloc]init];
    groundVC.selectIndex = self.selectIndex;
    
    IndustrialParkViewController *industrialVC = [[IndustrialParkViewController alloc]init];
    industrialVC.selectIndex = self.selectIndex;
    
    GroundBuilding1ViewController *building1VC = [[GroundBuilding1ViewController alloc]init];
    building1VC.selectIndex = self.selectIndex;
    
    GroundBuilding2ViewController *building2VC = [[GroundBuilding2ViewController alloc]init];
    building2VC.selectIndex = self.selectIndex;
    
    GroundBuilding3ViewController *building3VC = [[GroundBuilding3ViewController alloc]init];
    building3VC.selectIndex = self.selectIndex;
    
    GroundBuilding4ViewController *building4VC = [[GroundBuilding4ViewController alloc]init];
    building4VC.selectIndex = self.selectIndex;
    
    return @[groundVC,industrialVC,building1VC,building2VC,building3VC,building4VC];
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
