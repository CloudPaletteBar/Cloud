//
//  ForgetPSWViewController.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/29.
//  Copyright © 2016年 test. All rights reserved.
//

#import "ForgetPSWViewController.h"
#import "CloudPaletteBar.h"

@interface ForgetPSWViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *pswWebView;

@end

@implementation ForgetPSWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=nil;
    [self.pswWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getUserPwd.jsp",SERVER_URL]]]];
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
