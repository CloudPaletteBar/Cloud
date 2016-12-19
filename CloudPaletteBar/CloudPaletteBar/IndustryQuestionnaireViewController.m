//
//  IndustryQuestionnaireViewController.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "IndustryQuestionnaireViewController.h"
#import "SearchView2.h"
#import "NetworkManager.h"
#import "BusinessTableViewCell.h"
#import "FirstCell.h"
#import "IndustryFromsViewController.h"
#import "IndustryQuestionnaireModel.h"
#import "OfficeQuestionnaireHeatView.h"
#import "DeleteModel.h"


@interface IndustryQuestionnaireViewController ()
{
    CGFloat         searchViewW;
    NSMutableArray  *openArray;
    NSInteger       removeIndex;

    NSString        *userName;
    int             pageNo;
    NSString        *zongdiNo;//宗地编号
    NSString        *gyyId;//ID
    NSString        *zongdiNo2;//宗地号
    NSString        *loupanId;//楼盘ID
    NSString        *budingNo;//楼栋编号
    NSString        *loucengNo;//楼层
    NSArray         *makeTypeArray;
    NSString        *makeTypeStr;
    NSString        *makeTypeStr2;
    IndustryQuestionnaireListModel *industryListModel;
    NSArray         *industryArray;
    NSString        *searchStr;
    NSString        *searchText1;
    NSString        *searchText2;
    NSString        *backStr;
}

@property (assign, nonatomic)CGFloat searchViewH;
@property (strong, nonatomic)SearchView2 *searchView;

@end

@implementation IndustryQuestionnaireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"工业宗地查询";
    pageNo = 1;
    userName = userNameDefaults;
    makeTypeArray = @[@"industryZongdi",@"industryGongyeyuan",@"industryLoupan",@"industryBuding",@"industryLouceng",@"industryFangwu"];
    makeTypeStr = [makeTypeArray objectAtIndex:0];
    industryArray = @[@"房屋",@"楼层",@"楼栋",@"楼盘",@"工业园"];
    
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
            [searchBlock searchNetwork];
        };
        self.searchView.addedPush = ^(){
            NSLog(@"点击了新增");
            [kUserDefaults setObject:@"工业新增" forKey:@"工业查看"];
            [searchBlock deleteObject];
            [searchBlock performSegueWithIdentifier:@"IndustryFromsVC" sender:nil];
        };
        
        self.searchView.frame = CGRectMake(0, 64, MainScreenWidth, self.searchViewH);
        [self.view addSubview:self.searchView];
    }
}

