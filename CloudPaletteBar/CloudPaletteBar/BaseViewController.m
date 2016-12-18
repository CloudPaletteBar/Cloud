//
//  BaseViewController.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/8.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BaseViewController.h"
#import "CloudPaletteBar.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //自定义返回按钮
//    UIImage *backButtonImage = [[UIImage imageNamed:@"icon_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 33, 0, 0)];
////    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackgroundImage:backButtonImage forState:UIControlStateNormal style:UIBarButtonItemStylePlain barMetrics:UIBarMetricsDefault];
//    //将返回按钮的文字position设置不在屏幕上显示
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:OdeSetImageName(@"icon_back") style:UIBarButtonItemStylePlain target:self action:@selector(blackVC)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:OdeSetImageName(@"home_Image") style:UIBarButtonItemStylePlain target:self action:@selector(backHome)];
}

-(void)backHome{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)blackVC{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString *)replaceString:(NSString *)string
{
    if (![string isKindOfClass:[NSNull class]] && ![string isEqualToString:@"(null)"] && ![string isEqualToString:@"<null>"] && string != nil) {
        return string;
    }
    return @"";
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
