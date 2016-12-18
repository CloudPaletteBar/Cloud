//
//  Building1ViewController.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import "Building1ViewController.h"
#import "FormSelectView.h"
#import "Building1Model.h"
#import "MHDatePicker.h"
#import "zySheetPickerView.h"
#import "SaveModel.h"
#import "FormSelectTableView.h"
#import "SystemModel.h"
#import "MJRefresh.h"
#import "LowPropertyNameView.h"
#import "UIImageView+WebCache.h"
#import "PhotoPickerViewController.h"
#import "POHViewController.h"

@interface Building1ViewController ()<UIScrollViewDelegate,UISearchBarDelegate>
{
    FormSelectTableView *formSelectTableView;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    NSString        *userName;
    NSMutableArray  *buildingArray;
    NSMutableArray *addressArray1;
    NSMutableArray *addressArray2;
    NSMutableArray *addressArray3;
    Building1ListModel *buildingListModel;
    NSArray *imageArray;
    NSMutableArray  *IDs;
    NSString *look;
    NSInteger price1;
    NSInteger price2;
    NSString *Url;
    
    __weak IBOutlet UITextField *textField1;
    __weak IBOutlet UITextField *textField2;
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
    __weak IBOutlet UITextField *textField15;
    __weak IBOutlet UITextField *textField16;
    __weak IBOutlet UITextField *textField17;
    __weak IBOutlet UITextField *textField18;
    
    __weak IBOutlet UISegmentedControl *segmented;
    
    __weak IBOutlet UIButton *clickButton1;
    __weak IBOutlet UIButton *clickButton2;
    __weak IBOutlet UIButton *clickButton3;
    __weak IBOutlet UIButton *clickButton4;
    __weak IBOutlet UIButton *clickButton5;
    __weak IBOutlet UIImageView *imageView;
    NSString *secarchName;
    UIView *formSelectView;
}

@property (strong, nonatomic) MHDatePicker *selectDatePicker;
@property (nonatomic ,strong)UISearchBar *searchBar;

@end

@implementation Building1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IDs=[[NSMutableArray alloc]init];
    userName = userNameDefaults;
    _strId = [super replaceString:[kUserDefaults objectForKey:@"businessId"]];
    _taskId = [super replaceString:[kUserDefaults objectForKey:@"taskId"]];
    look = [kUserDefaults objectForKey:@"商业查看"];
    if ([look isEqualToString:@"商业查看"]) {
        clickButton5.hidden = YES;
    }
    
    buildingArray = [NSMutableArray arrayWithCapacity:1];
    
    self.contentView.frame = CGRectMake(0, 0, MainScreenWidth, self.contentView.frame.size.height);
    [self.buil1ScrollView addSubview:self.contentView];
    self.buil1ScrollView.contentSize = CGSizeMake(0, 830);
    
    [self kNetworkListMake];
    
    [self layerView:clickButton1];
    [self layerView:clickButton2];
    [self layerView:clickButton3];
    [self layerView:clickButton4];
    [self layerView:clickButton5];
    
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
    textField1.text = userNameDefaults;
}

