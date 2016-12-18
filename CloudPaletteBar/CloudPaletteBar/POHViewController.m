//
//  POHViewController.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/10/11.
//  Copyright © 2016年 test. All rights reserved.
//

#import "POHViewController.h"
#import "ViewCell.h"
#import "UIImageView+WebCache.h"
#import "CloudPaletteBar.h"
#import "BaseView.h"
#import "NetworkManager.h"
#import "AppDelegate.h"
#import "UpImageModel.h"
#import "DeleateImageModel.h"
#import "MacroDefinition.h"

static NSString *kcellIdentifier = @"collectionCellID";

@interface POHViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
    UIImageView *imageView;
    NSMutableArray *IDs;
    NSMutableArray *aray;
    UIAlertView *AlertView;
    NSString *notUpImage;
    NSInteger selectIndex;
    
    __block NSInteger count;
    NSInteger countInt;
    NSMutableArray *arrayImage;
    
    UIButton *rightBtn;
    UIButton *bgBtn;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collection;


@end

@implementation POHViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collection reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    notUpImage=@"yes";
    selectIndex = 0;
    countInt = 0;
    IDs=[[NSMutableArray alloc]init];
    imageView=[[UIImageView alloc]init];
    aray=[[NSMutableArray alloc]init];
    arrayImage = [NSMutableArray arrayWithCapacity:1];
    //    self.PHOarray = [NSMutableArray arrayWithCapacity:1];
    imageView.frame=self.view.frame;
    imageView.center=self.view.center;
    imageView.hidden=YES;
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.userInteractionEnabled=YES;
    imageView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:imageView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [imageView addGestureRecognizer:tapGesture];
    
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self.collection registerNib:[UINib nibWithNibName:@"ViewCell" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
    self.collection.delegate=self;
    self.collection.dataSource=self;
    
    bgBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    bgBtn.frame = MainScreenBounds;
    bgBtn.backgroundColor = [UIColor clearColor];
    bgBtn.hidden = YES;
    [self.navigationController.view addSubview:bgBtn];
    
    if (![self.type isEqualToString:@"查看"]){
        rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 60, 30);
        [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [rightBtn setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    }
}

-(void)backHome{
    [self submitToServer];
}
#pragma mark - 上传数据到服务器前将图片转data（上传服务器用form表单：未写）
- (void)submitToServer{
    if (self.PHOarray.count==0) {
        [BaseView _init:@"请选择图片" View:self.view];
        return;
    }
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"保存中..."];
    [self _initDB:self.PHOarray];
}


-(void)_initDB:(NSArray *)imageArray{
    for (int i=0; i<imageArray.count; i++) {
        if (![[imageArray objectAtIndex:i]isKindOfClass:[NSString class]]) {
            countInt ++;
            bgBtn.hidden = NO;
        }
    }
    for (int i=0; i<imageArray.count; i++) {
        if (![[imageArray objectAtIndex:i]isKindOfClass:[NSString class]]) {
            UIImage *image =  [imageArray objectAtIndex:i];
            [[NetworkManager shar] savaIamge:image OrderType:self.orderType ArrayIDS:aray ImageType:self.imageType NameImage:i success:^(NSMutableArray *arryaIDs) {
                IDs=arryaIDs;
                AppDelegate *app=(AppDelegate *) KeyApp;
                if ([app.netStact isEqualToString:@"3G"]) {
                    if (AlertView==nil) {
                        AlertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"非wifi是否上传图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                        [AlertView show];
                    }
                }else{
                    NSLog(@"%@",[IDs componentsJoinedByString:@","]);
                    [self netImag:[IDs componentsJoinedByString:@","]];
                }
            }];
        }
    }
    [self shangchuang:countInt];
}