-(void)searchNetwork{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:userName,@"user",@"10",@"pageSize",[NSString stringWithFormat:@"%d",pageNo],@"pageNo",makeTypeStr,@"makeType", nil];
    if (self.taskId.length>1) {
        [dict setObject:self.taskId forKey:@"taskId"];
        [kUserDefaults setObject:self.taskId forKey:@"taskId"];
    }else{
        [kUserDefaults removeObjectForKey:@"taskId"];
    }
    if ([makeTypeStr isEqualToString:@"industryZongdi"]) {
        [dict setObject:searchText1 forKey:@"xzqu"];
        [dict setObject:searchText2 forKey:@"zingdiNo"];
    }else if ([makeTypeStr isEqualToString:@"industryGongyeyuan"]){
        [dict setObject:searchText1 forKey:@"zingdiNo"];
        [dict setObject:searchText2 forKey:@"gongyyName"];
    }else if ([makeTypeStr isEqualToString:@"industryLoupan"]){
        [dict setObject:searchText1 forKey:@"gongyyName"];
        [dict setObject:searchText2 forKey:@"louPanName"];
    }else if ([makeTypeStr isEqualToString:@"industryBuding"]){
        [dict setObject:searchText1 forKey:@"louPanName"];
        [dict setObject:searchText2 forKey:@"budingName"];
    }else if ([makeTypeStr isEqualToString:@"industryLouceng"]){
        [dict setObject:searchText1 forKey:@"louPanName"];
        [dict setObject:searchText2 forKey:@"budingName"];
    }else{
        [dict setObject:searchText1 forKey:@"budingName"];
        [dict setObject:searchText2 forKey:@"loucengNo"];
    }
        
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"搜索中..."];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appAction!listMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [SelfWeek tableviewEnd];
        IndustryQuestionnaireModel *industryModel = [[IndustryQuestionnaireModel alloc]initWithDictionary:responseObject error:nil];
        if (industryModel) {
            if (pageNo == 1) {
                [SelfWeek.baseArray removeAllObjects];
                [SelfWeek.baseArray addObjectsFromArray:industryModel.list];
                [SelfWeek searchHead];
            }else{
                [SelfWeek.baseArray addObjectsFromArray:industryModel.list];
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
    if ([makeTypeStr isEqualToString:@"industryZongdi"]) {
        self.searchView.label1.text = @"宗地编号";
        self.searchView.label2.text = @"街道办";
        self.searchView.label3.text = @"调查人";
        
        self.searchView.textButton.hidden = NO;
        self.searchView.textField1.placeholder = @"  行政区";
        self.searchView.textField2.placeholder = @"  宗地号";
    }else if ([makeTypeStr isEqualToString:@"industryGongyeyuan"]){
        self.title = @"工业工业园查询";
        self.searchView.label1.text = @"宗地号";
        self.searchView.label2.text = @"园区名称";
        self.searchView.label3.text = @"调查人";
        
        self.searchView.textButton.hidden = YES;
        self.searchView.textField1.placeholder = @"  宗地号";
        self.searchView.textField2.placeholder = @"  工业园名称";
    }else if ([makeTypeStr isEqualToString:@"industryLoupan"]){
        self.title = @"工业楼盘查询";
        self.searchView.label1.text = @"楼盘ID";
        self.searchView.label2.text = @"楼盘名称";
        self.searchView.label3.text = @"调查人";
        
        self.searchView.textButton.hidden = YES;
        self.searchView.textField1.placeholder = @"  工业园名称";
        self.searchView.textField2.placeholder = @"  楼盘名称";
    }else if ([makeTypeStr isEqualToString:@"industryBuding"]){
        self.title = @"工业楼栋查询";
        self.searchView.label1.text = @"楼栋编号";
        self.searchView.label2.text = @"楼栋名称";
        self.searchView.label3.text = @"调查人";
        
        self.searchView.textButton.hidden = YES;
        self.searchView.textField1.placeholder = @"  楼盘名称";
        self.searchView.textField2.placeholder = @"  楼栋名称";
    }else if ([makeTypeStr isEqualToString:@"industryLouceng"]){
        self.title = @"工业楼层查询";
        self.searchView.label2.text = @"楼栋名称";
        self.searchView.label1.text = @"楼层号";
        self.searchView.label3.text = @"调查人";
        
        self.searchView.textButton.hidden = YES;
        self.searchView.textField1.placeholder = @"  楼盘名称";
        self.searchView.textField2.placeholder = @"  楼栋名称";
    }else{
        self.title = @"工业房屋查询";
        self.searchView.label2.text = @"楼栋名称";
        self.searchView.label1.text = @"房屋号";
        self.searchView.label3.text = @"调查人";
        
        self.searchView.textButton.hidden = YES;
        self.searchView.textField1.placeholder = @"  楼栋名称";
        self.searchView.textField2.placeholder = @"  楼层号";
    }
}

-(void)kNetworkListMake{
    NSDictionary *dict;
    if (_taskId.length>1) {
        dict = @{@"user":userName,@"pageSize":@"10",@"pageNo":[NSString stringWithFormat:@"%d",pageNo],@"makeType":makeTypeStr,@"taskId":self.taskId};
        [kUserDefaults setObject:self.taskId forKey:@"taskIdIndustry"];
    }else{
        dict = @{@"user":userName,@"pageSize":@"10",@"pageNo":[NSString stringWithFormat:@"%d",pageNo],@"makeType":makeTypeStr};
        [kUserDefaults removeObjectForKey:@"taskIdIndustry"];
    }
    
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"获取中..."];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appAction!listMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [SelfWeek tableviewEnd];
        IndustryQuestionnaireModel *industryModel = [[IndustryQuestionnaireModel alloc]initWithDictionary:responseObject error:nil];
        if (industryModel) {
            if (pageNo == 1) {
                [SelfWeek.baseArray removeAllObjects];
                [SelfWeek.baseArray addObjectsFromArray:industryModel.list];
                [SelfWeek searchHead];
            }else{
                [SelfWeek.baseArray addObjectsFromArray:industryModel.list];
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
    NSMutableDictionary *dict;
    if (self.taskId.length>1) {
        dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:userName,@"user",@"10",@"pageSize",[NSString stringWithFormat:@"%d",pageNo],@"pageNo",makeTypeStr2,@"makeType",makeTypeStr,@"next", self.taskId,@"taskId", nil];
        [kUserDefaults setObject:self.taskId forKey:@"taskIdIndustry"];
    }else{
        dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:userName,@"user",@"10",@"pageSize",[NSString stringWithFormat:@"%d",pageNo],@"pageNo",makeTypeStr2,@"makeType",makeTypeStr,@"next", nil];
        [kUserDefaults removeObjectForKey:@"taskIdIndustry"];
    }
    
    if ([makeTypeStr2 isEqualToString:@"industryZongdi"]) {
        [dict setObject:zongdiNo forKey:@"zongdiNo"];
    }else if ([makeTypeStr2 isEqualToString:@"industryGongyeyuan"]){
        [dict setObject:gyyId forKey:@"gyyId"];
        [dict setObject:zongdiNo2 forKey:@"zongdiNo"];
    }else if ([makeTypeStr2 isEqualToString:@"industryLoupan"]){
        [dict setObject:loupanId forKey:@"loupanId"];
    }else if ([makeTypeStr2 isEqualToString:@"industryBuding"]){
        [dict setObject:budingNo forKey:@"budingNo"];
    }else if ([makeTypeStr2 isEqualToString:@"industryLouceng"]){
        [dict setObject:budingNo forKey:@"budingNo"];
        [dict setObject:loucengNo forKey:@"loucengNo"];
    }
    
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"获取中..."];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"/appAction!toMakeList.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [SelfWeek tableviewEnd];
        IndustryQuestionnaireModel *businessModel = [[IndustryQuestionnaireModel alloc]initWithDictionary:responseObject error:nil];
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
        [self kNetworkListMake2];
    }else{
        if ([searchStr isEqualToString:@"搜索"]) {
            [self searchNetwork];
        }else{
            if ([makeTypeStr isEqualToString:@"industryZongdi"]) {
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[openArray objectAtIndex:section] isEqualToString:@"yes"]) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 43;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessTableViewCell"];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"BusinessTableViewCell" owner:self options:nil] lastObject];
    }
    cell.delegate = self;
    cell.tag=indexPath.section;
    if ([makeTypeStr isEqualToString:@"industryZongdi"]) {
        [cell disappearIndex:5 andArray:industryArray];
    }else if ([makeTypeStr isEqualToString:@"industryGongyeyuan"]){
        [cell disappearIndex:4 andArray:industryArray];
    }else if ([makeTypeStr isEqualToString:@"industryLoupan"]){
        [cell disappearIndex:3 andArray:industryArray];
    }else if ([makeTypeStr isEqualToString:@"industryBuding"]){
        [cell disappearIndex:2 andArray:industryArray];
    }else if ([makeTypeStr isEqualToString:@"industryLouceng"]){
        [cell disappearIndex:1 andArray:industryArray];
    }else{
        [cell disappearIndex:0 andArray:industryArray];
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
    [officeQuestionnaireHeatView _initHeat4:[self.baseArray objectAtIndex:section] Index:section andMakeType:makeTypeStr];
    return officeQuestionnaireHeatView;
}