-(void)kNetworkListMake{
    NSDictionary *dcit;
    if (self.selectIndex==0) {
        if (self.taskId.length>1) {
            dcit = @{@"makeType":@"tradeLoupan",@"ID":self.strId,@"taskId":self.taskId};
        }else if (self.strId.length>1){
            dcit = @{@"makeType":@"tradeLoupan",@"ID":self.strId};
        }else{
            dcit = @{@"makeType":@"tradeLoupan"};
        }
    }else{
        dcit = @{@"ID":@"0"};
    }
    __weak typeof(self)SelfWeek=self;
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dcit relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);

        Building1Model *buildingModel = [[Building1Model alloc]initWithDictionary:responseObject error:nil];
        buildingListModel = [[Building1ListModel alloc]init];
        if (buildingModel) {
            [buildingArray addObjectsFromArray:buildingModel.list];
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

-(void)loadData{
    buildingListModel = [buildingArray objectAtIndex:0];
    
//    textField1.text = [super replaceString:buildingListModel.查勘人];
    NSString *string = [super replaceString:buildingListModel.调查时间];
    if (string.length>10) {
        textField2.text = [string substringToIndex:10];
    }else{
        textField2.text = string;
    }
    
    textField3.text = [super replaceString:buildingListModel.系统楼盘编号];
    textField4.text = [super replaceString:buildingListModel.系统楼盘名称];
    textField5.text = [super replaceString:buildingListModel.实际楼盘名称];
    textField6.text = [super replaceString:buildingListModel.楼盘别名];
    textField7.text = [super replaceString:buildingListModel.总楼栋数];
    textField8.text = [super replaceString:buildingListModel.开发商];
    textField9.text = [super replaceString:buildingListModel.物业管理公司];

    addressArray1 = [[NSMutableArray alloc]initWithArray:[NetworkManager address:buildingListModel.地理位置1]];

    if (addressArray1.count>1) {
        textField10.text = [addressArray1 objectAtIndex:0];
        textField11.text = [addressArray1 objectAtIndex:1];
        if (addressArray1.count>2) {
            textField12.text = [addressArray1 objectAtIndex:2];
        }
    }
    
    addressArray2 = [[NSMutableArray alloc]initWithArray:[NetworkManager address:buildingListModel.地理位置2]];
    if (addressArray2.count>1) {
        textField13.text = [addressArray2 objectAtIndex:0];
        textField14.text = [addressArray2 objectAtIndex:1];
        if (addressArray1.count>2) {
            textField15.text = [addressArray2 objectAtIndex:2];
        }
    }
    
    textField16.text = [super replaceString:buildingListModel.区位级别];
    
    addressArray3 = [[NSMutableArray alloc]initWithArray:[NetworkManager address:buildingListModel.价格水平]];
    if (addressArray3.count>1) {
        textField17.text = [addressArray3 objectAtIndex:0];
        textField18.text = [addressArray3 objectAtIndex:1];
    }
    
    NSString *str4 = [super replaceString:buildingListModel.交通便捷程度];
    if (str4.length>0) {
        [clickButton2 setTitle:str4 forState:UIControlStateNormal];
    }
    
    NSString *str5 = [super replaceString:buildingListModel.停车位];
    if (str5.length>0) {
        [clickButton3 setTitle:str5 forState:UIControlStateNormal];
    }
    
    NSString *typeStr = [super replaceString:buildingListModel.楼盘类型];
    if (typeStr.length>0) {
        NSArray *segmentedArray = @[@"裙楼商铺",@"集中商业",@"混合"];
        for (int i=0; i<segmentedArray.count; i++) {
            NSString *str6 = [segmentedArray objectAtIndex:i];
            if ([str6 isEqualToString:typeStr]) {
                segmented.selectedSegmentIndex = i;
            }
        }
    }
    
    [segmented addTarget: self action: @selector(segmentedAction:) forControlEvents: UIControlEventValueChanged];
    
    NSString *imageStr = [super replaceString:buildingListModel.楼栋位置图];
    if (imageStr.length>1) {
        NSArray *array = [NetworkManager address:imageStr];
        if (array.count>0) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,[array objectAtIndex:0]]] placeholderImage:nil];
        }

    }
}

-(void)_initObject{
    buildingListModel.楼盘类型 = @"裙楼商铺";
    buildingListModel.交通便捷程度 = clickButton2.titleLabel.text;
    buildingListModel.停车位 = clickButton3.titleLabel.text;
    
    addressArray1 = [NSMutableArray arrayWithCapacity:3];
    addressArray2 = [NSMutableArray arrayWithCapacity:3];
    addressArray3 = [NSMutableArray arrayWithCapacity:2];
}

-(void)segmentedAction:(UISegmentedControl *)Seg{
//    NSInteger index=Seg.selectedSegmentIndex;
    NSString *str = [Seg titleForSegmentAtIndex:Seg.selectedSegmentIndex];
//    NSLog(@"%ld----%@",index,str);
    buildingListModel.楼盘类型 = str;
}

-(void)layerView:(UIView *)view{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0;
}

//保存按钮。
- (IBAction)saveButton:(UIButton *)sender {
    __block int count1 = 0;
    __block int count2 = 0;
    
    buildingListModel.地理位置1=[NetworkManager Datastrings:addressArray1];
    buildingListModel.地理位置2=[NetworkManager Datastrings:addressArray2];
    buildingListModel.价格水平 = [NSString stringWithFormat:@"%ld,%ld",price1,price2];
    
    [addressArray1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        count1 ++ ;
        if ([obj isEqual:@""]) {
            count1--;
        }
    }];
    [addressArray2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        count2 ++ ;
        if ([obj isEqual:@""]) {
            count2--;
        }
    }];

    if (!(buildingListModel.调查时间.length>1)){
        [BaseView _init:@"请输入调查时间" View:self.view];
//    }else if (!(buildingListModel.系统楼盘编号.length>1)){
//        [BaseView _init:@"请输入系统楼盘编号" View:self.view];
    }else if (!(buildingListModel.实际楼盘名称.length>0)){
        [BaseView _init:@"请输入实际楼盘名称" View:self.view];
    }else if (!(buildingListModel.楼盘别名.length>0)){
        [BaseView _init:@"请输入楼盘别名" View:self.view];
    }else if (!(buildingListModel.总楼栋数.length>0)){
        [BaseView _init:@"请输入总楼栋数" View:self.view];
    }else if (!(buildingListModel.开发商.length>0)){
        [BaseView _init:@"请输入开发商" View:self.view];
    }else if (!(buildingListModel.物业管理公司.length>0)){
        [BaseView _init:@"请输入物业管理公司" View:self.view];
    }else if (count1 != 3 && count2 != 3){
        [BaseView _init:@"请输入任意一个完整的地理位置信息" View:self.view];
    }else if (!(buildingListModel.区位级别.length>0)){
        [BaseView _init:@"请输入区位级别" View:self.view];
    }else if (price1<1 || price2<1){
        [BaseView _init:@"请输入完整的价格水平" View:self.view];
    }else if (!buildingListModel.楼栋位置图){
        [BaseView _init:@"请选择楼栋位置图" View:self.view];
    }else if ([NetworkManager address:buildingListModel.楼栋位置图].count>2){
        [BaseView _init:@"户型图2-5张" View:self.view];
    }else{
        
        [self kNetworkListMake2];
    }
