//
//  BusinessQuestionnaireViewController.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BusinessQuestionnaireViewController.h"
#import "SearchView2.h"
#import "BusinessTableViewCell.h"
#import "NetworkManager.h"
#import "FirstCell.h"
#import "BusinessFormsViewController.h"
#import "BusinessModel.h"
#import "OfficeQuestionnaireHeatView.h"
#import "DeleteModel.h"


//static const int startingH = 150;
@interface BusinessQuestionnaireViewController (){
    CGFloat         searchViewW;
    NSMutableArray  *openArray;
    NSInteger       removeIndex;
 
    NSString        *userName;
    int             pageNo;
    NSString        *businessID;
    NSString        *businessNum;
    NSString        *loucNo;
    NSArray         *makeTypeArray;
    NSString        *makeTypeStr;
    NSString        *makeTypeStr2;
    BusinessModelListModel *businessListModel;
    NSArray         *arrayBusiness;
    NSString        *searchStr;
    NSString        *searchText1;
    NSString        *searchText2;
    NSString        *backStr;
}
@property (assign, nonatomic)CGFloat searchViewH;
@property (strong, nonatomic)SearchView2 *searchView;


@end

@implementation BusinessQuestionnaireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商业楼盘查询";
    pageNo = 1;
    userName = userNameDefaults;
    makeTypeArray = @[@"tradeLoupan",@"tradeBuding",@"tradeLouceng",@"tradeShangpu"];
    makeTypeStr = [makeTypeArray objectAtIndex:0];
    arrayBusiness = @[@"商铺",@"楼层",@"楼栋"];
    
    self.baseArray=[[NSMutableArray alloc]init];
    openArray=[[NSMutableArray alloc]init];
    
    self.baseTableView.frame = CGRectMake(0, startingH, MainScreenWidth, MainScreenheight-startingH);
    
    [self searchV];
}

-(void)searchV{
    if (self.searchView == nil) {
        
        self.searchView = [[[NSBundle mainBundle]loadNibNamed:@"SearchView2" owner:self options:nil] lastObject];
        self.searchView.backgroundColor = [UIColor clearColor];
        [self.searchView loadOtherView];
        searchViewW = self.searchView.frame.size.width;
        self.searchViewH = 148;
        
        __weak typeof(self) searchBlock = self;
        self.searchView.PulldownButton = ^(NSString *upDown){
            if ([upDown isEqualToString:@"上"]) {
                searchBlock.searchView.frame = CGRectMake(0, 64, MainScreenWidth, 88+searchBlock.searchViewH);
                searchBlock.baseTableView.frame = CGRectMake(0, startingH+88, MainScreenWidth, MainScreenheight-startingH-88);
            }else{
                searchBlock.searchView.frame = CGRectMake(0, 64, MainScreenWidth, searchBlock.searchViewH);
                searchBlock.baseTableView.frame = CGRectMake(0, startingH, MainScreenWidth, MainScreenheight-startingH);
            }
        };
        
        self.searchView.SearchData = ^(NSString *nameStr, NSString *areaStr){
            searchStr = @"搜索";
            searchText1 = nameStr;
            searchText2 = areaStr;
            [searchBlock seatchNetwork];
        };
        self.searchView.addedPush = ^(){
            NSLog(@"点击了新增");
            
            [kUserDefaults setObject:@"商业新增" forKey:@"商业查看"];
            [searchBlock deleteObject];
            [searchBlock performSegueWithIdentifier:@"BusinessFormsVC" sender:nil];
        };
        
        self.searchView.frame = CGRectMake(0, 64, MainScreenWidth, self.searchViewH);
        [self.view addSubview:self.searchView];
    }
}

