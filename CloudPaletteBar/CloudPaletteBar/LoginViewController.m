//
//  LoginViewController.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/10.
//  Copyright © 2016年 test. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "CloudPaletteBar.h"
#import "BaseView.h"
#import "NetworkManager.h"
#import "LoginModel.h"


@interface LoginViewController (){
    LoginModel *loginModel;
}
//用户名
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
//密码
@property (weak, nonatomic) IBOutlet UITextField *pswTextField;

//验证码
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;

@property (weak, nonatomic) IBOutlet UISwitch *rememberSwitch;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"userName"]) {
        self.userNameTextField.text=[user objectForKey:@"userName"];
        self.pswTextField.text=[user objectForKey:@"psw"];
    }
    self.navigationItem.titleView=[[UIImageView alloc]initWithImage:OdeSetImageName(@"navi_titile_Image")];
    [self netCode];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"diss"]) {
         self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dissVC)];
    }
//    禁止按钮高亮
    [self.codeButton setAdjustsImageWhenHighlighted:NO];

}

-(void)dissVC{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

//更换验证码
- (IBAction)codeClock:(id)sender {
    [self netCode];
}

-(void)netCode{
    [self.codeButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getValidate.chtml?name=appValidate&date=%@",SERVER_URL,[NetworkManager timeStr]]] forState:UIControlStateNormal];
    NSLog(@"%@",[NSString stringWithFormat:@"%@getValidate.chtml?name=appValidate&date=%@",SERVER_URL,[NetworkManager timeStr]]);
}

//记住账号
- (IBAction)RememberClock:(id)sender {
    [self _YesOrNo];
}

//忘记密码
- (IBAction)noPswClock:(id)sender {
    NSLog(@"忘记密码");
    [self performSegueWithIdentifier:@"ForgetPSW" sender:nil];
}

//登录
- (IBAction)loginClock:(id)sender {
    [self _YesOrNo];
   }

-(void)_YesOrNo{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    if (self.rememberSwitch.on) {
        
        [user setObject:self.userNameTextField.text forKey:@"userName"];
        [user setObject:self.pswTextField.text forKey:@"psw"];
    }else{
        [user removeObjectForKey:@"userName"];
        [user removeObjectForKey:@"psw"];
    }
    [self.view endEditing:YES];
    [self login];
    
}


-(void)pushHomeVC{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"diss"];
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeViewController *homeViewController=[storyboard instantiateViewControllerWithIdentifier:@"HomeView"];
//    homeViewController.homes=loginModel.role;
    appDelegate.window.rootViewController=homeViewController;
}

-(void)login{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];;
    if (self.userNameTextField.text.length==0) {
        [self _initTitle:USERNAME];
    }else if (self.pswTextField.text.length==0){
        [self _initTitle:PSWORD];
    }else if (self.codeTextField.text.length==0){
        [self _initTitle:CODEV];
    } else{
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"IOSdeviceToken"]!=NULL){
            [dic setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"IOSdeviceToken"] forKey:@"token"];
        }
        [dic setObject:self.userNameTextField.text forKey:@"username"];
        [dic setObject:self.pswTextField.text forKey:@"password"];
        [dic setObject:self.codeTextField.text forKey:@"validate"];
        [self netLogin:dic];
    }
    
//    [self pushHomeVC];
}

-(void)netLogin:(NSDictionary *)dic{
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"登录中..."];
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appAction!appLogin.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        loginModel=[[LoginModel alloc]initWithDictionary:responseObject error:nil];
        if (loginModel) {
            if ([loginModel.message isEqualToString:@"登陆成功！"]) {
                [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"homes"];
//                修改cooke
                NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                NSArray *cookies = [NSArray arrayWithArray:[cookieJar cookies]];
                for (NSHTTPCookie *cookie in cookies)
                {
                    //从cookies中获取sessionid并保存.
                        NSDictionary *cookieProperties = [[NSMutableDictionary alloc]init];
                        
                        [cookieProperties setValue:[responseObject valueForKey:@"token"] forKey:NSHTTPCookieValue];
                    [cookieProperties setValue:@"token"  forKey:NSHTTPCookieName];
                        [cookieProperties setValue:@"m.thirtydevs.com" forKey:NSHTTPCookieDomain];
                        //没有增加新cookie也许是由于没有把NSHTTPCookieExpires和NSHTTPCookiePath设置好.
//                    NSLog(@"%@",[responseObject valueForKey:@"token"]);
//                        [cookieProperties setValue:[responseObject valueForKey:@"token"] forKey:NSHTTPCookieExpires];
                        [cookieProperties setValue:[cookie path] forKey:NSHTTPCookiePath];
                        
                        NSHTTPCookie *ncookie = [[NSHTTPCookie alloc] initWithProperties:cookieProperties];
                        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:ncookie];  
                }
                NSLog(@"2:%@",[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]);
//                NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                NSArray *cookies1 = [NSArray arrayWithArray:[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
//                //            NSLog(@"%@",cookies);
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies1];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"sessionCookies"];
                
                
                
                [SelfWeek pushHomeVC];
                
            }else{
                [SelfWeek _initTitle:loginModel.message];
            }
        }else{
            [SelfWeek _initTitle:@"亲你的网络不给力哦"];
        }
        [[BaseView baseShar]dissMiss];
    } failure:^(NSError *error) {
        [[BaseView baseShar]dissMiss];
         NSLog(@"%@",error.userInfo);
        [SelfWeek _initTitle:@"亲网络异常请稍后"];
    }];
}

-(void)_initTitle:(NSString *)title{
    [BaseView _init:title View:self.view];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
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
