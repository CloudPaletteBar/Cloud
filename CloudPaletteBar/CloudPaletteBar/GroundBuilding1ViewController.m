//
//  GroundBuilding1ViewController.m
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/8/25.
//  Copyright © 2016年 test. All rights reserved.
//

#import "GroundBuilding1ViewController.h"
#import "GroundBuilding1Model.h"
#import "SaveModel.h"
#import "FormSelectTableView.h"
#import "MJRefresh.h"
#import "LowPropertyNameView.h"
#import "GongyeZongdiModel.h"
#import "zySheetPickerView.h"


@interface GroundBuilding1ViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UISearchBarDelegate>
{
    FormSelectTableView *formSelectTableView;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    NSMutableArray *ArrayZongdi;
    NSString *zongdiHaoStr;
    NSInteger integerTag;
    NSMutableArray *buildingArray;
    GroundBuilding1ListModel *groundBuildingListModel;
    NSMutableArray *groundArray1, *groundArray2;
    NSString *look;
    
    __weak IBOutlet UITextField *textField1;
//    __weak IBOutlet UITextField *textField2;
    __weak IBOutlet UITextField *textField3;
    __weak IBOutlet UITextField *textField4;
    __weak IBOutlet UITextField *textField5;
    __weak IBOutlet UITextField *textField6;
    __weak IBOutlet UITextField *textField7;
    __weak IBOutlet UITextField *textField8;
    __weak IBOutlet UITextField *textField9;
    __weak IBOutlet UITextField *textField10;
    __weak IBOutlet UITextField *textField11;
    __weak IBOutlet UITextField *textField12;
    __weak IBOutlet UITextField *textField13;
    __weak IBOutlet UITextField *textField14;
    
    
    __weak IBOutlet UIButton *button1;
    __weak IBOutlet UIButton *button2;
    __weak IBOutlet UIButton *button3;
    NSString *secarchName;
    UIView *formSelectView;

}
@property (nonatomic ,strong)UISearchBar *searchBar;
@end

@implementation GroundBuilding1ViewController

- (void)yanquN:(NSNotification *)text{
    textField1.text=text.userInfo[@"园区名称"];
    zongdiHaoStr=text.userInfo[@"宗地号"];
    groundBuildingListModel.工业园名称=text.userInfo[@"园区名称"];
    groundBuildingListModel.宗地号=text.userInfo[@"宗地号"];
    groundBuildingListModel.工业园ID=text.userInfo[@"ID"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yanquN:) name:@"园区名称" object:nil];
    _strId = [kUserDefaults objectForKey:@"industryId"];
    _taskId = [kUserDefaults objectForKey:@"taskIdIndustry"];
    buildingArray = [NSMutableArray arrayWithCapacity:1];
    
    look = [kUserDefaults objectForKey:@"工业查看"];
    if ([look isEqualToString:@"工业查看"]) {
        button3.hidden = YES;
    }
    
    self.contentView.frame = CGRectMake(0, 0, MainScreenWidth, self.contentView.frame.size.height);
    [self.buil1ScrollView addSubview:self.contentView];
    self.buil1ScrollView.contentSize = CGSizeMake(0, 480);
    
    [self kNetworkListMake];
    
    [self layerView:button1];
    [self layerView:button2];
    [self layerView:button3];
    
    formSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-150)];
    self.searchBar.frame = CGRectMake(0, 0, screen_width, 50.0);
    formSelectTableView=[[FormSelectTableView alloc]initWithFrame:CGRectMake(0, 50, screen_width, formSelectView.frame.size.height-50)];
    [formSelectView addSubview:formSelectTableView];
    __weak typeof(self)SelfWeak=self;
    [formSelectTableView _initOrderUP:^(int Page) {
        [SelfWeak netSysData:Page andTag:integerTag andName:[super replaceString:secarchName]];
    } Down:^(int Page) {
        [SelfWeak netSysData:Page andTag:integerTag andName:[super replaceString:secarchName]];
    }];
}

-(void)layerView:(UIView *)view{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0;
}

