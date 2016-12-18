//
//  UploadSettingsViewController.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import "UploadSettingsViewController.h"
#import "AutoUploadView.h"
#import "ManualUploadView.h"
#import "CloudPaletteBar.h"
#import "AppDelegate.h"
#import "UpImageModel.h"

#define ViewHeght 78

@interface UploadSettingsViewController ()
{
    UIAlertView *AlertView;
    NSString *notUpImage;
}
@property(nonatomic,strong)NSMutableArray *upArray;
@end

@implementation UploadSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UploadSettingsUI];
    self.upArray=[[NSMutableArray alloc]init];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"wifitongzhi" object:nil];
    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        
        FMDatabase *database=[[NetworkManager shar]sqliteDataBuse];
        FMResultSet *sql=[database executeQuery:@"select * from upImage where imageState=0"];
        while ([sql next]) {
            SaveImageModel *saveImageModel=[[SaveImageModel alloc]init];
            saveImageModel.imagePath= [sql stringForColumn:@"ImagePath"];
            saveImageModel.tackId= [sql stringForColumn:@"tackId"];
            saveImageModel.imageType= [sql stringForColumn:@"ImageType"];
            saveImageModel.imageState= [sql stringForColumn:@"imageState"];
            saveImageModel.imageName= [sql stringForColumn:@"imageName"];
            saveImageModel.orderType= [sql stringForColumn:@"orderType"];
            saveImageModel.ID= [sql stringForColumn:@"ID"];
            if (![saveImageModel.ID isEqualToString:@"(null)"]) {
                [self.upArray addObject:saveImageModel];
            }

            
        }
        [[NetworkManager shar]close];
    });

}

-(void)UploadSettingsUI{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    
    AutoUploadView *autoUploadView=[self _Ainit:@"3G/4G网络自动上传" CloseOrOpen:[[user objectForKey:@"open"]boolValue] ViewY:74];
    autoUploadView.Clock=^(BOOL OpenOrClose){
        [user setObject:[NSNumber numberWithBool:OpenOrClose] forKey:@"open"];
    };
    BOOL open;
    if ([user objectForKey:@"WiFiopen"]) {
        open =[[user objectForKey:@"WiFiopen"]boolValue];
    }else{
        open=YES;
    }
    AutoUploadView *autoUploadView1=[self _Ainit:@"连接WiFi自动上传" CloseOrOpen:open ViewY:ViewHeght+74];
    autoUploadView1.Clock=^(BOOL OpenOrClose){
        [user setObject:[NSNumber numberWithBool:OpenOrClose] forKey:@"WiFiopen"];
    };
    ManualUploadView *manualUploadView=[[[NSBundle mainBundle]loadNibNamed:@"ManualUploadView" owner:self options:nil]lastObject];
    manualUploadView.Clock=^(){
        AppDelegate *app=(AppDelegate *)KeyApp;
        if ([app.netStact isEqualToString:@"3G"]) {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"3G是否上传" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alertView.tag=1000;
            [alertView show];
        }else{
            [self netImag:self.upArray];
        }
        
    };
    manualUploadView.frame=CGRectMake(0, ViewHeght*2+74, screen_width, 86);
    [self.view addSubview:manualUploadView];
}

-(AutoUploadView *)_Ainit:(NSString *)title CloseOrOpen:(BOOL)closeOrOpen ViewY:(CGFloat)viewY{
    AutoUploadView *autoUploadView=[[[NSBundle mainBundle]loadNibNamed:@"AutoUploadView" owner:self options:nil]lastObject];
    [autoUploadView _init:closeOrOpen Title:title];
    autoUploadView.frame=CGRectMake(0, viewY, screen_width, ViewHeght);
    [self.view addSubview:autoUploadView];
    return autoUploadView;
}

-(void)netImag:(NSArray *)imageName{
    [imageName enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([notUpImage isEqualToString: @"no"]) {
            return ;
        }
        NSLog(@"%@",obj);
        SaveImageModel *saveImageModel=(SaveImageModel *)obj;
        NSString* url=[NSString stringWithFormat:@"%@servlet/appUploadServlet?makeType=%@&taskId=%@",SERVER_URL,saveImageModel.orderType,saveImageModel.tackId];
        UIImage *image=[UIImage imageWithContentsOfFile:saveImageModel.imagePath];
        [NetworkManager ImageRequestAsynchronous:url RequstImage:image Cname:saveImageModel.imageType RequseParameter:nil success:^(id response) {
            *stop = YES;
            NSLog(@"%@",response);
            UpImageModel *upImageModel=[[UpImageModel alloc]initWithDictionary:response error:nil];
            if (upImageModel) {
                if ([upImageModel.status isEqualToString:@"1"]) {
                    UIActivityIndicatorView* cellactiView=[self.view viewWithTag:1000+idx];
                    [cellactiView stopAnimating];
                    cellactiView.hidden=YES;
                    [self updata:saveImageModel.imagePath];
                }
                
            }else{
                
            }
            
        } SpeedProgress:^(float Progress) {
            
            NSLog(@"%f",Progress);
            
        } failure:^(NSError *error) {
            *stop = YES;
            NSLog(@"%@",error);
        }];
        
        *stop = NO;
    }];
    
    
    
}

-(void)updata:(NSString *)path{
    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        FMResultSet *s=[[[NetworkManager shar] sqliteDataBuse] executeQuery:[NSString stringWithFormat:@"update upImage set imageState='1' where ImagePath='%@' ",path]];
        NSLog(@"%@",[NSString stringWithFormat:@"update upImage set imageState='1' where ImagePath='%@' ",path]);
        if (!s) {
            NSLog(@"更新失败");
        } else {
            NSLog(@"更新成功");
        }
        [[NetworkManager shar] close];
    });
    
    
}








- (void)tongzhi:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"wifi"]);
    if ([text.userInfo[@"wifi"] isEqualToString:@"3G"]&&self.upArray.count>0) {
        if (!AlertView) {
            NSString *str=[NSString stringWithFormat:@"%@是否上传",text.userInfo[@"wifi"]];
            AlertView=[[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [AlertView show];
        }
    }
    NSLog(@"－－－－－接收到通知------");
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    {
        if (alertView.tag==10000) {
            if (buttonIndex==1) {
                notUpImage=@"no";
            }
        }else{
            if (buttonIndex==1) {
                [self netImag:self.upArray];
            }
        }
        
    }
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