-(void)seatchNetwork{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:userName,@"user",@"10",@"pageSize",[NSString stringWithFormat:@"%d",pageNo],@"pageNo",makeTypeStr,@"makeType", nil];
    if (self.taskId.length>1) {
        [dict setObject:self.taskId forKey:@"taskId"];
        [kUserDefaults setObject:self.taskId forKey:@"taskId"];
    }else{
        [kUserDefaults removeObjectForKey:@"taskId"];
    }
    if ([makeTypeStr isEqualToString:@"tradeLoupan"]) {
        [dict setObject:searchText1 forKey:@"xzqu"];
        [dict setObject:searchText2 forKey:@"louPanName"];
    }else if ([makeTypeStr isEqualToString:@"tradeBuding"]){
        [dict setObject:searchText1 forKey:@"louPanName"];
        [dict setObject:searchText2 forKey:@"budingName"];
    }else if ([makeTypeStr isEqualToString:@"tradeLouceng"]){
        [dict setObject:searchText1 forKey:@"budingName"];
        [dict setObject:searchText2 forKey:@"loucengNo"];
    }else{
        [dict setObject:searchText1 forKey:@"budingName"];
        [dict setObject:searchText2 forKey:@"loucengNo"];
    }
    
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"搜索中..."];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appAction!listMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [SelfWeek tableviewEnd];
        BusinessModel *businessModel = [[BusinessModel alloc]initWithDictionary:responseObject error:nil];
        if (businessModel) {
            if (pageNo == 1) {
                [SelfWeek.baseArray removeAllObjects];
                [SelfWeek.baseArray addObjectsFromArray:businessModel.list];
                [SelfWeek searchHead];
            }else{
                [SelfWeek.baseArray addObjectsFromArray:businessModel.list];
            }
        }else{
            [BaseView _init:@"亲你的网络不给力哦" View:SelfWeek.view];
        }
        [SelfWeek openarray];
        [SelfWeek.baseTableView reloadData];
        [[BaseView baseShar]dissMiss];
    } failure:^(NSError *error) {
        [[BaseView baseShar]dissMiss];
        [BaseView _init:@"亲网络异常请稍后" View:SelfWeek.view];
        [SelfWeek tableviewEnd];
    }];
}

-(void)searchHead{
    if ([makeTypeStr isEqualToString:@"tradeLoupan"]) {
        self.searchView.label1.text = @"ID";
        self.searchView.label2.text = @"实际楼盘名称";
        self.searchView.label3.text = @"调查人";
        self.searchView.textButton.hidden = NO;
        self.searchView.textField1.placeholder = @"  行政区";
        self.searchView.textField2.placeholder = @"  楼盘名称";
    }else if ([makeTypeStr isEqualToString:@"tradeBuding"]){
        self.title = @"商业楼栋查询";
        self.searchView.label1.text = @"楼栋编号";
        self.searchView.label2.text = @"实际名称";
        self.searchView.label3.text = @"调查人";
        self.searchView.textButton.hidden = YES;
        self.searchView.textField1.placeholder = @"  楼盘名称";
        self.searchView.textField2.placeholder = @"  楼栋名称";
    }else if ([makeTypeStr isEqualToString:@"tradeLouceng"]){
        self.title = @"商业楼层查询";
        self.searchView.label1.text = @"楼栋名称";
        self.searchView.label2.text = @"楼层";
        self.searchView.label3.text = @"调查人";
        self.searchView.textButton.hidden = YES;
        self.searchView.textField1.placeholder = @"  楼栋名称";
        self.searchView.textField2.placeholder = @"  楼层号";
    }else{
        self.title = @"商业商铺查询";
        self.searchView.label1.text = @"楼栋名称";
        self.searchView.label2.text = @"现场商铺号";
        self.searchView.label3.text = @"调查人";
        self.searchView.textButton.hidden = YES;
        self.searchView.textField1.placeholder = @"  楼栋名称";
        self.searchView.textField2.placeholder = @"  楼层号";
    }
}

-(void)kNetworkListMake{
    NSDictionary *dict;
    if (self.taskId.length>1) {
        dict = @{@"user":userName,@"pageSize":@"10",@"pageNo":[NSString stringWithFormat:@"%d",pageNo],@"makeType":makeTypeStr,@"taskId":self.taskId};
        [kUserDefaults setObject:self.taskId forKey:@"taskId"];
    }else{
        dict = @{@"user":userName,@"pageSize":@"10",@"pageNo":[NSString stringWithFormat:@"%d",pageNo],@"makeType":makeTypeStr,};
        [kUserDefaults removeObjectForKey:@"taskId"];
    }
    
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"获取中..."];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appAction!listMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [SelfWeek tableviewEnd];
        BusinessModel *businessModel = [[BusinessModel alloc]initWithDictionary:responseObject error:nil];
        if (businessModel) {
            if (pageNo == 1) {
                [SelfWeek.baseArray removeAllObjects];
                [SelfWeek.baseArray addObjectsFromArray:businessModel.list];
                [SelfWeek searchHead];
            }else{
                [SelfWeek.baseArray addObjectsFromArray:businessModel.list];
            }
        }else{
            [BaseView _init:@"亲你的网络不给力哦" View:SelfWeek.view];
        }
        [SelfWeek openarray];
        [SelfWeek.baseTableView reloadData];
        [[BaseView baseShar]dissMiss];
    } failure:^(NSError *error) {
        [[BaseView baseShar]dissMiss];
        [BaseView _init:@"亲网络异常请稍后" View:SelfWeek.view];
        [SelfWeek tableviewEnd];
    }];
}

