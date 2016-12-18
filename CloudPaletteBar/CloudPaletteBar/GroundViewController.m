//
//  GroundViewController.m
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/8/25.
//  Copyright © 2016年 test. All rights reserved.
//

#import "GroundViewController.h"
#import "GroundModel.h"
#import "MHDatePicker.h"
#import "SaveModel.h"
#import "FormSelectTableView.h"
#import "GongyeZongdiModel.h"
#import "MJRefresh.h"
#import "LowPropertyNameView.h"


@interface GroundViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UISearchBarDelegate>
{
    FormSelectTableView *formSelectTableView;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    NSMutableArray *groundArray;
    GroundListModel *groundListModel;
    MHDatePicker *_selectDatePicker;
    NSString *look;
    
    __weak IBOutlet UITextField *textField1;
    __weak IBOutlet UITextField *textField2;
    __weak IBOutlet UITextField *textField3;
    __weak IBOutlet UITextField *textField4;
    __weak IBOutlet UITextField *textField5;
    __weak IBOutlet UITextField *textField6;
    __weak IBOutlet UITextField *textField7;
    __weak IBOutlet UITextField *textField8;
    
    __weak IBOutlet UIButton *button1;
    __weak IBOutlet UIButton *button2;
    NSString *secarchName;
    UIView *formSelectView;
}
@property (nonatomic ,strong)UISearchBar *searchBar;

@end

@implementation GroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _strId = [kUserDefaults objectForKey:@"industryId"];
    _taskId = [kUserDefaults objectForKey:@"taskIdIndustry"];
    groundArray = [NSMutableArray arrayWithCapacity:1];
    
    look = [kUserDefaults objectForKey:@"工业查看"];
    if ([look isEqualToString:@"工业查看"]) {
        button2.hidden = YES;
    }
    
    self.contentView.frame = CGRectMake(0, 0, MainScreenWidth, self.contentView.frame.size.height);
    [self.groundScrollView addSubview:self.contentView];
    self.groundScrollView.contentSize = CGSizeMake(0, 480);
    
    [self kNetworkListMake];
    
    formSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-150)];
    self.searchBar.frame = CGRectMake(0, 0, screen_width, 50.0);
    formSelectTableView=[[FormSelectTableView alloc]initWithFrame:CGRectMake(0, 50, screen_width, formSelectView.frame.size.height-50)];
    [formSelectView addSubview:formSelectTableView];
    __weak typeof(self)SelfWeak=self;
    [formSelectTableView _initOrderUP:^(int Page) {
        [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
    } Down:^(int Page) {
        [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
    }];
    
    [self layerView:button1];
    [self layerView:button2];
    
    textField1.text = userNameDefaults;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
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
    if (self.selectIndex==0) {
        if (self.taskId.length>1) {
            if (self.strId.length>1){
                dcit = @{@"makeType":@"industryZongdi",@"ID":self.strId,@"taskId":self.taskId};
            }else{
                dcit = @{@"makeType":@"industryZongdi",@"taskId":self.taskId};
            }
        }else if (self.strId.length>1){
            dcit = @{@"makeType":@"industryZongdi",@"ID":self.strId};
        }else{
            dcit = @{@"makeType":@"industryZongdi"};
        }
    }else{
        dcit = @{@"ID":@"0"};
    }
    __weak typeof(self)SelfWeek=self;
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dcit relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        GroundModel *groundModel = [[GroundModel alloc]initWithDictionary:responseObject error:nil];
        if (groundModel) {
            [groundArray addObjectsFromArray:groundModel.list];
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
        [SelfWeek _initObject];
    }];
}

-(void)_initObject{
    groundListModel = [[GroundListModel alloc]init];
}

-(void)loadData{
    groundListModel = [groundArray objectAtIndex:0];

    textField2.text = [super replaceString:groundListModel.调查时间];
    textField3.text = [super replaceString:groundListModel.宗地编号];
    textField4.text = [super replaceString:groundListModel.行政区];
    textField5.text = [super replaceString:groundListModel.街道办];
    textField6.text = [super replaceString:groundListModel.标准分区];
    textField7.text = [super replaceString:groundListModel.组别名称];
    textField8.text = [super replaceString:groundListModel.备注];
}

