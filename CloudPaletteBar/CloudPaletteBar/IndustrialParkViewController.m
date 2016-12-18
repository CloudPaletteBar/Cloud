//
//  IndustrialParkViewController.m
//  
//
//  Created by 李卫振 on 16/8/25.
//
//

#import "IndustrialParkViewController.h"
#import "IndustrialModel.h"
#import "SaveModel.h"
#import "FormSelectTableView.h"
#import "GongyeZongdiModel.h"
#import "MJRefresh.h"
#import "LowPropertyNameView.h"

@interface IndustrialParkViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UISearchBarDelegate>
{
    FormSelectTableView *formSelectTableView;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    NSMutableArray *industrialArray;
    IndustrialListModel *industrialListModel;
    IndustrialListTypeModel *industrialListTypeModel;
    NSString *look;
    
    __weak IBOutlet UITextField *textField1;
    __weak IBOutlet UITextField *textField2;
    __weak IBOutlet UITextField *textField3;
    __weak IBOutlet UITextField *textField4;
    __weak IBOutlet UITextField *textField5;
    
    __weak IBOutlet UISegmentedControl *segmented1;
    __weak IBOutlet UISegmentedControl *segmented2;
    
    __weak IBOutlet UIButton *button1;
    __weak IBOutlet UIButton *button2;
    
    __weak IBOutlet UISwitch *switch1;
    __weak IBOutlet UISwitch *switch2;
    __weak IBOutlet UISwitch *switch3;
    __weak IBOutlet UISwitch *switch4;
    __weak IBOutlet UISwitch *switch5;
    __weak IBOutlet UISwitch *switch6;
    
    __weak IBOutlet UIView *view1;
    __weak IBOutlet UIView *view2;
    NSString *secarchName;
    UIView *formSelectView;
}
@property (nonatomic ,strong)UISearchBar *searchBar;
@end

@implementation IndustrialParkViewController

- (void)zongdiNO:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"宗地编号"]);
    textField1.text=text.userInfo[@"宗地编号"];
    industrialListModel.宗地号=textField1.text;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zongdiNO:) name:@"宗地编号" object:nil];
    _strId = [kUserDefaults objectForKey:@"industryId"];
    _taskId = [kUserDefaults objectForKey:@"taskIdIndustry"];
    industrialArray = [NSMutableArray arrayWithCapacity:1];
    
    look = [kUserDefaults objectForKey:@"工业查看"];
    if ([look isEqualToString:@"工业查看"]) {
        button2.hidden = YES;
    }
    
    self.contentView.frame = CGRectMake(0, 0, MainScreenWidth, self.contentView.frame.size.height);
    [self.industrialScrollView addSubview:self.contentView];
    self.industrialScrollView.contentSize = CGSizeMake(0, 500);
    
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
}

-(void)layerView:(UIView *)view{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0;
}

