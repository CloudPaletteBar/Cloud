//
//  HelpViewController.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *helpWebView;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.helpWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@help.jsp",SERVER_URL]]]];
    NSLog(@"%@",[NSString stringWithFormat:@"%@help.jsp",SERVER_URL]);
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
