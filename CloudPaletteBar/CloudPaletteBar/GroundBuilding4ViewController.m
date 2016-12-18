//
//  GroundBuilding4ViewController.m
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/8/25.
//  Copyright © 2016年 test. All rights reserved.
//

#import "GroundBuilding4ViewController.h"
#import "SaveModel.h"
#import "GroundBuilding4Model.h"
#import "FormSelectTableView.h"
#import "MJRefresh.h"
#import "LowPropertyNameView.h"
#import "GongyeZongdiModel.h"


@interface GroundBuilding4ViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UISearchBarDelegate>
{
    FormSelectTableView *formSelectTableView;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    NSMutableArray *ArrayZongdi;
    NSMutableArray *ArrayAll;
    NSInteger integerTag;
    NSMutableArray *groundArray;
    GroundBuilding4ListModel *groundBuildingListModel;
    NSString *look;
    
    __weak IBOutlet UITextField *textField1;
    __weak IBOutlet UITextField *textField2;
    __weak IBOutlet UITextField *textField3;
    __weak IBOutlet UITextField *textField4;
    __weak IBOutlet UITextField *textField5;
    __weak IBOutlet UITextField *textField6;
    __weak IBOutlet UITextField *textField7;

    __weak IBOutlet UIButton *button1;
    __weak IBOutlet UIButton *button3;
    __weak IBOutlet UIButton *button4;
    
    NSString *secarchName;
    UIView *formSelectView;
}
@property (nonatomic ,strong)UISearchBar *searchBar;
@end

@implementation GroundBuilding4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotices:) name:@"GroundBusiness" object:nil];
    
    _strId = [kUserDefaults objectForKey:@"industryId"];
    _taskId = [kUserDefaults objectForKey:@"taskIdIndustry"];
    groundArray = [NSMutableArray arrayWithCapacity:1];
    
    look = [kUserDefaults objectForKey:@"工业查看"];
    if ([look isEqualToString:@"工业查看"]) {
        button4.hidden = YES;
    }
    
    self.contentView.frame = CGRectMake(0, 0, MainScreenWidth, self.contentView.frame.size.height);
    [self.buil4ScrollView addSubview:self.contentView];
    self.buil4ScrollView.contentSize = CGSizeMake(0, 480);
    
    [self kNetworkListMake];
    
    [self layerView:button3];
    [self layerView:button1];
    [self layerView:button4];
    
    formSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-150)];
    self.searchBar.frame = CGRectMake(0, 0, screen_width, 50.0);
    formSelectTableView=[[FormSelectTableView alloc]initWithFrame:CGRectMake(0, 50, screen_width, formSelectView.frame.size.height-50)];
    [formSelectView addSubview:formSelectTableView];
    __weak typeof(self)SelfWeak=self;
    [formSelectTableView _initOrderUP:^(int Page) {
        [SelfWeak netSysData:Page andTag:integerTag  andName:[super replaceString:secarchName]];
    } Down:^(int Page) {
        [SelfWeak netSysData:Page andTag:integerTag  andName:[super replaceString:secarchName]];
    }];
}

- (void)reciveNotices:(NSNotification *)notification{
    textField1.text = [super replaceString:[kUserDefaults objectForKey:@"工业楼栋名称"]];
    textField2.text = [super replaceString:[kUserDefaults objectForKey:@"工业楼层"]];
    
    groundBuildingListModel.楼栋名称 = textField1.text;
    groundBuildingListModel.楼层 = textField2.text;
    groundBuildingListModel.楼栋编号 = [kUserDefaults objectForKey:@"工业楼栋编号"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)layerView:(UIView *)view{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0;
}

-(void)kNetworkListMake{
    NSDictionary *dcit;
    if (self.selectIndex == 5) {
        if (self.taskId) {
            if (self.strId.length>1) {
                dcit = @{@"makeType":@"industryFangwu",@"ID":self.strId,@"taskId":self.taskId};
            }else{
                dcit = @{@"makeType":@"industryFangwu",@"taskId":self.taskId};
            }
        }else if (self.strId){
            dcit = @{@"makeType":@"industryFangwu",@"ID":self.strId};
        }else{
            dcit = @{@"makeType":@"industryFangwu"};
        }
    }else{
        dcit = @{@"ID":@"0"};
    }
    __weak typeof(self)SelfWeek=self;
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dcit relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);

        GroundBuilding4Model *groundBuildingModel = [[GroundBuilding4Model alloc]initWithDictionary:responseObject error:nil];
        if (groundBuildingModel) {
            [groundArray addObjectsFromArray:groundBuildingModel.list];
        }else{
            [BaseView _init:@"亲你的网络不给力哦" View:SelfWeek.view];
        }
        if (groundArray.count>0) {
            [SelfWeek loadData];
        }else{
            [SelfWeek _initObject];
        }
    } failure:^(NSError *error) {
        [BaseView _init:@"亲网络异常请稍后" View:SelfWeek.view];
    }];
}

