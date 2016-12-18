//
//  OrdinaryQuestionnaireViewController.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "OrdinaryQuestionnaireViewController.h"
#import "OrdinaryFormViewController.h"
#import "OfficeHeatView.h"
#import "OfficeQuestionnaireHeatView.h"
#import "SearchView2.h"
#import "BusinessTableViewCell.h"
#import "OfficeQuestionnaireModel.h"
#import "DeleteModel.h"

@interface OrdinaryQuestionnaireViewController (){
    OfficeHeatView *officeHeatView;
    NSMutableArray *openArray;
    CGFloat searchViewW;
    
    NSString        *userName;
    int             pageNo;
    
    NSArray         *makeTypeArray;
    NSString        *makeTypeStr;
    NSString        *makeTypeStr2;
    OfficeQuestionnaireListModel    *officeListModel;
    NSString *addStr;
    NSUInteger removeIndex;
    NSString *SelectID;
    NSString *NumberStr;
    NSArray *ordinaryArray;
    NSString        *searchText1;
    NSString        *searchText2;
    NSString        *backStr;
}
@property(nonatomic,assign)NSInteger selectIndex;
@property (assign, nonatomic)CGFloat searchViewH;
@property (strong, nonatomic)SearchView2 *searchView;

@end

@implementation OrdinaryQuestionnaireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"普通住宅调查";
    pageNo = 1;
    userName = userNameDefaults;
    makeTypeArray = @[@"houseDLoupan",@"houseDBuding",@"houseDFangwu"];
    makeTypeStr = [makeTypeArray objectAtIndex:0];
    ordinaryArray = @[@"房屋",@"楼栋"];
    
    openArray=[[NSMutableArray alloc]init];
    self.baseArray=[[NSMutableArray alloc]init];


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
            NSLog(@"点击了搜索");
            searchText1 = nameStr;
            searchText2 = areaStr;
            [searchBlock kNetworkListMake];
        };
        self.searchView.addedPush = ^(){
            NSLog(@"点击了新增");
            addStr =@"新增";
            [searchBlock performSegueWithIdentifier:@"OrdinaryForm" sender:nil];
        };
        
        self.searchView.frame = CGRectMake(0, 64, MainScreenWidth, self.searchViewH);
        [self.view addSubview:self.searchView];
    }
}

-(void)searchHead{
    if ([makeTypeStr isEqualToString:@"houseDLoupan"]) {
        self.searchView.label1.text = @"ID";
        self.searchView.label2.text = @"实际楼盘名称";
        self.searchView.label3.text = @"调查人";
         self.title=@"普通楼盘调查";
        self.searchView.textButton.hidden = NO;
        self.searchView.textField1.placeholder = @"  行政区";
        self.searchView.textField2.placeholder = @"  楼盘名称";
    }else if ([makeTypeStr isEqualToString:@"houseDBuding"]){
        self.searchView.label1.text = @"楼栋编号";
        self.searchView.label2.text = @"实际楼栋名称";
        self.searchView.label3.text = @"调查人";
        self.title=@"普通楼栋调查";
        self.searchView.textButton.hidden = YES;
        self.searchView.textField1.placeholder = @"  楼盘名称";
        self.searchView.textField2.placeholder = @"  楼栋名称";
    }else{
        self.searchView.label1.text = @"楼栋名称";
        self.searchView.label2.text = @"现用房号";
        self.searchView.label3.text = @"调查人";
        self.title=@"普通房屋调查";
        self.searchView.textButton.hidden = YES;
        self.searchView.textField1.placeholder = @"  楼栋名称";
        self.searchView.textField2.placeholder = @"  楼层号";
    }
}

-(void)kNetworkListMake
{
    NSDictionary *dcit ;
    if (self.QID) {
        dcit= @{@"taskId":self.QID,@"user":userName,@"pageSize":@"10",@"pageNo":[NSString stringWithFormat:@"%d",pageNo],@"makeType":makeTypeStr};
    }else{
     dcit= @{@"user":userName,@"pageSize":@"10",@"pageNo":[NSString stringWithFormat:@"%d",pageNo],@"makeType":makeTypeStr};
    }
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:dcit];
    if (searchText1.length!=0) {
        [dic setObject:searchText1 forKey:@"xzqu"];
    }else if(searchText2.length!=0){
        [dic setObject:searchText2 forKey:@"louPanName"];
    }
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"获取中..."];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appAction!listMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [SelfWeek tableviewEnd];
        OfficeQuestionnaireModel *businessModel = [[OfficeQuestionnaireModel alloc]initWithDictionary:responseObject error:nil];
        if (businessModel) {
            if (pageNo == 1) {
                [SelfWeek.baseArray removeAllObjects];
                [SelfWeek.baseArray addObjectsFromArray:businessModel.list];
            }else{
                [SelfWeek.baseArray addObjectsFromArray:businessModel.list];
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

-(void)kNetworkListMake2
{
    NSMutableDictionary *dict;
    if (self.QID) {
        dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.QID,@"taskId",userName,@"user",@"10",@"pageSize",[NSString stringWithFormat:@"%d",pageNo],@"pageNo",makeTypeStr2,@"makeType",makeTypeStr,@"next", nil];
    }else{
         dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:userName,@"user",@"10",@"pageSize",[NSString stringWithFormat:@"%d",pageNo],@"pageNo",makeTypeStr2,@"makeType",makeTypeStr,@"next", nil];
    }
    if ([makeTypeStr2 isEqualToString:@"houseDLoupan"]) {
        [dict setObject:SelectID forKey:@"loupanId"];
    }else if ([makeTypeStr2 isEqualToString:@"houseDBuding"]){
        NSString *string = [super replaceString:NumberStr];
        [dict setObject:string forKey:@"budingNo"];
    }
    
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"获取中..."];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"/appAction!toMakeList.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [SelfWeek tableviewEnd];
        OfficeQuestionnaireModel *businessModel = [[OfficeQuestionnaireModel alloc]initWithDictionary:responseObject error:nil];
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
        if ([makeTypeStr isEqualToString:@"houseDLoupan"]) {
            [self kNetworkListMake];
        }else{
            [self kNetworkListMake2];
        }
    }
}

