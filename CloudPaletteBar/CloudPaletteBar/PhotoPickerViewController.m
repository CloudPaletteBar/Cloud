//
//  PhotoPickerViewController.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/28.
//  Copyright © 2016年 test. All rights reserved.
//

#import "PhotoPickerViewController.h"
#import "CloudPaletteBar.h"
#import "NetworkManager.h"
#import "FMDB.h"
#import "UpImageModel.h"
#import "BaseView.h"
#import "AppDelegate.h"


@interface PhotoPickerViewController ()<LQPhotoPickerViewDelegate>{
    UIAlertView *AlertView;
    NSString *notUpImage;
    NSArray *IDs;
}

@end

@implementation PhotoPickerViewController

- (void)viewDidLoad {
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"wifitongzhi" object:nil];
    self.view.backgroundColor=[UIColor whiteColor];
    [super viewDidLoad];
    _scrollView=[[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview: _scrollView];
    /**
     *  依次设置
     */
    self.LQPhotoPicker_superView = _scrollView;
    
    self.LQPhotoPicker_imgMaxCount = 5-self.Arraycount;
    
    [self LQPhotoPicker_initPickerView];
    
    self.LQPhotoPicker_delegate = self;
    [self updateViewsFrame];

    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(backHome)];
}

-(void)backHome{
    [self submitToServer];
    
}


- (void)tongzhi:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"wifi"]);
    if ([text.userInfo[@"wifi"] isEqualToString:@"3G"]) {
            NSString *str=[NSString stringWithFormat:@"%@是否上传",text.userInfo[@"wifi"]];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag=10000;
            [alertView show];
        }
    NSLog(@"－－－－－接收到通知------");
    
}





- (void)updateViewsFrame{
    
    
    //photoPicker
    [self LQPhotoPicker_updatePickerViewFrameY:0];
    
}

#pragma mark - 上传数据到服务器前将图片转data（上传服务器用form表单：未写）
- (void)submitToServer{
    if ([[self LQPhotoPicker_getALAssetArray]count]==0) {
        [BaseView _init:@"请选择图片" View:self.view];
        return;
    }
    NSMutableArray *lay=[self LQPhotoPicker_getALAssetArray];
    NSMutableArray *bigImageArray = [self LQPhotoPicker_getBigImageArray];
    //大图数据
    NSMutableArray *bigImageDataArray = [self LQPhotoPicker_getBigImageDataArray];
    
    //小图数组
    NSMutableArray *smallImageArray = [self LQPhotoPicker_getSmallImageArray];
    
    //小图数据
    NSMutableArray *smallImageDataArray = [self LQPhotoPicker_getSmallDataImageArray];
    if (self.ClockPhon) {
        self.ClockPhon(@[lay,bigImageArray,bigImageDataArray,smallImageArray,smallImageDataArray]);
    }
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"保存中..."];
    [self _initDB:bigImageDataArray];
    
}

-(void)_initDB:(NSArray *)imageArray{
    NSMutableArray *array;
    if (array==nil) {
          array=[[NSMutableArray alloc]init];
    }
    NSLog(@"%d",imageArray.count);
    for (int i=0; i<imageArray.count; i++) {
       
        UIImage *image =  [UIImage imageWithData:[imageArray objectAtIndex:i]];
        [[NetworkManager shar] savaIamge:image OrderType:self.orderType ArrayIDS:array ImageType:self.imageType NameImage:i success:^(NSMutableArray *arryaIDs) {
            IDs=arryaIDs;
            AppDelegate *app=(AppDelegate *) KeyApp;
            if ([app.netStact isEqualToString:@"3G"]) {
                if (AlertView==nil) {
                    AlertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"非wifi是否上传图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [AlertView show];
                }
            }else{
                if (i==imageArray.count-1) {
                    NSLog(@"%@",[IDs componentsJoinedByString:@","]);
                    [self netImag:[IDs componentsJoinedByString:@","]];
                }
                
            }

        }];
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    {
        if (alertView.tag==10000) {
            if (buttonIndex==1) {
                notUpImage=@"no";
                
            }
            
        }else{
            if (buttonIndex==1) {
                [self netImag:[IDs componentsJoinedByString:@","]];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
}

-(void)netImag:(NSString *)imageName{
    __weak typeof(self)selfWeek=self;
    
    [[NetworkManager shar] selectDataMessage:imageName success:^(NSArray *arrays) {
        [arrays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([notUpImage isEqualToString: @"no"]) {
                return ;
            }
            NSLog(@"%@",obj);
            SaveImageModel *saveImageModel=(SaveImageModel *)obj;
            NSLog(@"%@",saveImageModel.imagePath);
            UIImage *image=[UIImage imageWithContentsOfFile:saveImageModel.imagePath];
            NSString *url=[NSString stringWithFormat:@"servlet/appUploadServlet?makeType=%@",self.orderType];
            if (self.stakID) {
                url=[NSString stringWithFormat:@"servlet/appUploadServlet?makeType=%@&taskId=%@",self.orderType,self.stakID];
            }
            if (self.ID) {
                url=[NSString stringWithFormat:@"%@&ID=%@",url,self.ID];
            }
            NSLog(@"%@",url);
            [NetworkManager ImageRequestAsynchronous:url RequstImage:image Cname:self.imageType RequseParameter:nil success:^(id response) {
                NSLog(@"%@",response);
                UpImageModel *upImageModel=[[UpImageModel alloc]initWithDictionary:response error:nil];
                if (upImageModel) {
                    if ([upImageModel.status isEqualToString:@"1"]) {
                        [ [self LQPhotoPicker_smallImageArray] replaceObjectAtIndex: self.Arraycount+idx withObject: upImageModel.path];
                        [self updata:saveImageModel.imagePath];
                        if (([self LQPhotoPicker_getSmallImageArray].count-self.Arraycount-1)==idx) {
                            [[BaseView baseShar]dissMiss];
                            if (self.ClockSave) {
                                self.ClockSave(IDs,[NetworkManager Datastrings:[self LQPhotoPicker_smallImageArray]]);
                                [selfWeek.navigationController popViewControllerAnimated:YES];
                            }
                            
                        }
                    }else{
                        
                    }
                }else{
                    
                }
            } SpeedProgress:^(float Progress) {
                
                NSLog(@"%f",Progress);
                
            } failure:^(NSError *error) {
                [[BaseView baseShar]dissMiss];
                *stop = YES;
                NSLog(@"%@",error);
            }];
            
            *stop = NO;
        }];
        
        
        
    }];
}

-(void)updata:(NSString *)path{
    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        FMDatabase * db;
        if (!db) {
            db=[[NetworkManager shar] sqliteDataBuse];
        }
        BOOL res=[db executeUpdate:[NSString stringWithFormat:@"update upImage set imageState='1' where ImagePath='%@' ",path]];
        NSLog(@"%@",[NSString stringWithFormat:@"update upImage set imageState='1' where ImagePath='%@' ",path]);
        if (!res) {
            NSLog(@"更新失败");
        } else {
            NSLog(@"更新成功");
        }
//        [[NetworkManager shar] close];
    });
    
    
}


- (void)LQPhotoPicker_pickerViewFrameChanged{
    [self updateViewsFrame];
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
