//
//  AppDelegate.m
//  CloudPaletteBar
//
//  Created by test on 16/8/8.
//  Copyright © 2016年 test. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "BaseView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


//数据库拷贝到本地


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginVCCC) name:@"loginVCCC" object:nil];
    //监听网络
    [self monitoringNetwork];
    [self push:application];
    return YES;
}

-(void)loginVCCC{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"diss"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *login=[storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
    [BaseView _init:@"登录已过期请重新登录" View:self.window];
        self.window.rootViewController=login;
}

-(void)push:(UIApplication *)application{
    application.applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        // 1.注册UserNotification,以获取推送通知的权限
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil];
        [application registerUserNotificationSettings:settings];
        
        // 2.注册远程推送
        [application registerForRemoteNotifications];
    } else {
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeNewsstandContentAvailability | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    }
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // <32e7cf5f 8af9a8d4 2a3aaa76 7f3e9f8e 1f7ea8ff 39f50a2a e383528d 7ee9a4ea>
    // <32e7cf5f 8af9a8d4 2a3aaa76 7f3e9f8e 1f7ea8ff 39f50a2a e383528d 7ee9a4ea>
    NSLog(@"%@", deviceToken.description);
    NSString *trimmedString = [deviceToken.description stringByReplacingOccurrencesOfString:@"<" withString:@""];
    NSString *iosdeviceToken = [trimmedString stringByReplacingOccurrencesOfString:@">" withString:@""];
    NSString *strToken=[iosdeviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",strToken);
    [[NSUserDefaults standardUserDefaults]setObject:strToken forKey:@"IOSdeviceToken"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //监听网络
    [self monitoringNetwork];
}
-(void)monitoringNetwork
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //设置监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"不可达的网络(未连接)");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G,3G,4G...的网络");
                self.netStact=@"3G";
                [self _init:@"3G"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi的网络");
//                self.netStact=@"wifi";
//                [self _init:@"wifi"];
                break;
            default:
                break;
        }
    }];
    //开始监听
    [manager startMonitoring];
}

-(void)_init:(NSString *)title{
    //添加 字典，将label的值通过key值设置传递
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:title,@"wifi", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"wifitongzhi" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