-(void)kNetworkListMake{
    NSDictionary *dcit;
    if (self.selectIndex==2) {
        if (self.taskId) {
            if (self.strId.length>1) {
                dcit = @{@"makeType":@"industryLoupan",@"ID":self.strId,@"taskId":self.taskId};
            }else{
                dcit = @{@"makeType":@"industryLoupan",@"taskId":self.taskId};
            }
        }else if (self.strId){
            dcit = @{@"makeType":@"industryLoupan",@"ID":self.strId};
        }else{
            dcit = @{@"makeType":@"industryLoupan"};
        }
    }else{
        dcit = @{@"ID":@"0"};
    }
    __weak typeof(self)SelfWeek=self;
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dcit relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        GroundBuilding1Model *groundBuildingModel = [[GroundBuilding1Model alloc]initWithDictionary:responseObject error:nil];
        if (groundBuildingModel) {
            [buildingArray addObjectsFromArray:groundBuildingModel.list];
        }else{
            [BaseView _init:@"亲你的网络不给力哦" View:SelfWeek.view];
        }
        if (buildingArray.count>0) {
            [SelfWeek loadData];
        }else{
            [SelfWeek _initObject];
        }
    } failure:^(NSError *error) {
        [BaseView _init:@"亲网络异常请稍后" View:SelfWeek.view];
        [SelfWeek _initObject];
    }];
}

-(void)_initObject{
    groundBuildingListModel = [[GroundBuilding1ListModel alloc]init];
    groundArray1 = [NSMutableArray arrayWithCapacity:1];
    groundArray2 = [NSMutableArray arrayWithCapacity:1];
}

-(void)loadData{
    groundBuildingListModel = [buildingArray objectAtIndex:0];

    textField1.text = [super replaceString:groundBuildingListModel.工业园名称];
    groundBuildingListModel.工业园ID = [super replaceString:[kUserDefaults objectForKey:@"industryId"]];
    textField3.text = [super replaceString:groundBuildingListModel.系统楼盘名称];
    textField4.text = [super replaceString:groundBuildingListModel.实际楼盘名称];
    textField5.text = [super replaceString:groundBuildingListModel.楼盘别名];
    
    groundArray1 = [NSMutableArray arrayWithArray:[self array:[super replaceString:groundBuildingListModel.地理位置1]]];
    switch (groundArray1.count) {
        case 1:
            textField6.text = [groundArray1 objectAtIndex:0];
            break;
        case 2:
            textField6.text = [groundArray1 objectAtIndex:0];
            textField7.text = [groundArray1 objectAtIndex:1];
            break;
        case 3:
            textField6.text = [groundArray1 objectAtIndex:0];
            textField7.text = [groundArray1 objectAtIndex:1];
            textField8.text = [groundArray1 objectAtIndex:2];
            break;
    }

    groundArray2 = [NSMutableArray arrayWithArray:[self array:[super replaceString:groundBuildingListModel.地理位置2]]];
    switch (groundArray2.count) {
        case 1:
            textField9.text = [groundArray2 objectAtIndex:0];
            break;
        case 2:
            textField9.text = [groundArray2 objectAtIndex:0];
            textField10.text = [groundArray2 objectAtIndex:1];
            break;
        case 3:
            textField9.text = [groundArray2 objectAtIndex:0];
            textField10.text = [groundArray2 objectAtIndex:1];
            textField11.text = [groundArray2 objectAtIndex:2];
            break;
    }
    
    textField12.text = [super replaceString:groundBuildingListModel.总楼栋数];
    textField13.text = [super replaceString:groundBuildingListModel.开发商];
    textField14.text = [super replaceString:groundBuildingListModel.备注];
}

