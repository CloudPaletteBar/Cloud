//
//  GroundBuilding3ViewController.m
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/8/25.
//  Copyright © 2016年 test. All rights reserved.
//

#import "GroundBuilding3ViewController.h"
#import "GroundBuilding3Model.h"
#import "SaveModel.h"
#import "zySheetPickerView.h"
#import "FormSelectTableView.h"
#import "GongyeZongdiModel.h"
#import "MJRefresh.h"
#import "LowPropertyNameView.h"


@interface GroundBuilding3ViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UISearchBarDelegate>
{
    FormSelectTableView *formSelectTableView;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    NSMutableArray *groundArray;
    GroundBuilding3ListModel *groundBuildingListModel;
    NSString *look;
    NSString *gongyeLouPan;
    NSMutableArray *louCengArray;
    NSInteger viewTag;
    
    __weak IBOutlet UIButton *button7;
    __weak IBOutlet UITextField *textField1;
    __weak IBOutlet UITextField *textField2;
    __weak IBOutlet UITextField *textField3;
    __weak IBOutlet UITextField *textField4;
    __weak IBOutlet UITextField *textField5;
    
    __weak IBOutlet UIButton *button1;
    __weak IBOutlet UIButton *button2;
    __weak IBOutlet UIButton *button3;
    
    __weak IBOutlet UISegmentedControl *segmented;
    NSString *secarchName;
    UIView *formSelectView;
}
@property (nonatomic ,strong)UISearchBar *searchBar;
@end

@implementation GroundBuilding3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gongYelouDongTolouCeng:) name:@"gongYelouDongTolouCeng" object:nil];
    
    _strId = [kUserDefaults objectForKey:@"industryId"];
    _taskId = [kUserDefaults objectForKey:@"taskIdIndustry"];
    groundArray = [NSMutableArray arrayWithCapacity:1];
    
    look = [kUserDefaults objectForKey:@"工业查看"];
    if ([look isEqualToString:@"工业查看"]) {
        button3.hidden = YES;
    }
    
    self.contentView.frame = CGRectMake(0, 0, MainScreenWidth, self.contentView.frame.size.height);
    [self.buil3ScrollView addSubview:self.contentView];
    self.buil3ScrollView.contentSize = CGSizeMake(0, 480);
    
    [self kNetworkListMake];
    
    formSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-150)];
    self.searchBar.frame = CGRectMake(0, 0, screen_width, 50.0);
    formSelectTableView=[[FormSelectTableView alloc]initWithFrame:CGRectMake(0, 50, screen_width, formSelectView.frame.size.height-50)];
    [formSelectView addSubview:formSelectTableView];
    __weak typeof(self)SelfWeak=self;
    [formSelectTableView _initOrderUP:^(int Page) {
        if (viewTag==3000) {
            [SelfWeak netSysData1:Page andName:[super replaceString:secarchName]];
        }else
        [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
    } Down:^(int Page) {
        if (viewTag==3000) {
            [SelfWeak netSysData1:Page andName:[super replaceString:secarchName]];
        }else
            [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
    }];
    
    [self layerView:button1];
    [self layerView:button2];
    [self layerView:button3];
    [self layerView:button7];
}

-(void)gongYelouDongTolouCeng:(NSNotification *)sender{
    textField1.text = [[sender object]objectForKey:@"工业楼栋"];
    groundBuildingListModel.楼栋名称 = textField1.text;
    groundBuildingListModel.楼栋编号 = [[sender object]objectForKey:@"工业楼栋编号"];
    gongyeLouPan = [[sender object]objectForKey:@"工业楼盘"];
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
    if (self.selectIndex==4) {
        if (self.taskId) {
            if (self.strId.length>1) {
                dcit = @{@"makeType":@"industryLouceng",@"ID":self.strId,@"taskId":self.taskId};
            }else{
                dcit = @{@"makeType":@"industryLouceng",@"taskId":self.taskId};
            }
        }else if (self.strId){
            dcit = @{@"makeType":@"industryLouceng",@"ID":self.strId};
        }else{
            dcit = @{@"makeType":@"industryLouceng"};
        }
    }else{
        dcit = @{@"ID":@"0"};
    }
    __weak typeof(self)SelfWeek=self;
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dcit relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);

        GroundBuilding3Model *groundBuildingModel = [[GroundBuilding3Model alloc]initWithDictionary:responseObject error:nil];
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
    groundBuildingListModel = [[GroundBuilding3ListModel alloc]init];
    groundBuildingListModel.是否首层 = @"是";
    groundBuildingListModel.数据来源 = @"业主/租户";
}