-(void)_initObject{
    groundBuildingListModel = [[GroundBuilding4ListModel alloc]init];
}

-(void)loadData{
    groundBuildingListModel = [groundArray objectAtIndex:0];
    
    textField1.text = [super replaceString:groundBuildingListModel.楼栋名称];
    textField2.text = [super replaceString:groundBuildingListModel.楼层];
    textField3.text = [super replaceString:groundBuildingListModel.系统房号];
    textField4.text = [super replaceString:groundBuildingListModel.系统楼层];
    textField5.text = [super replaceString:groundBuildingListModel.所在楼层];
    textField6.text = [super replaceString:groundBuildingListModel.实际房号];
    textField7.text = [super replaceString:groundBuildingListModel.备注];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (textField.tag) {
        case 700:{
            groundBuildingListModel.楼栋名称 = textField.text;
        }
            break;
        case 701:{
            groundBuildingListModel.楼层 = textField.text;
        }
            break;
        case 702:{
            groundBuildingListModel.系统房号 = textField.text;
        }
            break;
        case 703:{
            groundBuildingListModel.系统楼层 = textField.text;
        }
            break;
        case 704:{
            groundBuildingListModel.所在楼层 = textField.text;
        }
            break;
        case 705:{
            groundBuildingListModel.实际房号 = textField.text;
        }
            break;
        case 706:{
            groundBuildingListModel.备注 = textField.text;
        }
            break;
    }
}

//保存按钮。
- (IBAction)saveButton:(UIButton *)sender {
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
    if (!(groundBuildingListModel.楼栋名称.length>1)) {
        [BaseView _init:@"请选择楼栋名称" View:self.view];
    }else if (!(groundBuildingListModel.所在楼层.length>0)){
        [BaseView _init:@"请填写所在楼层" View:self.view];
    }else if (!(groundBuildingListModel.实际房号.length>0)){
        [BaseView _init:@"请填写实际房号" View:self.view];
    }else{
        [self kNetworkListMake2];
    }
}
-(void)kNetworkListMake2{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:groundBuildingListModel.toDictionary];
    [dict setObject:@"industryFangwu" forKey:@"makeType"];
    if (self.taskId) {
        [dict setObject:self.taskId forKey:@"taskId"];
    }else if (self.strId){
        [dict setObject:self.strId forKey:@"id"];
    }
    
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"保存中..."];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appAction!saveMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        SaveModel *saveModel=[[SaveModel alloc]initWithDictionary:responseObject error:nil];
        if (saveModel) {
            if ([saveModel.status isEqualToString:@"1"]) {
                [BaseView _init:saveModel.message View:SelfWeek.view];
                groundBuildingListModel.ID = saveModel.ID;
//                if ([look isEqualToString:@"工业新增"]) {
//                    [self.navigationController popViewControllerAnimated:YES];
//                }
            }else{
                [BaseView _init:saveModel.message View:SelfWeek.view];
            }
        }else{
            [BaseView _init:@"亲网络异常请稍后" View:SelfWeek.view];
        }
        [[BaseView baseShar]dissMiss];
    } failure:^(NSError *error) {
        [[BaseView baseShar]dissMiss];
        [BaseView _init:@"亲网络异常请稍后" View:SelfWeek.view];
    }];
}

- (IBAction)selectNumber1:(id)sender {
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
    formSelectTableView.formSelectArray=nil;
    Arraykeys=[[NSMutableArray alloc]init];
    Arrayvalues=[[NSMutableArray alloc]init];
    ArrayZongdi = [[NSMutableArray alloc]init];
    ArrayAll = [[NSMutableArray alloc]init];
    integerTag = 1000;
    [self netSysData:1 andTag:integerTag  andName:[super replaceString:secarchName]];
    [[BaseView baseShar]_initPop:formSelectView Type:1];
    formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
        _searchBar.text = @"";
        secarchName = @"";
        _searchBar.showsCancelButton = NO;
        [_searchBar resignFirstResponder];
        groundBuildingListModel.楼栋名称 = [Arraykeys objectAtIndex:Index];
        groundBuildingListModel.楼栋编号 = [Arrayvalues objectAtIndex:Index];
        groundBuildingListModel.楼层 = [ArrayZongdi objectAtIndex:Index];
        
        textField1.text = selectStr;
        textField2.text = [ArrayZongdi objectAtIndex:Index];
    };
}