-(void)kNetworkListMake2{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:userName,@"user",@"10",@"pageSize",[NSString stringWithFormat:@"%d",pageNo],@"pageNo",makeTypeStr2,@"makeType",makeTypeStr,@"next", nil];
    if (self.taskId.length>1) {
        [dict setObject:self.taskId forKey:@"taskId"];
        [kUserDefaults setObject:self.taskId forKey:@"taskId"];
    }else{
        [kUserDefaults removeObjectForKey:@"taskId"];
    }
    
    if ([makeTypeStr2 isEqualToString:@"tradeLoupan"]) {
        [dict setObject:businessID forKey:@"loupanId"];
    }else if ([makeTypeStr2 isEqualToString:@"tradeBuding"]){
        [dict setObject:businessNum forKey:@"budingNo"];
    }else if ([makeTypeStr2 isEqualToString:@"tradeLouceng"]){
        [dict setObject:businessNum forKey:@"budingNo"];
        [dict setObject:loucNo forKey:@"loucNo"];
    }
    
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"获取中..."];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"/appAction!toMakeList.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [SelfWeek tableviewEnd];
        BusinessModel *businessModel = [[BusinessModel alloc]initWithDictionary:responseObject error:nil];
        if (businessModel) {
            if (pageNo == 1) {
                [openArray removeAllObjects];
                [self.baseArray removeAllObjects];
                [self.baseArray addObjectsFromArray:businessModel.list];
                
            }else{
                [self.baseArray addObjectsFromArray:businessModel.list];
            }
            [SelfWeek searchHead];
        }else{
            [BaseView _init:@"亲你的网络不给力哦" View:SelfWeek.view];
        }
        [SelfWeek openarray];
        [SelfWeek.baseTableView reloadData];
        [[BaseView baseShar]dissMiss];
    } failure:^(NSError *error) {
        [[BaseView baseShar]dissMiss];
        [BaseView _init:@"亲网络异常请稍后" View:SelfWeek.view];
        [SelfWeek tableviewEnd];
    }];
}

-(void)netWork:(int)page{
    pageNo = page;
    if ([backStr isEqualToString:@"返回"]) {
        [self kNetworkListMake];
    }else{
        if ([searchStr isEqualToString:@"搜索"]) {
            [self seatchNetwork];
        }else{
            if ([makeTypeStr isEqualToString:@"tradeLoupan"]) {
                [self kNetworkListMake];
            }else{
                [self kNetworkListMake2];
            }
        }
    }
}

-(void)tableviewEnd{
    [self.baseTableView.mj_header endRefreshing];
    [self.baseTableView.mj_footer endRefreshing];
}
-(void)openarray{
    for (int i=0; i<self.baseArray.count; i++) {
        [openArray addObject:@"no"];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.baseArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[openArray objectAtIndex:section] isEqualToString:@"yes"]) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 43;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessTableViewCell"];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"BusinessTableViewCell" owner:self options:nil] lastObject];
    }
    cell.delegate = self;
    cell.tag = indexPath.section;
    if ([makeTypeStr isEqualToString:@"tradeLoupan"]) {
        [cell disappearIndex:3 andArray:arrayBusiness];
    }else if ([makeTypeStr isEqualToString:@"tradeBuding"]){
        [cell disappearIndex:2 andArray:arrayBusiness];
    }else if ([makeTypeStr isEqualToString:@"tradeLouceng"]){
        [cell disappearIndex:1 andArray:arrayBusiness];
    }else{
        [cell disappearIndex:0 andArray:arrayBusiness];
    }
    
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    OfficeQuestionnaireHeatView *officeQuestionnaireHeatView=[[[NSBundle mainBundle]loadNibNamed:@"OfficeQuestionnaireHeatView" owner:self options:nil] lastObject];
    officeQuestionnaireHeatView.HeatClock=^(NSInteger indexCell){
        if ([[openArray objectAtIndex:indexCell]isEqualToString:@"yes"]) {
            [openArray replaceObjectAtIndex:indexCell withObject:@"no"];
        }else{
            [openArray replaceObjectAtIndex:indexCell withObject:@"yes"];
        }
        [self.baseTableView beginUpdates];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexCell];
        [self.baseTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.baseTableView endUpdates];
    };
    [officeQuestionnaireHeatView _initHeat5:[self.baseArray objectAtIndex:section] Index:section andMakeType:makeTypeStr];
    
    return officeQuestionnaireHeatView;
}