-(NSArray *)array:(NSString *)str{
    NSArray *strArray;
    if (str.length>1) {
        strArray = [str componentsSeparatedByString:@","];
        return strArray;
    }
    return strArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clickArray:(NSArray *)array andTag:(int)tagInt{
    zySheetPickerView *pickerView = [zySheetPickerView ZYSheetStringPickerWithTitle:array andHeadTitle:@"" Andcall:^(zySheetPickerView *pickerView, NSString *choiceString) {
        if ([choiceString isEqualToString:@"请选择"]) {
            choiceString = @"";
        }
        switch (tagInt) {
            case 705:
                [self repn:choiceString Index:0 Datas:groundArray1];
                textField6.text = choiceString;
                break;
            case 708:
                [self repn:choiceString Index:0 Datas:groundArray2];
                textField9.text = choiceString;
                break;
        }
        [pickerView dismissPicker];
    }];
    [pickerView show];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 705:{
            NSArray *array = @[@"请选择",@"罗湖",@"福田",@"南山",@"龙华新区",@"龙岗",@"宝安",@"盐田",@"坪山新区",@"光明新区",@"大鹏新区"];
            [self clickArray:array andTag:705];
            return NO;
        }
            break;
        case 708:{
            NSArray *array = @[@"请选择",@"罗湖",@"福田",@"南山",@"龙华新区",@"龙岗",@"宝安",@"盐田",@"坪山新区",@"光明新区",@"大鹏新区"];
            [self clickArray:array andTag:708];
            return NO;
        }
            break;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (textField.tag) {
        case 700:{
            groundBuildingListModel.工业园名称 = textField.text;
        }
            break;
        case 701:{
            groundBuildingListModel.系统楼盘编号 = textField.text;
        }
            break;
        case 702:{
            groundBuildingListModel.系统楼盘名称 = textField.text;
        }
            break;
        case 703:{
            groundBuildingListModel.实际楼盘名称 = textField.text;
        }
            break;
        case 704:{
            groundBuildingListModel.楼盘别名 = textField.text;
        }
            break;
        case 706:{
            [self repn:textField.text Index:1 Datas:groundArray1];
        }
            break;
        case 707:{
            [self repn:textField.text Index:2 Datas:groundArray1];
        }
            break;
        case 709:{
            [self repn:textField.text Index:1 Datas:groundArray2];
        }
            break;
        case 710:{
            [self repn:textField.text Index:2 Datas:groundArray2];
        }
            break;
        case 711:{
            groundBuildingListModel.总楼栋数 = textField.text;
        }
            break;
        case 712:{
            groundBuildingListModel.开发商 = textField.text;
        }
            break;
        case 713:{
            groundBuildingListModel.备注 = textField.text;
        }
            break;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//        替换数据的数据跟新数组
-(void)repn:(NSString *)str Index:(NSInteger)index Datas:(NSMutableArray *)datas{
    //    如果数组长度大于index就替换小于就添加
    if (datas.count>index) {
        [datas replaceObjectAtIndex:index withObject:str];
    }else{
        [datas addObject:str];
        //        防止角标越界
        [datas addObject:@""];
        [datas addObject:@""];
    }
}

//保存按钮。
- (IBAction)saveButton:(UIButton *)sender {
    __block int count1 = 0;
    __block int count2 = 0;
    
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
    groundBuildingListModel.地理位置1=[NetworkManager Datastrings:groundArray1];
    groundBuildingListModel.地理位置2=[NetworkManager Datastrings:groundArray2];
    
    [groundArray1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        count1 ++ ;
        if ([obj isEqual:@""]) {
            count1--;
        }
    }];
    [groundArray2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        count2 ++ ;
        if ([obj isEqual:@""]) {
            count2--;
        }
    }];
    
    if (!(groundBuildingListModel.工业园名称.length>0)) {
        [BaseView _init:@"请选择工业园名称" View:self.view];
    }else if (!(groundBuildingListModel.实际楼盘名称.length>0)){
        [BaseView _init:@"请填写实际楼盘名称" View:self.view];
    }else if (count1 != 3 && count2 != 3){
        [BaseView _init:@"请输入任意一个完整的地理位置信息" View:self.view];
    }else if (!(groundBuildingListModel.总楼栋数.length>0)){
        [BaseView _init:@"请输入总楼栋数" View:self.view];
    }else{
        [self kNetworkListMake2];
    }
}
-(void)kNetworkListMake2{
    groundBuildingListModel.地理位置2 = [NetworkManager Datastrings:groundArray2];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:groundBuildingListModel.toDictionary];
    [dict setObject:@"industryLoupan" forKey:@"makeType"];
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
                [kUserDefaults setObject:saveModel.ID forKey:@"industryId"];
                groundBuildingListModel.ID = saveModel.ID;
                if ([look isEqualToString:@"工业新增"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"gongYelouPanTolouDong" object:@{@"宗地号":[super replaceString:groundBuildingListModel.宗地号],@"实际楼盘名称":[super replaceString:textField4.text]}];
                    
                    UIScrollView *scrollView=(UIScrollView *)self.view.superview;
                    CGFloat offsetX = scrollView.contentOffset.x + scrollView.frame.size.width;
                    offsetX = (int)(offsetX/MainScreenWidth) * MainScreenWidth;
                    [scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
                    
                }
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
    integerTag = 1000;
    [self netSysData:1 andTag:integerTag andName:[super replaceString:secarchName]];
    [[BaseView baseShar]_initPop:formSelectView Type:1];
    formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
        _searchBar.text = @"";
        secarchName = @"";
        _searchBar.showsCancelButton = NO;
        [_searchBar resignFirstResponder];
        GongyeZongdiListModel *systemListModel = [Arrayvalues objectAtIndex:Index];
        groundBuildingListModel.工业园名称 = systemListModel.园区名称;
        groundBuildingListModel.工业园ID = systemListModel.ID;
        zongdiHaoStr = systemListModel.宗地号;
        groundBuildingListModel.宗地号=zongdiHaoStr;
        textField1.text = systemListModel.园区名称;
    };
}

