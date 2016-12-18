//
//  BusinessFormsViewController.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BusinessFormsViewController.h"
#import "FormSelectView.h"
#import "Building1ViewController.h"
#import "Building2ViewController.h"
#import "FloorViewController.h"
#import "ShopsViewController.h"


@interface BusinessFormsViewController ()
{
    FormSelectView *formSelectView;
}
@end

@implementation BusinessFormsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self formsView];
    // Do any additional setup after loading the view.
}

-(void)formsView{
    if (formSelectView == nil) {
        NSArray *array=@[@"商业楼盘",@"商业楼栋",@"商业楼层",@"商业商铺"];
        __weak typeof(self)SelfWeek=self;
        self.title=[array objectAtIndex:self.selectIndex];
        formSelectView=[[FormSelectView alloc]initWithFrame:CGRectMake(0, 70, MainScreenWidth, 50)];
        formSelectView.ClockTitle=^(NSInteger index){
            SelfWeek.title=[array objectAtIndex:index];
        };
        formSelectView.tag=100;
        formSelectView.selectIndex=self.selectIndex;
        [self.view addSubview:formSelectView];
        NSMutableArray *lineArray=[NSMutableArray arrayWithObjects:@"no_select_line_Image",@"no_select_line_Image",@"no_select_line_Image",@"", nil];
        NSMutableArray *imageNameArray=[NSMutableArray arrayWithObjects:@"no_select_Image",@"no_select_Image",@"no_select_Image", @"no_select_Image",nil];
        
        [formSelectView addSubVc:[self _InitController] subTitles:@[@"楼盘",@"楼栋",@"楼层",@"商铺"] LineArray:lineArray ImageNameArray:imageNameArray];
    }
}

-(NSArray *)_InitController{
    Building1ViewController *building1ViewController = [[Building1ViewController alloc]init];
    building1ViewController.selectIndex = self.selectIndex;
    Building2ViewController *building2ViewController = [[Building2ViewController alloc]init];
    building2ViewController.selectIndex = self.selectIndex;
    FloorViewController *floorViewController = [[FloorViewController alloc]init];
    floorViewController.selectIndex = self.selectIndex;
    ShopsViewController *shopsViewController = [[ShopsViewController alloc]init];
    shopsViewController.selectIndex = self.selectIndex;
    return @[building1ViewController,building2ViewController,floorViewController,shopsViewController];
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