-(IBAction)timePicker:(UIButton *)sender{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    _selectDatePicker = [[MHDatePicker alloc] init];
    _selectDatePicker.isBeforeTime = YES;
    _selectDatePicker.datePickerMode = UIDatePickerModeDate;
    
    [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
        
        NSString *timeStr = [NSString stringWithFormat:@"%@",selectedDate];
        NSLog(@"%@",timeStr);
        textField2.text = [timeStr substringToIndex:10];
        groundListModel.调查时间 = textField2.text;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 700:{
            groundListModel.调查人 = textField.text;
        }
            break;
        case 702:{
            groundListModel.宗地编号 = textField.text;
        }
            break;
        case 703:{
            groundListModel.行政区 = textField.text;
        }
            break;
        case 704:{
            groundListModel.街道办 = textField.text;
        }
            break;
        case 705:{
            groundListModel.标准分区 = textField.text;
        }
            break;
        case 706:{
           groundListModel.组别名称 = textField.text;
        }
            break;
        case 707:{
            groundListModel.备注 = textField.text;
        }
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//保存按钮。
- (IBAction)saveButton:(UIButton *)sender {
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
    if (!(groundListModel.调查时间.length>1)) {
        [BaseView _init:@"请选择调查时间" View:self.view];
    }else if (!(groundListModel.宗地编号.length>0)){
        [BaseView _init:@"请选择宗地编号" View:self.view];
    }else{
        [self kNetworkListMake2];
    }
}
-(void)kNetworkListMake2{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:groundListModel.toDictionary];
    [dict setObject:@"industryZongdi" forKey:@"makeType"];
    if (self.taskId.length>1) {
        [dict setObject:self.taskId forKey:@"taskId"];
    }else if (self.strId.length>1){
        [dict setObject:self.strId forKey:@"id"];
    }
    
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"保存中..."];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appAction!saveMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        SaveModel *saveModel=[[SaveModel alloc]initWithDictionary:responseObject error:nil];
        if (saveModel) {
            if ([saveModel.status isEqualToString:@"1"]) {
                NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:[super replaceString:groundListModel.宗地编号],@"宗地编号", nil];
                //创建通知
                NSNotification *notification =[NSNotification notificationWithName:@"宗地编号" object:nil userInfo:dict];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                groundListModel.ID = saveModel.ID;
                [BaseView _init:saveModel.message View:SelfWeek.view];
                [kUserDefaults setObject:saveModel.ID forKey:@"industryId"];
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
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
    formSelectTableView.formSelectArray=nil;
    Arraykeys=[[NSMutableArray alloc]init];
    Arrayvalues=[[NSMutableArray alloc]init];
    [self netSysData:1 andName:[super replaceString:secarchName]];

    [[BaseView baseShar]_initPop:formSelectView Type:1];
    formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
        _searchBar.text = @"";
        secarchName = @"";
        _searchBar.showsCancelButton = NO;
        [_searchBar resignFirstResponder];
        GongyeZongdiListModel *systemListModel = [Arrayvalues objectAtIndex:Index];
        groundListModel.宗地编号 = systemListModel.宗地编号;
        groundListModel.行政区 = systemListModel.行政区;
        groundListModel.街道办 = systemListModel.街道办;
        groundListModel.组别名称 = systemListModel.组别名称;
        groundListModel.标准分区 = systemListModel.标准分区;
        textField3.text = systemListModel.宗地编号;
        textField4.text = systemListModel.行政区;
        textField5.text = systemListModel.街道办;
        textField6.text = systemListModel.标准分区;
        textField7.text = systemListModel.组别名称;
        
    };
}
//获取系统楼盘编号和系统楼盘名称
-(void)netSysData:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSDictionary *dict;
    if (self.taskId.length>1) {
        dict =@{@"makeType":@"industryZongdi",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"taskId":self.taskId,@"zingdiNo":name};
    }else{
        dict = @{@"makeType":@"industryZongdi",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"zingdiNo":name};
    }
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getZongdi.chtml" success:^(id responseObject) {
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
                    [ Arraykeys addObject:[NSString stringWithFormat:@"%@  %@",systemListModel.宗地编号,systemListModel.BLDG_NAME_NO]];
                }
                formSelectTableView.formSelectArray=Arraykeys;
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
    
    [self netSysData:1 andName:secarchName];
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