-(void)shangchuang:(NSInteger )countint{
    if (countint==0) {
        [[BaseView baseShar]dissMiss];
        [self _initTitle:@"您还没选择要上传的图片"];
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
            bgBtn.hidden = YES;
            [bgBtn removeFromSuperview];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)netImag:(NSString *)imageName{
    __weak typeof(self)selfWeek=self;
    
    [[NetworkManager shar] selectDataMessage:imageName success:^(NSArray *arrays) {
        if (arrays.count==countInt) {
            count = arrays.count;
            arrayImage = [NSMutableArray arrayWithArray:arrays];
            [selfWeek shangc];
        }
    }];
}

-(void)shangc{
     __weak typeof(self)selfWeek=self;
 
    SaveImageModel *saveImageModel;
    saveImageModel=(SaveImageModel *)[arrayImage objectAtIndex:count-1];
    NSLog(@"-----%@",saveImageModel.imagePath);
    UIImage *image=[UIImage imageWithContentsOfFile:saveImageModel.imagePath];
    NSString *url=[NSString stringWithFormat:@"servlet/appUploadServlet?makeType=%@",selfWeek.orderType];
    if (selfWeek.stakID) {
        url=[NSString stringWithFormat:@"servlet/appUploadServlet?makeType=%@&taskId=%@",selfWeek.orderType,selfWeek.stakID];
    }
    if (selfWeek.ID) {
        url=[NSString stringWithFormat:@"%@&ID=%@",url,selfWeek.ID];
    }
    [NetworkManager ImageRequestAsynchronous:url RequstImage:image Cname:selfWeek.imageType RequseParameter:nil success:^(id response) {
        count--;
        
        UpImageModel *upImageModel=[[UpImageModel alloc]initWithDictionary:response error:nil];
        if (upImageModel) {
            if ([upImageModel.status isEqualToString:@"1"]) {
                [selfWeek.PHOarray  replaceObjectAtIndex:count withObject: upImageModel.path];
                
                [selfWeek updata:saveImageModel.imagePath];
            }
        }
        if (count!=0) {
            [NSThread sleepForTimeInterval:0.5f];
            [selfWeek shangc];
        }else{
            [[BaseView baseShar]dissMiss];
            [selfWeek getTheData];
        }
    } SpeedProgress:^(float Progress) {
        NSLog(@"%f",Progress);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [[BaseView baseShar]dissMiss];
    }];
}

-(void)getTheData{
    if (self.ClockSave) {
        self.ClockSave(self.PHOarray,[NetworkManager Datastrings:self.PHOarray]);
        bgBtn.hidden = YES;
        [bgBtn removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    });
}

//轻击手势触发方法
-(void)tapGesture:(UITapGestureRecognizer *)sender
{
    imageView.hidden=YES;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.PHOarray.count+1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    ViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    cell.deleButton.tag=indexPath.row;
    cell.Clock=^(NSInteger index){
        [self deleteImage:[_PHOarray objectAtIndex:index] andIndex:index];
    };
    //
    cell.deleButton.hidden=YES;
    
    if (indexPath.row==self.PHOarray.count){
        cell.cellimage.image=[UIImage imageNamed:@"plus"];
    }else if ([[self.PHOarray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        //            网络图片
        [cell.cellimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,[self.PHOarray objectAtIndex:indexPath.row]]]];
        
        cell.deleButton.hidden=NO;
    }else {
        cell.deleButton.hidden=NO;
        cell.cellimage.image=[self.PHOarray objectAtIndex:indexPath.row];
    }
    if ([self.type isEqualToString:@"查看"]) {
        
        cell.deleButton.hidden=YES;
    }else{
        if (indexPath.row==self.PHOarray.count) {
            cell.deleButton.hidden=YES;
        }else
            cell.deleButton.hidden=NO;
    }
    
    return cell;
    
}
-(void)deleteImage:(NSString *)url andIndex:(NSInteger)index2{

    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":self.orderType,@"img":url,@"name":self.imageType}];
    if (self.stakID) {
        [dic setObject:self.stakID forKey:@"taskId"];
    }if (self.ID) {
        [dic setObject:self.ID forKey:@"ID"];
    }
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"删除中..."];
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appAction!updateUpimg.chtml" success:^(id responseObject) {
        DeleateImageModel *deleateImageModel=[[DeleateImageModel alloc]initWithDictionary:responseObject error:nil];
        if (deleateImageModel) {
            
            
            if ([deleateImageModel.status isEqualToString:@"1"]) {
                if (![deleateImageModel.message isEqualToString:@"图片文件不存在！"]) {
                    [SelfWeek _initTitle:deleateImageModel.message];
                }
                [_PHOarray removeObjectAtIndex:index2];
                selectIndex=selectIndex-1;
                
                [_collection reloadData];
                
                if (self.ClockSave) {
                    self.ClockSave(self.PHOarray,[NetworkManager Datastrings:self.PHOarray]);
                }
            }else{
                [SelfWeek _initTitle:deleateImageModel.message];
            }
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

//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 20, 20, 20);//分别为上、左、下、右
}

//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size={0,0};
    return size;
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    imageView.image=nil;
    if (self.PHOarray.count== indexPath.row) {
        if ([self.type isEqualToString:@"查看"]) {
            [BaseView _init:@"亲现在只能查看哦" View:self.view];
        }else{
            [self setpoth];
        }
        
    }else if ([[self.PHOarray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]){
        imageView.hidden=NO;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,[self.PHOarray objectAtIndex:indexPath.row ]]]];
        
    }else{
        imageView.hidden=NO;
        imageView.image=[self.PHOarray objectAtIndex:indexPath.row];
    }
}


-(void)setpoth{
    if (self.PHOarray.count>=self.selectMax) {
        [BaseView _init:[NSString stringWithFormat:@"亲最多只能选%ld图片",(long)self.selectMax] View:self.view];
        return;
    }
    UIActionSheet *myActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                    delegate:self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles: @"从相册选择", @"拍照",nil];
    [myActionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            //从相册选择
            [self LocalPhoto];
            break;
        case 1:
            //拍照
            [self takePhoto];
            break;
        default:
            break;
    }
}
//从相册选择
-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.title=[NSString stringWithFormat:@"(%lu/%ld)",(unsigned long)self.PHOarray.count+selectIndex,(long)self.selectMax];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    //    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
    }];
}

//拍照
-(void)takePhoto{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        //        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{
        }];
    }else {
        NSLog(@"该设备无摄像头");
    }
}
#pragma Delegate method UIImagePickerControllerDelegate
//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    //当图片不为空时显示图片并保存图片
    if (image != nil) {
        selectIndex=selectIndex+1;
        //图片显示在界面上
        NSData * data = UIImageJPEGRepresentation(image, .3);
        UIImage *imag=[UIImage imageWithData:data];
        [self.PHOarray insertObject:imag atIndex:0];
    }
    
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