- (IBAction)selectNumber2:(id)sender {
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
    if (textField2.text.length<1) {
        ALERT(@"", @"请先选择楼栋", @"确定");
        return;
    }
    formSelectTableView.formSelectArray=nil;
    Arraykeys=[[NSMutableArray alloc]init];
    Arrayvalues=[[NSMutableArray alloc]init];
    integerTag = 1001;
    [self netSysData:1 andTag:integerTag andName:[super replaceString:secarchName]];
    [[BaseView baseShar]_initPop:formSelectView Type:1];
    formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
        _searchBar.text = @"";
        secarchName = @"";
        _searchBar.showsCancelButton = NO;
        [_searchBar resignFirstResponder];
        groundBuildingListModel.系统楼层=[Arrayvalues objectAtIndex:Index];
        groundBuildingListModel.系统房号 = selectStr;
        textField3.text = selectStr;
        textField4.text = [Arrayvalues objectAtIndex:Index];
    };
}

//获取系统楼盘编号和系统楼盘名称
-(void)netSysData:(int)page andTag:(NSInteger)integerInt andName:(NSString *)name{
    
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",page],@"pageNo",@"10",@"pageSize", nil];
    if (integerInt == 1000) {
        [dict setObject:@"local" forKey:@"dateType"];
        [dict setObject:@"industryLouceng" forKey:@"makeType"];
        [dict setObject:name forKey:@"budingName"];
        if (self.taskId.length>1) {
            [dict setObject:self.taskId forKey:@"taskId"];
        }
        if (groundBuildingListModel.楼栋编号) {
            [dict setObject:[super replaceString:groundBuildingListModel.楼栋编号] forKey:@"budingNo"];
        }
        
        [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getLouceng.chtml" success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            
            [SelfWeek tableviewEnd];
            GongyeZongdiModel *systemModel = [[GongyeZongdiModel alloc]initWithDictionary:responseObject error:nil];
            if (systemModel) {
                if ([systemModel.status isEqualToString:@"1"]) {
                    if (page==1) {
                        [Arraykeys removeAllObjects];
                        [Arrayvalues removeAllObjects];
                        [ArrayZongdi removeAllObjects];
                        [ArrayAll removeAllObjects];
                    }
                    for (GongyeZongdiListModel *systemListModel in systemModel.list) {
                        [ArrayAll addObject:[NSString stringWithFormat:@"%@  %@层",systemListModel.楼栋名称,systemListModel.楼层]];
                        [Arraykeys addObject:systemListModel.楼栋名称];
                        [Arrayvalues addObject:systemListModel.楼栋编号];
                        [ArrayZongdi addObject:systemListModel.楼层];
                    }
                    formSelectTableView.formSelectArray=ArrayAll;
                }
            }
            
        } failure:^(NSError *error) {
            [SelfWeek tableviewEnd];
        }];
    }else{
        [dict setObject:@"system" forKey:@"dateType"];
        [dict setObject:@"industryFangwu" forKey:@"makeType"];
        [dict setObject:[super replaceString:groundBuildingListModel.楼栋编号] forKey:@"budingNo"];
        [dict setObject:[super replaceString:textField2.text] forKey:@"louCengNo"];
        [dict setObject:name forKey:@"fwNo"];
        if (self.taskId.length>1) {
            [dict setObject:self.taskId forKey:@"taskId"];
        }
        [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getFangwu.chtml" success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            
            [SelfWeek tableviewEnd];
            GongyeZongdiModel *systemModel = [[GongyeZongdiModel alloc]initWithDictionary:responseObject error:nil];
            if (systemModel) {
                if ([systemModel.status isEqualToString:@"1"]) {
                    if (page==1) {
                        [Arraykeys removeAllObjects];
                        [Arrayvalues removeAllObjects];
                    }
                    for (GongyeZongdiListModel *systemListModel in systemModel.list) {
                        [Arraykeys addObject:systemListModel.房号];
                        [Arrayvalues addObject:systemListModel.系统楼层];
                    }
                    formSelectTableView.formSelectArray=Arraykeys;
                }
            }
            
        } failure:^(NSError *error) {
            [SelfWeek tableviewEnd];
        }];
    }
    
}
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        _searchBar.showsCancelButton = NO;
        [formSelectView addSubview:_searchBar];
    }
    return _searchBar;
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        secarchName = @"";
    }else {
        secarchName = searchText;
    }
    
    [self netSysData:1 andTag:integerTag andName:secarchName];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:0.3 animations:^{
        _searchBar.showsCancelButton = YES;
    }];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _searchBar.showsCancelButton = NO;
    [_searchBar resignFirstResponder];
    _searchBar.text = @"";
    secarchName = @"";
    [self netSysData:1 andTag:integerTag andName:secarchName];
}
-(void)tableviewEnd{
    [formSelectTableView.mj_header endRefreshing];
    [formSelectTableView.mj_footer endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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
