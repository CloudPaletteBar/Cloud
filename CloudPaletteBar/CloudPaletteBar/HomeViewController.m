//
//  ViewController.m
//  CloudPaletteBar
//
//  Created by test on 16/8/8.
//  Copyright © 2016年 test. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "HomeHeatView.h"
#import "CloudPaletteBar.h"
#import "LoginModel.h"

static NSString *kcellIdentifier = @"collectionCellID";
static NSString *kheaderIdentifier = @"headerIdentifier";
static NSString *kfooterIdentifier = @"footerIdentifier";


@interface HomeViewController ()
{
    __weak IBOutlet UICollectionView *homeCollectionView;
    NSDictionary *homeDic;
    LoginModel *homesModel;
    
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"homes"]!=NULL) {
        homesModel=[[LoginModel alloc]initWithDictionary:[user objectForKey:@"homes"] error:nil];
    }
    homeDic=@{@"我的任务":@"task_image",@"个案调查":@"investigation_Image",@"我的复核":@"review_Image",@"历史记录":@"History_Image",@"设置":@"settinge_Image",@"数据上传":@"uplad_Image"};
    [self _init_homeUI];
}

-(void)_init_homeUI{
    self.navigationItem.titleView=[[UIImageView alloc]initWithImage:OdeSetImageName(@"navi_titile_Image")];
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [homeCollectionView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
    //注册headerView Nib的view需要继承UICollectionReusableView
    [homeCollectionView registerNib:[UINib nibWithNibName:@"HomeHeatView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    //注册footerView Nib的view需要继承UICollectionReusableView
    [homeCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfooterIdentifier];
}

#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return homesModel.role.count;
    
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    LoginRoleModel *loginRoleModel=[homesModel.role objectAtIndex:indexPath.row];
    [cell _initCell:loginRoleModel.roleName ImageName:[homeDic objectForKey:loginRoleModel.roleName] Number:homesModel.taskNum];
    return cell;
    
}
// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
         HomeHeatView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:kheaderIdentifier   forIndexPath:indexPath];
        return view;
    }else {
        UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:kfooterIdentifier   forIndexPath:indexPath];
        return view;

    }


}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(screen_width/3, screen_width/3);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    NSLog(@"%d",section);
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={screen_width,screen_width/2.4};
    return size;
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
    homeDic=@{@"我的任务":@"task_image",@"个案调查":@"investigation_Image",@"我的复核":@"review_Image",@"历史记录":@"History_Image",@"设置":@"settinge_Image",@"数据上传":@"uplad_Image"};
    LoginRoleModel *loginRoleModel=[homesModel.role objectAtIndex:indexPath.row];
    if ([loginRoleModel.roleName isEqualToString:@"我的任务"]) {
        [self performSegueWithIdentifier:@"MyVC" sender:nil];
    }else if ([loginRoleModel.roleName isEqualToString:@"个案调查"]){
        [self performSegueWithIdentifier:@"CaseStudyVC" sender:nil];
    }else if ([loginRoleModel.roleName isEqualToString:@"我的复核"]){
        [self performSegueWithIdentifier:@"MyReviewVC" sender:nil];
    }else if ([loginRoleModel.roleName isEqualToString:@"历史记录"]){
        [self performSegueWithIdentifier:@"HistoricalRecordVC" sender:nil];
    }else if ([loginRoleModel.roleName isEqualToString:@"设置"]){
        [self performSegueWithIdentifier:@"SettingVC" sender:nil];
    }else{
        [self performSegueWithIdentifier:@"UploadVC" sender:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