-(void)loadData{
    groundBuildingListModel = [groundArray objectAtIndex:0];

    textField1.text = [super replaceString:groundBuildingListModel.楼栋名称];
    textField2.text = [super replaceString:groundBuildingListModel.楼层];
    textField3.text = [super replaceString:groundBuildingListModel.租金];
    textField4.text = [super replaceString:groundBuildingListModel.层高];
    textField5.text = [super replaceString:groundBuildingListModel.备注];
    
    NSString *str = [super replaceString:groundBuildingListModel.是否首层];
    if ([str isEqualToString:@"是"]) {
        segmented.selectedSegmentIndex = 0;
    }else{
        segmented.selectedSegmentIndex = 1;
    }
    
    NSString *str2 = [super replaceString:groundBuildingListModel.数据来源];
    if (str2.length>0) {
        [button2 setTitle:str2 forState:UIControlStateNormal];
    }
}

- (IBAction)selectSegmented:(UISegmentedControl *)sender {
    NSInteger index=sender.selectedSegmentIndex;
    NSString *str = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    NSLog(@"%ld----%@",index,str);
    groundBuildingListModel.是否首层 = str;

}

- (IBAction)selectButton:(UIButton *)sender {
    switch (sender.tag) {
        case 501:{
            NSArray *array = @[@"业主/租户",@"中介",@"网络查询",@"估计",@"其他"];
            [self clickArray:array andTag:501];
        }
            break;
    }
}
-(void)clickArray:(NSArray *)array andTag:(int)tagInt{
    zySheetPickerView *pickerView = [zySheetPickerView ZYSheetStringPickerWithTitle:array andHeadTitle:@"" Andcall:^(zySheetPickerView *pickerView, NSString *choiceString) {
        
        if (tagInt == 501) {
            [button2 setTitle:choiceString forState:UIControlStateNormal];
            groundBuildingListModel.数据来源 = choiceString;
        }
        [pickerView dismissPicker];
    }];
    [pickerView show];
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
            groundBuildingListModel.租金 = textField.text;
        }
            break;
        case 703:{
            groundBuildingListModel.层高 = textField.text;
        }
            break;
        case 704:{
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
    }else if (!(groundBuildingListModel.楼层.length>0)){
        [BaseView _init:@"请填写楼层" View:self.view];
    }else if (!(groundBuildingListModel.租金.length>0)){
        [BaseView _init:@"请填写租金" View:self.view];
    }else if (!(groundBuildingListModel.层高.length>0)){
        [BaseView _init:@"请填写层高" View:self.view];
    }else{
        [self kNetworkListMake2];
    }
}
-(void)kNetworkListMake2{
    [kUserDefaults setObject:[super replaceString:groundBuildingListModel.楼层] forKey:@"工业楼层"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:groundBuildingListModel.toDictionary];
    [dict setObject:@"industryLouceng" forKey:@"makeType"];
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
                [kUserDefaults setObject:[super replaceString:saveModel.ID] forKey:@"industryId"];
                groundBuildingListModel.ID = saveModel.ID;
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GroundBusiness" object:nil];
                if ([look isEqualToString:@"工业新增"]) {
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

- (IBAction)selectNumber:(UIButton *)sender {
    viewTag=sender.tag;
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
    formSelectTableView.formSelectArray=nil;
    if (sender.tag==3000) {
        if (textField1.text.length<=0) {
            [BaseView _init:@"请选择楼栋" View:self.view];
            return;
        }
        louCengArray=[[NSMutableArray alloc]init];
        [self netSysData1:1 andName:[super replaceString:secarchName]];
        [[BaseView baseShar]_initPop:formSelectView Type:1];
        formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
            _searchBar.text = @"";
            secarchName = @"";
            _searchBar.showsCancelButton = NO;
            [_searchBar resignFirstResponder];
            textField2.text=selectStr;
            groundBuildingListModel.楼层 = selectStr;
        };

    }else{
        Arraykeys=[[NSMutableArray alloc]init];
        Arrayvalues=[[NSMutableArray alloc]init];
        [self netSysData:1 andName:[super replaceString:secarchName]];
        [[BaseView baseShar]_initPop:formSelectView Type:1];
        formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
            _searchBar.text = @"";
            secarchName = @"";
            _searchBar.showsCancelButton = NO;
            [_searchBar resignFirstResponder];
            groundBuildingListModel.楼栋名称=selectStr;
            groundBuildingListModel.楼栋编号=[Arrayvalues objectAtIndex:Index];
            textField1.text = selectStr;
            [kUserDefaults setObject:selectStr forKey:@"工业楼栋名称"];
            [kUserDefaults setObject:[Arrayvalues objectAtIndex:Index] forKey:@"工业楼栋编号"];
        };

    }
}
//获取系统楼盘编号和系统楼盘名称
-(void)netSysData:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSDictionary *dict;
    if (self.taskId.length>1) {
        dict =@{@"makeType":@"industryBuding",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"taskId":self.taskId,@"louPanName":[super replaceString:gongyeLouPan],@"budingName":name};
    }else{
        dict = @{@"makeType":@"industryBuding",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"louPanName":[super replaceString:gongyeLouPan],@"budingName":name};
    }
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getBuding.chtml" success:^(id responseObject) {
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
                    [Arraykeys addObject:systemListModel.实际楼栋名称];
                    [Arrayvalues addObject:systemListModel.楼栋编号];
                }
                formSelectTableView.formSelectArray=Arraykeys;
            }
        }
        
    } failure:^(NSError *error) {
        [SelfWeek tableviewEnd];
    }];
}