//BusinessTableViewCellDelegate
-(void)didSelectLocation:(BusinessTableViewCell *)aTableCell andSelectButton:(UIButton *)sender{
    businessListModel = [self.baseArray objectAtIndex:aTableCell.tag];
    businessID = [super replaceString:businessListModel.ID];
    businessNum = [super replaceString:businessListModel.楼栋编号];
    loucNo = [super replaceString:businessListModel.楼层];
    switch (sender.tag) {
        case 500:
        case 501:{
            [self saveObject];
            if (sender.tag == 500) {
                [kUserDefaults setObject:@"商业查看" forKey:@"商业查看"];
            }else{
                [kUserDefaults setObject:@"商业编辑" forKey:@"商业查看"];
            }
            [self performSegueWithIdentifier:@"BusinessFormsVC" sender:nil];
        }
            break;
        case 502:{
            removeIndex = aTableCell.tag;
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定要删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
            [alert show];
        }
            break;
        case 505:{
            searchStr = @"";
            makeTypeStr2 = makeTypeStr;
            makeTypeStr = [makeTypeArray objectAtIndex:1];
            [self netWork:1];
        }
            break;
        case 506:{
            searchStr = @"";
            makeTypeStr2 = makeTypeStr;
            makeTypeStr = [makeTypeArray objectAtIndex:2];
            [self netWork:1];
        }
            break;
        case 507:{
            searchStr = @"";
            makeTypeStr2 = makeTypeStr;
            makeTypeStr = [makeTypeArray objectAtIndex:3];
            [self netWork:1];
        }
            break;
    }
}

//UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"fasfas");
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ldl",(long)buttonIndex);
    if (buttonIndex==1) {
        NSLog(@"删除办公调查");
        [self deleteNet];
    }
}
-(void)deleteNet{
    __weak typeof(self)SelfWeek=self;
    NSDictionary *dict;
    if (self.taskId) {
        dict=@{@"taskId":self.taskId,@"ID":businessListModel.ID,@"makeType":makeTypeStr};
    }else{
        dict=@{@"ID":businessListModel.ID,@"makeType":makeTypeStr};
    }
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"删除中..."];
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appAction!delMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);

        DeleteModel *deleteModel = [[DeleteModel alloc]initWithDictionary:responseObject error:nil];
        if (deleteModel) {
            if ([deleteModel.status isEqualToString:@"1"]) {
                [openArray removeObjectAtIndex:removeIndex];
                [self.baseArray removeObjectAtIndex:removeIndex];
                [BaseView _init:@"删除成功" View:SelfWeek.view];
                
            }else{
                [BaseView _init:@"删除失败" View:SelfWeek.view];
            }
        }else{
            [BaseView _init:@"亲你的网络不给力哦" View:SelfWeek.view];
        }
        [SelfWeek.baseTableView reloadData];
        [[BaseView baseShar]dissMiss];
    } failure:^(NSError *error) {
        [[BaseView baseShar]dissMiss];
        [BaseView _init:@"亲网络异常请稍后" View:SelfWeek.view];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveObject{
    [kUserDefaults setObject:businessListModel.ID forKey:@"businessId"];
}
-(void)deleteObject{
    [kUserDefaults removeObjectForKey:@"businessId"];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([makeTypeStr isEqualToString:@"tradeLoupan"]) {
        self.selectIndexInt = 0;
    }else if ([makeTypeStr isEqualToString:@"tradeBuding"]){
        self.selectIndexInt = 1;
    }else if ([makeTypeStr isEqualToString:@"tradeLouceng"]){
        self.selectIndexInt = 2;
    }else{
        self.selectIndexInt = 3;
    }
    
    BusinessFormsViewController *formesVC = [segue destinationViewController];
    formesVC.selectIndex = self.selectIndexInt;
    formesVC.BlackVC = ^(){
        backStr = @"返回";
    };
}


@end