- (IBAction)selectNumber2:(id)sender {
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
    if (zongdiHaoStr.length<1) {
        ALERT(@"", @"请先选择工业园", @"确定");
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
        groundBuildingListModel.系统楼盘名称=[NetworkManager interceptStrTo:selectStr PleStr:@" "];
        groundBuildingListModel.系统楼盘编号 = [Arrayvalues objectAtIndex:Index];
//        textField2.text = [Arrayvalues objectAtIndex:Index];
        textField3.text = groundBuildingListModel.系统楼盘名称;
    };
}

//获取系统楼盘编号和系统楼盘名称
-(void)netSysData:(int)page andTag:(NSInteger)integerInt andName:(NSString *)name{
    
    __weak typeof(self)SelfWeek=self;
    NSDictionary *dict;
    if (integerInt == 1000) {
        if (self.taskId.length>0) {
            dict = @{@"makeType":@"industryGongyeyuan",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"taskId":self.taskId,@"gongyyName":name} ;
        }else{
            dict = @{@"makeType":@"industryGongyeyuan",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"gongyyName":name};
        }
        [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getGongyeyuan.chtml" success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            
            [SelfWeek tableviewEnd];
            GongyeZongdiModel *systemModel = [[GongyeZongdiModel alloc]initWithDictionary:responseObject error:nil];
            if (systemModel) {
                if ([systemModel.status isEqualToString:@"1"]) {
                    if (page==1) {
                        [Arraykeys removeAllObjects];
                        [Arrayvalues removeAllObjects];
                    }
                    [Arrayvalues addObjectsFromArray:systemModel.list];
                    for (GongyeZongdiListModel *systemListModel in systemModel.list) {
                        [Arraykeys addObject:[NSString stringWithFormat:@"%@ %@",systemListModel.宗地号,systemListModel.园区名称]];
                    }
                    formSelectTableView.formSelectArray=Arraykeys;
                }
            }
            
        } failure:^(NSError *error) {
            [SelfWeek tableviewEnd];
        }];
    }else{
        if (self.taskId.length>1) {
            dict = @{@"makeType":@"industryLoupan",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"louPanName":name,@"zongdiNo":zongdiHaoStr,@"taskId":self.taskId};
        }else{
            dict = @{@"makeType":@"industryLoupan",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"louPanName":name,@"zongdiNo":zongdiHaoStr};
        }
        [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getLoupan.chtml" success:^(id responseObject) {
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
                        [Arraykeys addObject:[NSString stringWithFormat:@"%@ %@",systemListModel.系统楼盘名称,systemListModel.楼栋名称]];
                        [Arrayvalues addObject:systemListModel.系统楼盘编号];
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