//获取系统楼盘编号和系统楼盘名称
-(void)netSysData1:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSDictionary *dict;
    if (self.taskId.length>1) {
        dict =@{@"budingNo":[super replaceString:groundBuildingListModel.楼栋编号],@"makeType":@"industryLouceng",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"taskId":self.taskId,@"floor":name};
    }else{
        dict = @{@"budingNo":[super replaceString:groundBuildingListModel.楼栋编号],@"makeType":@"industryLouceng",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"floor":name};
    }
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getLouceng.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        [SelfWeek tableviewEnd];
        GongyeZongdiModel *systemModel = [[GongyeZongdiModel alloc]initWithDictionary:responseObject error:nil];
        if (systemModel) {
            if ([systemModel.status isEqualToString:@"1"]) {
                if (page==1) {
                    [louCengArray removeAllObjects];
                }
                for (GongyeZongdiListModel *systemListModel in systemModel.list) {
                    [louCengArray addObject:systemListModel.楼层];
                }
                formSelectTableView.formSelectArray=louCengArray;
            }
        }
        
    } failure:^(NSError *error) {
        [SelfWeek tableviewEnd];
    }];
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
    if (viewTag==3000) {
        [self netSysData1:1 andName:secarchName];
    }else
        [self netSysData:1 andName:secarchName];
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
    if (viewTag==3000) {
        [self netSysData1:1 andName:secarchName];
    }else
        [self netSysData:1 andName:secarchName];
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