//
}
-(void)kNetworkListMake2{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:buildingListModel.toDictionary];
    
    [dict setObject:@"tradeLoupan" forKey:@"makeType"];
    if (self.taskId.length>1) {
        [dict setObject:self.taskId forKey:@"taskId"];
    }
    if (self.strId.length>1){
        [dict setObject:self.strId forKey:@"id"];
    }
    
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"保存中..."];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appAction!saveMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        SaveModel *saveModel=[[SaveModel alloc]initWithDictionary:responseObject error:nil];
        if (saveModel) {
            if ([saveModel.status isEqualToString:@"1"]) {
                for (NSArray *numbers in IDs) {
                    for (NSNumber *number in numbers) {
                        [[NetworkManager shar]updata:[number longLongValue] FormID:saveModel.ID TackId:self.taskId];
                    }
                }
                buildingListModel.ID = saveModel.ID;
                [BaseView _init:saveModel.message View:SelfWeek.view];
                [kUserDefaults setObject:saveModel.ID forKey:@"businessId"];
                if ([look isEqualToString:@"商业新增"]) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"shangYelouPanTolouDong" object:[super replaceString:textField5.text]];
                    
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

-(IBAction)timePicker:(UIButton *)sender{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    _selectDatePicker = [[MHDatePicker alloc] init];
    _selectDatePicker.isBeforeTime = YES;
    _selectDatePicker.datePickerMode = UIDatePickerModeDate;

    [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
        
        NSString *timeStr = [NSString stringWithFormat:@"%@",selectedDate];
        textField2.text = [timeStr substringToIndex:10];
         NSLog(@"%@",textField2.text);
        buildingListModel.调查时间 = [timeStr substringToIndex:10];
    }];
}

-(IBAction)selectButton:(UIButton *)sender{
    switch (sender.tag) {
        case 500:{
            NSArray *array = @[@" 便捷",@" 较便捷",@" 一般",@" 较差",@" 差"];
            [self clickArray:array andTag:500];
        }
            break;
        case 501:{
            NSArray *array = @[@" 自带停车场(地上/地下)",@" 临近停车场(地上/地下)",@" 路边停车场",@" 无停车场"];
            [self clickArray:array andTag:501];
        }
            break;
        case 502:{
            //图片。
            [self pushImageController];
        }
            break;
    }
}

-(void)pushImageController{
    POHViewController *pOHViewController=[[POHViewController alloc]initWithNibName:@"POHViewController" bundle:nil];
    NSMutableArray *PHarray=[NetworkManager address:buildingListModel.楼栋位置图];
    if (PHarray.count==0) {
        PHarray = [NSMutableArray arrayWithCapacity:1];
    }
    pOHViewController.PHOarray=PHarray;
    pOHViewController.successfulIndex = PHarray.count;
    
    if ([look isEqualToString:@"商业查看"]) {
        pOHViewController.type = @"查看";
    }
    
    [self.navigationController pushViewController:pOHViewController animated:YES];
    pOHViewController.ClockSave=^(NSArray *ArrayID,NSString *ImageUrl){
        buildingListModel.楼栋位置图=ImageUrl;
        [IDs removeAllObjects];
        [IDs addObject:ArrayID];
        Url=[NetworkManager jiequStr:ImageUrl rep:@","];
        [NetworkManager _initSdImage:Url ImageView:imageView];
    };
    pOHViewController.imageType=@"楼栋位置图";
    pOHViewController.orderType=@"tradeLoupan";
    pOHViewController.ID=buildingListModel.ID;
    pOHViewController.stakID=self.taskId;
    pOHViewController.selectMax=5;
}

