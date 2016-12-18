//
//  SettingViewController.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/10.
//  Copyright © 2016年 test. All rights reserved.
//

#import "SettingViewController.h"
#import "NetworkManager.h"
#import "SettingCell.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "BaseView.h"
#import "OutModel.h"

@interface SettingViewController ()<UIActionSheetDelegate>

@end

static NSString *Identifier=@"Identifier";

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseArray=[[NSMutableArray alloc]initWithArray:[NetworkManager _readInit:@"SettingPlish"]];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:nil] forCellReuseIdentifier:Identifier];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 80;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section==1) {
//        return 0;
//    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.baseArray objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.baseArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    UITableView *cell=[super tableView:tableView cellForRowAtIndexPath:indexPath];
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    [cell _initCell:[[self.baseArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    if (indexPath.section==0) {
        if (indexPath.row==0&&[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]) {
            cell.cellLable.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
        }
    }
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (indexPath.section==0) {
        return;
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UINavigationController *nav=[storyboard instantiateViewControllerWithIdentifier:@"LoginVController"];
////        登陆成功要清空标示
//        [[NSUserDefaults standardUserDefaults]setObject:@"取消" forKey:@"diss"];
//        
//        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }else{
//        if (indexPath.row==0) {
//            [self performSegueWithIdentifier:@"PswVC" sender:nil];
//        }else
            if (indexPath.row==0){
            [self performSegueWithIdentifier:@"UploadSettings" sender:nil];
        }else if (indexPath.row==1){
            [self performSegueWithIdentifier:@"HelpVC" sender:nil];
        }else{
            UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出账号" otherButtonTitles:nil, nil];
            [actionSheet showInView:self.view];
        }
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self outUser];
    }
}

-(void)outUser{
    
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"退出中..."];
    [NetworkManager requestWithMethod:@"POST" bodyParameter:@{} relativePath:@"appAction!appLogout.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        OutModel *outModel=[[OutModel alloc]initWithDictionary:responseObject error:nil];
        if (outModel) {
            if ([outModel.status isEqualToString:@"1"]) {
                                [SelfWeek outNet];
                
            }else{
                [SelfWeek _initTitle:outModel.message];
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


-(void)outNet{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:@"WiFiopen"];
    [user removeObjectForKey:@"open"];
    [user removeObjectForKey:@"diss"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nav=[storyboard instantiateViewControllerWithIdentifier:@"LoginVController"];
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    appdelegate.window.rootViewController=nav;
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