//BusinessTableViewCellDelegate
-(void)didSelectLocation:(BusinessTableViewCell *)aTableCell andSelectButton:(UIButton *)sender{
    NSLog(@"---%ld",aTableCell.tag);
    industryListModel = [self.baseArray objectAtIndex:aTableCell.tag];
    zongdiNo = [super replaceString:industryListModel.宗地编号];
    gyyId = [super replaceString:industryListModel.ID];
    zongdiNo2 = [super replaceString:industryListModel.宗地号];
    loupanId = [super replaceString:industryListModel.ID];
    budingNo = [super replaceString:industryListModel.楼栋编号];
    loucengNo = [super replaceString:industryListModel.楼层];
    switch (sender.tag) {
        case 500:
        case 501:{
            [self saveObject];
            if (sender.tag == 500) {
                [kUserDefaults setObject:@"工业查看" forKey:@"工业查看"];
            }else{
                [kUserDefaults setObject:@"工业编辑" forKey:@"工业查看"];
            }
            [self performSegueWithIdentifier:@"IndustryFromsVC" sender:nil];
        }
            break;
        case 502:{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定要删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
            [alert show];
        }
            break;
        case 503:{
            searchStr = @"";
            makeTypeStr2 = makeTypeStr;
            makeTypeStr = [makeTypeArray objectAtIndex:1];
            [self netWork:1];
        }
            break;
        case 504:{
            searchStr = @"";
            makeTypeStr2 = makeTypeStr;
            makeTypeStr = [makeTypeArray objectAtIndex:2];
            [self netWork:1];
        }
            break;
        case 505:{
            searchStr = @"";
            makeTypeStr2 = makeTypeStr;
            makeTypeStr = [makeTypeArray objectAtIndex:3];
            [self netWork:1];
        }
            break;
        case 506:{
            searchStr = @"";
            makeTypeStr2 = makeTypeStr;
            makeTypeStr = [makeTypeArray objectAtIndex:4];
            [self netWork:1];
        }
            break;
        case 507:{
            searchStr = @"";
            makeTypeStr2 = makeTypeStr;
            makeTypeStr = [makeTypeArray objectAtIndex:5];
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
        dict=@{@"taskId":self.taskId,@"ID":industryListModel.ID,@"makeType":makeTypeStr};
    }else{
        dict=@{@"ID":industryListModel.ID,@"makeType":makeTypeStr};
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

-(void)saveObject{
    [kUserDefaults setObject:industryListModel.ID forKey:@"industryId"];
}
-(void)deleteObject{
    [kUserDefaults removeObjectForKey:@"industryId"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([makeTypeStr isEqualToString:@"industryZongdi"]) {
        self.selectIndexInt = 0;
    }else if ([makeTypeStr isEqualToString:@"industryGongyeyuan"]){
        self.selectIndexInt = 1;
    }else if ([makeTypeStr isEqualToString:@"industryLoupan"]){
        self.selectIndexInt = 2;
    }else if ([makeTypeStr isEqualToString:@"industryBuding"]){
        self.selectIndexInt = 3;
    }else if ([makeTypeStr isEqualToString:@"industryLouceng"]){
        self.selectIndexInt = 4;
    }else{
        self.selectIndexInt = 5;
    }
    
    IndustryFromsViewController *formesVC = [segue destinationViewController];
    formesVC.selectIndex = self.selectIndexInt;
    formesVC.BlackVC = ^(){
        backStr = @"返回";
    };
    
}

@end