-(void)openarray{
    for (int i=0; i<self.baseArray.count; i++) {
        [openArray addObject:@"no"];
    }
}

-(void)tableviewEnd{
    [self.baseTableView.mj_header endRefreshing];
    [self.baseTableView.mj_footer endRefreshing];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessTableViewCell"];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"BusinessTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.tag=indexPath.section;
    cell.delegate = self;
    if ([makeTypeStr isEqualToString:@"houseDLoupan"]) {
        [cell disappearIndex:2 andArray:ordinaryArray];
        _selectIndex = 0;
    }else if ([makeTypeStr isEqualToString:@"houseDBuding"]){
        [cell disappearIndex:1 andArray:ordinaryArray];
        _selectIndex = 1;
    }else{
        [cell disappearIndex:0 andArray:ordinaryArray];
        _selectIndex = 2;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 43;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OfficeQuestionnaireHeatView *officeQuestionnaireHeatView=[[[NSBundle mainBundle]loadNibNamed:@"OfficeQuestionnaireHeatView" owner:self options:nil] lastObject];
    officeQuestionnaireHeatView.HeatClock=^(NSInteger indexCell){
        if ([[openArray objectAtIndex:indexCell]isEqualToString:@"yes"]) {
            [openArray replaceObjectAtIndex:indexCell withObject:@"no"];
        }else{
            [openArray replaceObjectAtIndex:indexCell withObject:@"yes"];
        }
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexCell];
        [self.baseTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    [officeQuestionnaireHeatView _initHeat3:[self.baseArray objectAtIndex:section] Index:section andMakeType:makeTypeStr];
    return officeQuestionnaireHeatView;
}

//BusinessTableViewCellDelegate
-(void)didSelectLocation:(BusinessTableViewCell *)aTableCell andSelectButton:(UIButton *)sender{
    officeListModel = [self.baseArray objectAtIndex:aTableCell.tag];
    NumberStr=[super replaceString:officeListModel.楼栋编号];
    SelectID=[super replaceString:officeListModel.ID];
    switch (sender.tag) {
        case 500:{
            addStr=@"查看";
            [self performSegueWithIdentifier:@"OrdinaryForm" sender:nil];
        }
            break;
        case 501:{
            addStr=@"编辑";
            [self performSegueWithIdentifier:@"OrdinaryForm" sender:nil];
        }
            break;
        case 502:{
            removeIndex=aTableCell.tag;
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定要删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
            [alert show];
        }
            break;
        case 506:{
            self.selectIndex=1;
            makeTypeStr2 = makeTypeStr;
            makeTypeStr = [makeTypeArray objectAtIndex:1];
            [self netWork:1];
        }
            break;
        case 507:{
            self.selectIndex=2;
            makeTypeStr2 = makeTypeStr;
            makeTypeStr = [makeTypeArray objectAtIndex:2];
            [self netWork:1];
        }
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
    if (buttonIndex==1) {
        NSLog(@"删除办公调查");
        [self deleteNet];
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

-(void)saveObject{
    [kUserDefaults setObject:makeTypeStr forKey:@"ordinaryMakeType"];
    [kUserDefaults setObject:officeListModel.ID forKey:@"ordinaryId"];
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
    
    if (![addStr isEqualToString:@"新增"]) {
       [self saveObject];
    }else{
        [kUserDefaults removeObjectForKey:@"ordinaryId"];
    }
    
    OrdinaryFormViewController *ordinaryVC=[segue destinationViewController];
    if ([addStr isEqualToString:@"新增"]) {
        ordinaryVC.formID=self.QID;
    }else if ([addStr isEqualToString:@"查看"]){
        ordinaryVC.selectSee=addStr;
        ordinaryVC.formID=self.QID;
    }
    else{
        ordinaryVC.selectSee=addStr;
        ordinaryVC.formID=self.QID;
        
        //        formViewController.formID=self.;
    }
    ordinaryVC.selectIndex=self.selectIndex;
    ordinaryVC.BlackVC = ^(){
        backStr = @"返回";
    };
}


-(void)deleteNet{
    __weak typeof(self)SelfWeek=self;
    NSDictionary *dict;
    if (self.QID) {
        dict=@{@"taskId":self.QID,@"ID":officeListModel.ID,@"makeType":makeTypeStr};
    }else{
        dict=@{@"ID":officeListModel.ID,@"makeType":makeTypeStr};
    }
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"删除中..."];
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appAction!delMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        //        [SelfWeek tableviewEnd];
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


@end
