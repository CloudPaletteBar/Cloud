//
//  UploadViewController.m
//  CloudPaletteBar
//
//  Created by test on 16/8/11.
//  Copyright © 2016年 test. All rights reserved.
//

#import "UploadViewController.h"
#import "NetworkManager.h"
#import "FMDB.h"
#import "UpImageModel.h"
#import "UploadCell.h"
#import "SaveImageModel.h"
#import "AppDelegate.h"

@interface UploadViewController (){

    __weak IBOutlet UICollectionView *upCollectionView;
    int page;
    UIAlertView *AlertView;
    NSString *notUpImage;
}
@property(nonatomic,strong)NSMutableArray *upArray;
@end
static NSString *kcellIdentifier = @"collectionCellID";
@implementation UploadViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"wifitongzhi" object:nil];
    self.upArray=[[NSMutableArray alloc]init];
//WithObjects:@"640x960",@"640x960",@"640x960",@"640x960",@"640x960",@"640x960",@"640x960",@"640x960",@"640x960", nil];
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [upCollectionView registerNib:[UINib nibWithNibName:@"UploadCell" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
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
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [upCollectionView reloadData];
            AppDelegate *app=(AppDelegate *)KeyApp;
            if ([app.netStact isEqualToString:@"3G"]) {
                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"3G是否上传" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                alertView.tag=1000;
                [alertView show];
            }
            
            [self netImag:self.upArray];
        });
        
        
    });
   
    
//    UIImage *iage=[UIImage imageNamed:@"640x960"];
//    [NetworkManager ImageRequestAsynchronous:@"servlet/appUploadServlet?makeType=officeLoupan" RequstImage:iage RequseParameter:nil success:^(id response) {
//        NSLog(@"%@",response);
//    } SpeedProgress:^(float Progress) {
//        NSLog(@"%f",Progress);
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
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
////插入
//-(void)saveMessage:(NSString *)messageModel{
//        FMDatabase *database=[[NetworkManager shar]sqliteDataBuse];
//        BOOL res=[database executeUpdate:[NSString stringWithFormat:@"insert into upImage  (ImagePath,userId) values('%@','%@')",]];
//        if (res) {
//            NSLog(@"插入成功");
//        }
//        [[NetworkManager shar]close];
//}

//查询数据库
#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.upArray.count;
    
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    SaveImageModel *saveImageModel=[self.upArray objectAtIndex:indexPath.row];
    UploadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    [cell C_Init:YES ViewTag:indexPath.row+1000 ImageName:saveImageModel.imagePath];
    return cell;
    
}
// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:

////定义每个UICollectionViewCell 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"%f",(screen_width-60)/2);
//    return CGSizeMake((screen_width-(25*2+45*2))/3, (screen_width-(25*2+45*2))/3+26);
//}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 25, 0, 25);//分别为上、左、下、右
}
////返回头headerView的大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    CGSize size={screen_width,(173-128)+128*screen_width_Gap};
//    return size;
//}
////返回头footerView的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    CGSize size={0,0};
//    return size;
//}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
        
}


@end