-(void)kNetworkListMake{
    NSDictionary *dcit;
    if (self.selectIndex==1) {
        if (self.taskId) {
            if (self.strId.length>1) {
                dcit = @{@"makeType":@"industryGongyeyuan",@"ID":self.strId,@"taskId":self.taskId};
            }else{
                dcit = @{@"makeType":@"industryGongyeyuan",@"taskId":self.taskId};
            }
        }else if (self.strId){
            dcit = @{@"makeType":@"industryGongyeyuan",@"ID":self.strId};
        }else{
            dcit = @{@"makeType":@"industryGongyeyuan"};
        }
    }else{
        dcit = @{@"ID":@"0"};
    }
    __weak typeof(self)SelfWeek=self;
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dcit relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        IndustrialModel *industrialModel = [[IndustrialModel alloc]initWithDictionary:responseObject error:nil];
        if (industrialModel) {
            [industrialArray addObjectsFromArray:industrialModel.list];
        }else{
            [BaseView _init:@"亲你的网络不给力哦" View:SelfWeek.view];
        }
        if (industrialArray.count>0) {
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
    industrialListModel = [[IndustrialListModel alloc]init];
    industrialListTypeModel = [[IndustrialListTypeModel alloc]init];
    industrialListModel.是否属于工业园区 = @"是";
    industrialListModel.准入条件 = @"无";
    textField4.hidden = YES;
}

-(void)loadData{
    industrialListModel = [industrialArray objectAtIndex:0];
    industrialListTypeModel = [[IndustrialListTypeModel alloc]initWithDictionary:[NetworkManager stringDictionary:industrialListModel.内部配套] error:nil];
    
    textField1.text = [super replaceString:industrialListModel.宗地号];
    
    NSString *str =[super replaceString:industrialListModel.是否属于工业园区];
    if ([str isEqualToString:@"是"]) {
        segmented1.selectedSegmentIndex = 0;
        textField2.text = [super replaceString:industrialListModel.园区名称];
        [self viewEnabled:@"是"];
    }else{
        segmented1.selectedSegmentIndex = 1;
        textField2.text = @"无";
        [self viewEnabled:@"无"];
    }
    
    textField3.text = [super replaceString:industrialListModel.园区规模];
    
    NSString *str2 = [super replaceString:industrialListModel.准入条件];
    if ([str2 isEqualToString:@"无"]) {
        textField4.hidden = YES;
        segmented2.selectedSegmentIndex = 0;
    }else{
        textField4.text = [super replaceString:industrialListModel.准入要求];
        segmented2.selectedSegmentIndex = 1;
    }
    
    textField5.text = [super replaceString:industrialListModel.备注];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"500",@"商店",@"501",@"食堂",@"502",@"办公楼",@"503",@"宿舍",@"504",@"其他",@"505",@"停车场", nil];
    NSArray *array = [self array:[super replaceString:industrialListModel.内部配套]];
    for (NSString *str in array) {
        NSString *strTag = [dict objectForKey:str];
        switch ([strTag intValue]) {
            case 500:
                [switch1 setOn:YES];
                break;
            case 501:
                [switch2 setOn:YES];
                break;
            case 502:
                [switch3 setOn:YES];
                break;
            case 503:
                [switch4 setOn:YES];
                break;
            case 504:
                [switch5 setOn:YES];
                break;
            case 505:
                [switch6 setOn:YES];
                break;
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(NSArray *)array:(NSString *)str{
    NSArray *strArray;
    if (str.length>1) {
        strArray = [str componentsSeparatedByString:@","];
        return strArray;
    }
    return strArray;
}

-(IBAction)segmentedAction:(UISegmentedControl *)Seg{
    NSInteger index=Seg.selectedSegmentIndex;
    NSString *str = [Seg titleForSegmentAtIndex:Seg.selectedSegmentIndex];
    NSLog(@"%ld----%@-----%ld",index,str,Seg.tag);
    
    switch (Seg.tag) {
        case 600:
            industrialListModel.是否属于工业园区 = str;
            if ([str isEqualToString:@"是"]) {
                textField2.text = @"";
                [self viewEnabled:@"是"];
            }else{
                textField2.text = @"无";
                [self viewEnabled:@"无"];
            }
            break;
        case 601:
            industrialListModel.准入条件 = str;
            if ([str isEqualToString:@"无"]) {
                textField4.hidden = YES;
            }else{
                textField4.hidden = NO;
            }
            break;
    }
}

-(void)viewEnabled:(NSString *)str{
    if ([str isEqualToString:@"是"]) {
        for (UIView* subView in view1.subviews){
            if ([subView isKindOfClass:[UISegmentedControl class]]&&subView.tag==601){
                segmented2.enabled = YES;
            }else if([subView isKindOfClass:[UITextField class]]){
                UITextField *textFie = (UITextField *)subView;
                textFie.enabled = YES;
            }
        }
        for (UIView* subView in view2.subviews){
            if ([subView isKindOfClass:[UISwitch class]]){
                UISwitch *switchV = (UISwitch *)subView;
                switchV.enabled = YES;
            }else if([subView isKindOfClass:[UITextField class]]){
                textField5.enabled = YES;
            }
        }
    }else{
        for (UIView* subView in view1.subviews){
            if ([subView isKindOfClass:[UISegmentedControl class]]&&subView.tag==601){
                segmented2.enabled = NO;
            }else if([subView isKindOfClass:[UITextField class]]){
                UITextField *textFie = (UITextField *)subView;
                textFie.enabled = NO;
            }
        }
        for (UIView* subView in view2.subviews){
            if ([subView isKindOfClass:[UISwitch class]]){
                UISwitch *switchV = (UISwitch *)subView;
                switchV.enabled = NO;
            }else if([subView isKindOfClass:[UITextField class]]){
                textField5.enabled = NO;
            }
        }
    }
}

- (IBAction)selectSwitch:(UISwitch *)sender {
    switch (sender.tag) {
        case 500:
            if ([sender isOn]) {
                industrialListTypeModel.商店 = @"商店";
            }else{
                industrialListTypeModel.商店 = @"";
            }
            break;
        case 501:
            if ([sender isOn]) {
                industrialListTypeModel.食堂 = @"食堂";
            }else{
                industrialListTypeModel.食堂 = @"";
            }
            break;
        case 502:
            if ([sender isOn]) {
                industrialListTypeModel.办公楼 = @"办公楼";
            }else{
                industrialListTypeModel.办公楼 = @"";
            }
            break;
        case 503:
            if ([sender isOn]) {
                industrialListTypeModel.宿舍 = @"宿舍";
            }else{
                industrialListTypeModel.宿舍 = @"";
            }
            break;
        case 504:
            if ([sender isOn]) {
                industrialListTypeModel.其他 = @"其他";
            }else{
                industrialListTypeModel.其他 = @"";
            }
            break;
        case 505:
            if ([sender isOn]) {
                industrialListTypeModel.停车场 = @"停车场";
            }else{
                industrialListTypeModel.停车场 = @"";
            }
            break;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (textField.tag) {
        case 700:{
            industrialListModel.宗地号 = textField.text;
        }
            break;
        case 701:{
            industrialListModel.园区名称 = textField.text;
        }
            break;
        case 702:{
            industrialListModel.园区规模 = textField.text;
        }
            break;
        case 703:{
            industrialListModel.准入要求 = textField.text;
        }
            break;
        case 704:{
            industrialListModel.备注 = textField.text;
        }
            break;
    }
}

//保存按钮。
- (IBAction)saveButton:(UIButton *)sender {
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
    industrialListModel.园区名称 = textField2.text;
    if (!(industrialListModel.宗地号.length>1)) {
        [BaseView _init:@"请选择宗地号" View:self.view];
    }else if (!(industrialListModel.园区名称.length>0)){
        [BaseView _init:@"请填写园区名称" View:self.view];
    }else if ([industrialListModel.准入条件 isEqual: @"有"]&&!(industrialListModel.准入要求.length>1)){
        [BaseView _init:@"请填写准入条件" View:self.view];
    }else{
        [self kNetworkListMake2];
    }
}
-(void)kNetworkListMake2{
    industrialListModel.内部配套=[NetworkManager Datastrings:[industrialListTypeModel.toDictionary allValues]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:industrialListModel.toDictionary];
    [dict setObject:@"industryGongyeyuan" forKey:@"makeType"];
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
                industrialListModel.ID = saveModel.ID;
                if ([look isEqualToString:@"工业新增"]) {
                    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:[super replaceString:industrialListModel.园区名称],@"园区名称",[super replaceString:industrialListModel.宗地号],@"宗地号",[super replaceString:saveModel.ID],@"ID", nil];
                    //创建通知
                    NSNotification *notification =[NSNotification notificationWithName:@"园区名称" object:nil userInfo:dict];
                    //通过通知中心发送通知
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
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
        
        industrialListModel.宗地号=[Arrayvalues objectAtIndex:Index];
        textField1.text = [Arrayvalues objectAtIndex:Index];
    };
}
//获取系统楼盘编号和系统楼盘名称
-(void)netSysData:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSDictionary *dict;
    if (self.taskId.length>1) {
        dict =@{@"makeType":@"industryZongdi",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"taskId":self.taskId,@"zingdiNo":name};
    }else{
        dict = @{@"makeType":@"industryZongdi",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"zingdiNo":name};
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
                for (GongyeZongdiListModel *systemListModel in systemModel.list) {
                    [Arrayvalues addObject:systemListModel.宗地编号];
                    [Arraykeys addObject:[NSString stringWithFormat:@"%@ %@",systemListModel.街道办,systemListModel.宗地编号]];
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