-(void)clickArray:(NSArray *)array andTag:(int)tagInt{
    zySheetPickerView *pickerView = [zySheetPickerView ZYSheetStringPickerWithTitle:array andHeadTitle:@"" Andcall:^(zySheetPickerView *pickerView, NSString *choiceString) {
        switch (tagInt) {
            case 500:
                [clickButton2 setTitle:choiceString forState:UIControlStateNormal];
                buildingListModel.交通便捷程度 = choiceString;
                break;
            case 501:
                [clickButton3 setTitle:choiceString forState:UIControlStateNormal];
                buildingListModel.停车位 = choiceString;
                break;
            case 709:
                if ([choiceString isEqualToString:@"请选择"]) {
                    choiceString = @"";
                }
                [self repn:choiceString Index:0 Datas:addressArray1];
                textField10.text = choiceString;
                break;
            case 712:
                if ([choiceString isEqualToString:@"请选择"]) {
                    choiceString = @"";
                }
                [self repn:choiceString Index:0 Datas:addressArray2];
                textField13.text = choiceString;
                break;
        }
        [pickerView dismissPicker];
    }];
    [pickerView show];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 709:{
            NSArray *array = @[@"请选择",@"罗湖",@"福田",@"南山",@"龙华新区",@"龙岗",@"宝安",@"盐田",@"坪山新区",@"光明新区",@"大鹏新区"];
            [self clickArray:array andTag:709];
            return NO;
        }
            break;
        case 712:{
            NSArray *array = @[@"请选择",@"罗湖",@"福田",@"南山",@"龙华新区",@"龙岗",@"宝安",@"盐田",@"坪山新区",@"光明新区",@"大鹏新区"];
            [self clickArray:array andTag:712];
            return NO;
        }
            break;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 700:{
            buildingListModel.查勘人 = textField.text;
        }
            break;
        case 702:{
            buildingListModel.系统楼盘编号 = textField.text;
        }
            break;
        case 703:{
            buildingListModel.系统楼盘名称 = textField.text;
        }
            break;
        case 704:{
            buildingListModel.实际楼盘名称 = textField.text;
        }
            break;
        case 705:{
            buildingListModel.楼盘别名 = textField.text;
        }
            break;
        case 706:{
            buildingListModel.总楼栋数 = textField.text;
        }
            break;
        case 707:{
            buildingListModel.开发商 = textField.text;
        }
            break;
        case 708:{
            buildingListModel.物业管理公司 = textField.text;
        }
            break;
        case 710:{
            [self repn:textField.text Index:1 Datas:addressArray1];
        }
            break;
        case 711:{
            [self repn:textField.text Index:2 Datas:addressArray1];
        }
            break;
        case 713:{
            [self repn:textField.text Index:1 Datas:addressArray2];
        }
            break;
        case 714:{
            [self repn:textField.text Index:2 Datas:addressArray2];
        }
            break;
        case 715:{
            buildingListModel.区位级别 = textField.text;
        }
            break;
        case 716:{
            price1 = [textField.text integerValue];
        }
            break;
        case 717:{
            price2 = [textField.text integerValue];
        }
            break;
    
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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

- (IBAction)selectNumber:(UIButton *)sender {
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
        buildingListModel.系统楼盘编号=[Arrayvalues objectAtIndex:Index];
        buildingListModel.系统楼盘名称=[NetworkManager interceptStrTo:selectStr PleStr:@" "];
        textField3.text = [Arrayvalues objectAtIndex:Index];
        textField4.text = [NetworkManager interceptStrTo:selectStr PleStr:@" "];
    };
}
//获取系统楼盘编号和系统楼盘名称
-(void)netSysData:(int)page andName:(NSString *)name{
    
    __weak typeof(self)SelfWeek=self;
    NSDictionary *dict;
    if (self.taskId.length>1) {
        dict = @{@"makeType":@"tradeLoupan",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":name,@"taskId":self.taskId} ;
    }else{
        dict = @{@"makeType":@"tradeLoupan",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":name};
    }
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getLoupan.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        [SelfWeek tableviewEnd];
        SystemModel *systemModel = [[SystemModel alloc]initWithDictionary:responseObject error:nil];
        if (systemModel) {
            if ([systemModel.status isEqualToString:@"1"]) {
                if (page==1) {
                    [Arraykeys removeAllObjects];
                    [Arrayvalues removeAllObjects];
                }
                for (SystemListModel *systemListModel in systemModel.list) {
                    [Arraykeys addObject:[NSString stringWithFormat:@"%@ %@",[super replaceString:systemListModel.系统楼盘名称],[super replaceString:systemListModel.楼栋名称]]];
                    [Arrayvalues addObject:systemListModel.系统楼盘编号];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
