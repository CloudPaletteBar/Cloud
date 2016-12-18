//
//  OrdinaryEstateViewController.m
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "OrdinaryEstateViewController.h"
#import "CloudPaletteBar.h"
#import "NetworkManager.h"
#import "LowEstateCell.h"
#import "LowPropertyNameView.h"
#import "FormInPutView.h"
#import "LowSelectDateView.h"
#import "OfficeEstateAddressView.h"
#import "LowHouseSwitchView.h"
#import "HouseSelectView.h"
#import "LowFootView.h"
#import "PhotoView.h"
#import "PhotoPickerViewController.h"
#import "CalendarView.h"
#import "FormSelectTableView.h"
#import "SystemModel.h"
#import "MJRefresh.h"
#import "OEstateModel.h"
#import "SaveModel.h"
#import "POHViewController.h"
#import "SelectFormPickerView.h"

static NSString *Identifier=@"Identifier";
static NSString *Identifier1=@"Identifier1";
static NSString *Identifier2=@"Identifier2";
static NSString *Identifier3=@"Identifier3";
static NSString *Identifier4=@"Identifier4";
static NSString *Identifier5=@"Identifier5";
static NSString *Identifier6=@"Identifier6";
static NSString *Identifier7=@"Identifier7";
static NSString *Identifier8=@"Identifier8";
static NSString *Identifier9=@"Identifier9";
static NSString *Identifier10=@"Identifier10";
static NSString *Identifier11=@"Identifier11";
static NSString *Identifier12=@"Identifier12";
static NSString *Identifier20=@"Identifier20";

@interface OrdinaryEstateViewController ()<UITextFieldDelegate,UISearchBarDelegate>{
    UITextField *fistTextField;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    FormSelectTableView *formSelectTableView;
    UIView *formSelectView;
    OEstateListModel *oEstateListModel;
    //运动设施
    OEstateMotionModel *oEstateMotionModel;
    //活动设施
    OEstateActivityModel *oEstateActivityModel;
    //安保情况
    OEstateSecurityModel *oEstateSecurityModel;
    //不利因素
    OEstateDisadvantageModel *oEstateDisadvantageModel;
    //楼盘景观设施
    OEstateSceneryModel *oEstateSceneryModel;
    //楼盘外观照片
    OEstateStandardPhModel *oEstateStandardPhModel1;
    //楼栋平面图
    OEstateStandardPhModel *oEstateStandardPhModel2;
    NSInteger Indext;
    NSMutableArray *addressArray1;
    NSMutableArray *addressArray2;
    NSMutableArray  *IDs;
    NSString *secarchName;
}
@property(nonatomic,strong)CalendarView *calendarView;
@property(nonatomic,strong)NSMutableArray *lowArray;
@property(nonatomic,strong)NSMutableArray *dropDownArray;
@property(nonatomic,strong)SelectFormPickerView *citypick;
@property (nonatomic ,strong)UISearchBar *searchBar;

@end

@implementation OrdinaryEstateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IDs=[[NSMutableArray alloc]init];
    self.baseTableView.frame=CGRectMake(0, 0, screen_width, screen_height-50-64);
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerHeat];
    self.lowArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OpenOrClose"]];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"LowEstateCell" bundle:nil] forCellReuseIdentifier:Identifier];
    //    LowEstate
    self.baseArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OQEstate"]];
    self.dropDownArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OQEstateSelect"]];
    _calendarView=[[[NSBundle mainBundle]loadNibNamed:@"CalendarView" owner:self options:nil]lastObject];
    [self.calendarView reloadWithDate: 3];
    
    
    formSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-150)];
    self.searchBar.frame = CGRectMake(0, 0, screen_width, 50.0);
    formSelectTableView=[[FormSelectTableView alloc]initWithFrame:CGRectMake(0, 50, screen_width, formSelectView.frame.size.height-50)];
    [formSelectView addSubview:formSelectTableView];
    _citypick=[[[NSBundle mainBundle]loadNibNamed:@"SelectFormPickerView" owner:self options:nil]lastObject];
    [_citypick _init:nil];
    __weak typeof(self)SelfWeak=self;
    [formSelectTableView _initOrderUP:^(int Page) {
        [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
    } Down:^(int Page) {
        [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
    }];
    [self netFormData];
}

-(void)registerHeat{
    [self registerHeat:@"FormInPutView" Mark:Identifier1];
    [self registerHeat:@"LowSelectDateView" Mark:Identifier2];
    [self registerHeat:@"LowPropertyNameView" Mark:Identifier3];
    [self registerHeat:@"OfficeEstateAddressView" Mark:Identifier4];
    [self registerHeat:@"LowHouseSwitchView" Mark:Identifier5];
    [self registerHeat:@"PhotoView" Mark:Identifier20];
    [self registerHeat:@"LowFootView" Mark:Identifier7];
    
    //    [self registerHeat:@"HouseSelectView" Mark:Identifier6];
    //    [self.baseTableView registerClass:[HouseSelectView class] forHeaderFooterViewReuseIdentifier:Identifier6];
}

//获取系统楼盘编号和系统楼盘名称
-(void)netSysData:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"houseDLoupan",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":name}];
    if (self.estateID) {
        [dic setObject:self.estateID forKey:@"taskId"];
    }
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appSelect!getLoupan.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        Arraykeys=[[NSMutableArray alloc]init];
        Arrayvalues=[[NSMutableArray alloc]init];
        [SelfWeek tableviewEnd];
        SystemModel *systemModel = [[SystemModel alloc]initWithDictionary:responseObject error:nil];
        if (systemModel) {
            if ([systemModel.status isEqualToString:@"1"]) {
                for (SystemListModel *systemListModel in systemModel.list) {
                    [ Arraykeys addObject:[NSString stringWithFormat:@"%@ %@",systemListModel.系统楼盘名称,systemListModel.楼栋名称]];
                    [ Arrayvalues addObject:systemListModel.系统楼盘编号];
                }
                if (formSelectTableView.TagT==1004) {
                    formSelectTableView.formSelectArray=Arrayvalues;
                }else{
                    formSelectTableView.formSelectArray=Arraykeys;
                }
                //                        formSelectTableView.formSelectArray=keys;
            }
        }
        
    } failure:^(NSError *error) {
        [SelfWeek tableviewEnd];
    }];
}

-(void)tableviewEnd{
    [formSelectTableView.mj_header endRefreshing];
    [formSelectTableView.mj_footer endRefreshing];
}

-(void)Init_0{
    oEstateListModel=[[OEstateListModel alloc]init];
    oEstateMotionModel=[[OEstateMotionModel alloc]init];
    oEstateActivityModel=[[OEstateActivityModel alloc]init];
    oEstateSecurityModel=[[OEstateSecurityModel alloc]init];
    oEstateDisadvantageModel=[[OEstateDisadvantageModel alloc]init];
    oEstateSceneryModel=[[OEstateSceneryModel alloc]init];
    oEstateStandardPhModel2=[[OEstateStandardPhModel alloc]init];
    oEstateStandardPhModel1=[[OEstateStandardPhModel alloc]init];
    addressArray1=[[NSMutableArray alloc]init];
    addressArray2=[[NSMutableArray alloc]init];
}
//获取表单数据

-(void)netFormData{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"houseDLoupan"}];
    if (self.estateID) {
        [dic setObject:self.estateID forKey:@"taskId"];
        if ([kUserDefaults objectForKey:@"ordinaryId" ]!=NULL) {
            
//            if (self.selectIndex==0) {
                [dic setObject:[super replaceString:[kUserDefaults objectForKey:@"ordinaryId" ]] forKey:@"ID"];
//            }else{
//                [dic setObject:@"0" forKey:@"ID"];
//            }
            [self Init_0];
            [self netWork:dic];

        }else{
            [self Init_0];
        }
    }else{
        if ([kUserDefaults objectForKey:@"ordinaryId" ]!=NULL) {
//            if (self.selectIndex==0) {
                [dic setObject:[super replaceString:[kUserDefaults objectForKey:@"ordinaryId" ]] forKey:@"ID"];
//            }else{
//                [dic setObject:@"0" forKey:@"ID"];
//            }
            [self Init_0];
            [self netWork:dic];
            
        }else{
            [self Init_0];
        }
    }

}
-(void)netWork:(NSDictionary *)dic{
    typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressOneHUD:self.view Title:@"获取中..."];
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        OEstateModel *oEstateModel = [[OEstateModel alloc]initWithDictionary:responseObject error:nil];
        if (oEstateModel) {
            if ([oEstateModel.status isEqualToString:@"1"]) {
                if (oEstateModel.list.count>0) {
                    oEstateListModel=[oEstateModel.list objectAtIndex:0];
                    oEstateMotionModel=[[OEstateMotionModel alloc]initWithDictionary:[NetworkManager stringDictionary:oEstateListModel.运动设施] error:nil];
                    oEstateActivityModel=[[OEstateActivityModel alloc]initWithDictionary:[NetworkManager stringDictionary:oEstateListModel.活动设施] error:nil];
                    NSString *str=[NetworkManager repl:@"24" Str:oEstateListModel.安保情况];
                    oEstateSecurityModel=[[OEstateSecurityModel alloc]initWithDictionary:[NetworkManager stringDictionary:str] error:nil];
                    oEstateDisadvantageModel=[[OEstateDisadvantageModel alloc]initWithDictionary:[NetworkManager stringDictionary:oEstateListModel.不利因素] error:nil];
                    NSString *str1=[NetworkManager repl:@"/" Str:oEstateListModel.楼盘景观设施];
                    
                    oEstateSceneryModel=[[OEstateSceneryModel alloc]initWithDictionary:[NetworkManager stringDictionary:str1] error:nil];
                    oEstateStandardPhModel2=[[OEstateStandardPhModel alloc]initWithDictionary:[NetworkManager stringDictionaryImge:oEstateListModel.楼栋平面图] error:nil];
                    oEstateStandardPhModel1=[[OEstateStandardPhModel alloc]initWithDictionary:[NetworkManager stringDictionaryImge:oEstateListModel.楼盘外观照片] error:nil];
                    addressArray1=[[NSMutableArray alloc]initWithArray:[NetworkManager address:oEstateListModel.地理位置1]];
                    //                    把字符串转成数组
                    addressArray2=[[NSMutableArray alloc]initWithArray:[NetworkManager address:oEstateListModel.地理位置2]];
                    [SelfWeek repleStr:oEstateListModel];
                    [SelfWeek.baseTableView reloadData];
                }
                
            }else{
                [BaseView _init:@"请求失败" View:SelfWeek.view];
            }
        }else{
            [BaseView _init:@"亲你的网络不给力啊" View:SelfWeek.view];
        }
        
        [[BaseView baseShar]dissMiss];
    } failure:^(NSError *error) {
        [[BaseView baseShar]dissMiss];
        [BaseView _init:@"亲网络异常请稍后" View:SelfWeek.view];
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

-(void)re{
    
    if([self panduan:oEstateListModel.商场 Baohan:@"有"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:26 withObject:@"YES"];
    }if([self panduan:oEstateListModel.超市 Baohan:@"有"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:27 withObject:@"YES"];
    }if([self panduan:oEstateListModel.社区医院 Baohan:@"有"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:28 withObject:@"YES"];
    }if([self panduan:oEstateListModel.会所 Baohan:@"有"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:29 withObject:@"YES"];
    }if([self panduan:oEstateListModel.活动设施 Baohan:@"其它"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:32 withObject:@"YES"];
    }if([self panduan:oEstateListModel.运动设施 Baohan:@"其它"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:37 withObject:@"YES"];
    }if([self panduan:oEstateListModel.托儿所 Baohan:@"有"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:38 withObject:@"YES"];
    }if([self panduan:oEstateListModel.幼儿园 Baohan:@"有"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:39 withObject:@"YES"];
    }if([self panduan:oEstateListModel.小学 Baohan:@"有"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:40 withObject:@"YES"];
    }if([self panduan:oEstateListModel.中学 Baohan:@"有"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:41 withObject:@"YES"];
    }if([self panduan:oEstateListModel.海滨 Baohan:@"有"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:43 withObject:@"YES"];
    }if([self panduan:oEstateListModel.河流湖泊 Baohan:@"有"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:44 withObject:@"YES"];
    }if([self panduan:oEstateListModel.山景 Baohan:@"有"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:45 withObject:@"YES"];
    }if([self panduan:oEstateListModel.人文景观广场 Baohan:@"有"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:46 withObject:@"YES"];
    }if([self panduan:oEstateListModel.公园 Baohan:@"有"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:47 withObject:@"YES"];
    }if([self panduan:oEstateListModel.高尔夫球场 Baohan:@"有"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:48 withObject:@"YES"];
    }if([self panduan:oEstateListModel.不利因素 Baohan:@"其它"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:53 withObject:@"YES"];
    }
}


-(BOOL)panduan:(NSString *)yuan Baohan:(NSString *)baohan{
    if([yuan rangeOfString:baohan].location !=NSNotFound)//_roaldSearchText
    {
        return YES;
    }return NO;
}



-(void)registerHeat:(NSString *)xibName Mark:(NSString *)mark{
    
    [self.baseTableView registerNib:[UINib nibWithNibName:xibName bundle:nil] forHeaderFooterViewReuseIdentifier:mark];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.baseArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[self.lowArray objectAtIndex:section]isEqualToString:@"YES"]) {
        NSDictionary *dic=[self.baseArray objectAtIndex:section];
        NSArray *key=[dic allKeys];
        NSArray *value=[dic objectForKey:[key objectAtIndex:0]];
        return value.count;
    }
    return 0;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //        UITableViewCell *superCell=[super tableView:tableView cellForRowAtIndexPath:indexPath];
    //
    LowEstateCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary *dic=[self.baseArray objectAtIndex:indexPath.section];
    NSArray *key=[dic allKeys];
    NSArray *value=[dic objectForKey:[key objectAtIndex:0]];
    [cell _cellInit:[value objectAtIndex:indexPath.row] Weather:@"选填"];
    cell.cellTextField.delegate=self;
    cell.cellTextField.tag=10000+indexPath.section+indexPath.row;
    cell.cellTextField.text=@"";
    cell.cellTextField.keyboardType=UIKeyboardTypeDefault;
    if (indexPath.section==26&&oEstateListModel.商场名称) {
        cell.cellTextField.text=oEstateListModel.商场名称;
    }else if (indexPath.section==27&&oEstateListModel.超市名称) {
        cell.cellTextField.text=oEstateListModel.超市名称;
    }else if (indexPath.section==28&&oEstateListModel.社区医院名称) {
        cell.cellTextField.text=oEstateListModel.社区医院名称;
    }else if (indexPath.section==28) {
        cell.cellTextField.keyboardType=UIKeyboardTypeNumberPad;
        if (oEstateListModel.会所个数) {
            cell.cellTextField.text=oEstateListModel.会所个数;
        }
        
    }else if (indexPath.section==32&&oEstateListModel.活动设施其它) {
        cell.cellTextField.text=oEstateListModel.活动设施其它;
    }else if (indexPath.section==37&&oEstateListModel.运动设施其它) {
        cell.cellTextField.text=oEstateListModel.运动设施其它;
    }else if (indexPath.section==38&&oEstateListModel.托儿所名称) {
        cell.cellTextField.text=oEstateListModel.托儿所名称;
    }else if (indexPath.section==39&&oEstateListModel.幼儿园名称){
         cell.cellTextField.text=oEstateListModel.幼儿园名称;
    }else if (indexPath.section==40&&oEstateListModel.小学名称){
        cell.cellTextField.text=oEstateListModel.小学名称;
    }else if (indexPath.section==41&&oEstateListModel.中学名称){
        cell.cellTextField.text=oEstateListModel.中学名称;
    }else if (indexPath.section==43&&oEstateListModel.海滨名称){
        cell.cellTextField.text=oEstateListModel.海滨名称;
    }else if (indexPath.section==44&&oEstateListModel.河流湖泊名称){
        cell.cellTextField.text=oEstateListModel.河流湖泊名称;
    }else if (indexPath.section==45&&oEstateListModel.山景名称){
        cell.cellTextField.text=oEstateListModel.山景名称;
    }else if (indexPath.section==46&&oEstateListModel.人文景观广场名称){
        cell.cellTextField.text=oEstateListModel.人文景观广场名称;
    }else if (indexPath.section==47&&oEstateListModel.公园名称){
        cell.cellTextField.text=oEstateListModel.公园名称;
    }else if (indexPath.section==48&&oEstateListModel.高尔夫球场名称){
        cell.cellTextField.text=oEstateListModel.高尔夫球场名称;
    }else if (indexPath.section==53&&oEstateListModel.不利因素其它){
        cell.cellTextField.text=oEstateListModel.不利因素其它;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==3) {
        return 0;
    }else if (section==15||section==22||section==30||section==33||section==49){
        return 65;
    }
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    __weak typeof(self)selfWeek=self;
    NSDictionary *dic=[self.baseArray objectAtIndex:section];
    NSArray *key=[dic allKeys];
    if (section==0||section==7||(section>=9&&section<=12)||section==14||section==20||section==21||section==54) {
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier1 ];
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        formInPutView.formTextField.keyboardType=UIKeyboardTypeDefault;
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"选填"];
        formInPutView.formTextField.text=@"";
        if (section==0) {
            if (oEstateListModel.调查人) {
                formInPutView.formTextField.text=oEstateListModel.调查人;
            }else{
                formInPutView.formTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
            }
            
        }else  if (section==7&&oEstateListModel.开发商){
            formInPutView.formTextField.text=oEstateListModel.开发商;
        }else if (section==9){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (oEstateListModel.占地面积) {
                formInPutView.formTextField.text=oEstateListModel.占地面积;
            }
            
        }else if (section==10){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (oEstateListModel.车位总数) {
                formInPutView.formTextField.text=oEstateListModel.车位总数;
            }
            
        }else if (section==11){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (oEstateListModel.室内车位数) {
                formInPutView.formTextField.text=oEstateListModel.室内车位数;
            }
            
        }else if (section==12){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (oEstateListModel.露天车位数) {
                formInPutView.formTextField.text=oEstateListModel.露天车位数;
            }
            
        }else if (section==14){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (oEstateListModel.物业管理费) {
                formInPutView.formTextField.text=oEstateListModel.物业管理费;
            }
            
        }else if (section==20){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (oEstateListModel.容积率) {
                formInPutView.formTextField.text=oEstateListModel.容积率;
            }
            
        }else if (section==21){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (oEstateListModel.绿地率) {
                formInPutView.formTextField.text=oEstateListModel.绿地率;
            }
            
        }else if (section==54&&oEstateListModel.楼盘其它特点){
            formInPutView.formTextField.text=oEstateListModel.楼盘其它特点;
        }
        return formInPutView;
    }else if (section==4||section==13) {
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier1 ];
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        
        formInPutView.formTextField.text=@"";
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"必填"];
        
        if (section==4&&oEstateListModel.实际楼盘名称) {
            formInPutView.formTextField.text=oEstateListModel.实际楼盘名称;
        }else if (section==13&&oEstateListModel.物业公司){
            formInPutView.formTextField.text=oEstateListModel.物业公司;
        }
        return formInPutView;
    }else if (section==1||section==8){
        LowSelectDateView *lowSelectDateView=(LowSelectDateView *)[self C_init:Identifier2 ];
        lowSelectDateView.titleTextField.tag=section+1000;
        lowSelectDateView.titleTextField.delegate=self;
        [lowSelectDateView _init:[key objectAtIndex:0]InPutView:_calendarView];
        _calendarView.ClockDate=^(NSString * dateStr){
            lowSelectDateView.titleTextField=[selfWeek.view viewWithTag:Indext];
            lowSelectDateView.titleTextField.text=[NetworkManager str:dateStr];
            
        };
        if (section==1) {
            if (!oEstateListModel.调查时间) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"yyyy.MM.dd"];
                oEstateListModel.调查时间=[formatter stringFromDate:[NSDate date]];
            }
            lowSelectDateView.titleTextField.text=oEstateListModel.调查时间;
        }else if(section==8){
//            if (!oEstateListModel.竣工年代) {
//                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//                [formatter setDateFormat:@"yyyy.MM.dd"];
//                oEstateListModel.竣工年代=[formatter stringFromDate:[NSDate date]];
//            }
            lowSelectDateView.titleTextField.text=oEstateListModel.竣工年代;
        }

        return lowSelectDateView;

        
    }else if (section==3||section==2){
        LowPropertyNameView *lowPropertyNameView=(LowPropertyNameView *)[self C_init:Identifier3 ];
        lowPropertyNameView.tag=1000+section;
        if (section==2) {
            [lowPropertyNameView _init:[key objectAtIndex:0] Weather:@"自动设置"];
            lowPropertyNameView.selectButton.hidden=NO;
        }else{
            [lowPropertyNameView _init:[key objectAtIndex:0] Weather:@"必填"];
            lowPropertyNameView.selectButton.hidden=YES;
        }
        lowPropertyNameView.ClockLow=^(NSInteger Tag){
            if (Tag) {
                NSLog(@"%ld",Tag);
                formSelectTableView.formSelectArray=nil;
                [formSelectTableView.mj_header beginRefreshing];
//                if (Tag==1003) {
//                    
//                    formSelectTableView.formSelectArray=Arrayvalues;
//                }else{
//                    formSelectTableView.formSelectArray=Arraykeys;
//                }
                formSelectTableView.TagT=Tag;
                [[BaseView baseShar]_initPop:formSelectView Type:1];
            }
        };
        formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
            _searchBar.text = @"";
            secarchName = @"";
            _searchBar.showsCancelButton = NO;
            [_searchBar resignFirstResponder];
            oEstateListModel.系统楼盘名称=[NetworkManager interceptStrTo:selectStr PleStr:@" "];
                oEstateListModel.系统楼盘编号=[Arrayvalues objectAtIndex:Index];
                       [self.baseTableView reloadData];
        };
        
        lowPropertyNameView.titleTextField.text=@"";
        if (section==2&&oEstateListModel.系统楼盘名称){
            lowPropertyNameView.titleTextField.text=oEstateListModel.系统楼盘名称;
        }else if (section==3&&oEstateListModel.系统楼盘编号){
            lowPropertyNameView.titleTextField.text=oEstateListModel.系统楼盘编号;
        }
        

        return lowPropertyNameView;
    }else if(section==5||section==6)
    {
        OfficeEstateAddressView *officeEstateAddressView=[tableView dequeueReusableHeaderFooterViewWithIdentifier:Identifier4];officeEstateAddressView.addressTextField.tag=10000+section;
        officeEstateAddressView.addressTextField.delegate=self;
        officeEstateAddressView.areaTextField.tag=100+section;
        officeEstateAddressView.areaTextField.delegate=self;
        officeEstateAddressView.roundTextField.tag=10+section;
        officeEstateAddressView.roundTextField.delegate=self;
        officeEstateAddressView.addressTextField.text=@"";
        officeEstateAddressView.areaTextField.text=@"";
        officeEstateAddressView.roundTextField.text=@"";
        officeEstateAddressView.roundTextField.keyboardType=UIKeyboardTypeDefault;
        if (section==5) {
            officeEstateAddressView.roundTextField.keyboardType=UIKeyboardTypeNumberPad;
            [officeEstateAddressView _init:[key objectAtIndex:0] WeatherMarkAddress:@"选填" AreaTitle:@"区" WeatherMarkArea:@"选填" RoundTitle:@"街道(路)" WeatherMarkRound:@"选填" EndTiele:@"号"];
            officeEstateAddressView.addressTextField.inputView=_citypick;
            if (addressArray1.count>1) {
                //                //                    从数组去除对应的值付给空件
                officeEstateAddressView.addressTextField.text=[addressArray1 objectAtIndex:0];
                officeEstateAddressView.areaTextField.text=[addressArray1 objectAtIndex:1];
                if (addressArray1.count>2) {
                    officeEstateAddressView.roundTextField.text=[addressArray1 objectAtIndex:2];
                }
            }
        }else{
            [officeEstateAddressView _init:[key objectAtIndex:0] WeatherMarkAddress:@"选填" AreaTitle:@"区" WeatherMarkArea:@"选填" RoundTitle:@"路" WeatherMarkRound:@"选填" EndTiele:@"路交界"];
            officeEstateAddressView.addressTextField.inputView=_citypick;
            if (addressArray2.count>1) {
                //                    从数组去除对应的值付给空件
                officeEstateAddressView.addressTextField.text=[addressArray2 objectAtIndex:0];
                officeEstateAddressView.areaTextField.text=[addressArray2 objectAtIndex:1];
                if (addressArray2.count>1) {
                    officeEstateAddressView.roundTextField.text=[addressArray2 objectAtIndex:2];
                }
            }
        }
        _citypick.Clock=^(NSString *str){
            UITextField *TextField= (UITextField *)[self.view viewWithTag:Indext];
            if ([str isEqualToString:@"请选择"]) {
                str = @"";
            }
            TextField.text=str;
        };
        return officeEstateAddressView;
    }else if ((section>=15&&section<=18)||(section>=22&&section<=25)||(section>=30&&section<=32)||(section>=33&&section<=37)||(section>=49&&section<=53)){
        LowHouseSwitchView *lowSelectDateView=(LowHouseSwitchView *)[self C_init:Identifier5 ];
        lowSelectDateView.tag=section+1000;
        NSString *keyStr=[key objectAtIndex:0];
        [lowSelectDateView _init:[NetworkManager interceptStrTo:keyStr PleStr:@"+"] Title1:[NetworkManager interceptStrFrom:keyStr PleStr:@"+"] TitleSwitch:NO TitleSwitch1:NO];
        lowSelectDateView.Clock=^(NSInteger indexSwitch,BOOL open){
            NSLog(@"%ld",indexSwitch);
            if (open) {
                if (indexSwitch==1016) {
                    oEstateSecurityModel.小时保安=@"24小时安保";
                }else if (indexSwitch==1115){
                    oEstateSecurityModel.定时巡逻=@"定时巡逻";
                }else if (indexSwitch==1017){
                    oEstateSecurityModel.闭路电视监控系统=@"闭路电视监控系统";
                }else if (indexSwitch==1116){
                    oEstateSecurityModel.智能IC卡门禁系统=@"智能IC卡门禁系统";
                }else if (indexSwitch==1018){
                    oEstateSecurityModel.可视门禁系统=@"可视门禁系统";
                }else if (indexSwitch==1117){
                    oEstateSecurityModel.智能车场管理系统=@"智能车场管理系统";
                }else if (indexSwitch==1019){
                    oEstateSecurityModel.红外防盗报警系统=@"红外防盗报警系统";
                }else if (indexSwitch==1023){
                    oEstateSceneryModel.草坪=@"草坪";
                }else if (indexSwitch==1122){
                    oEstateSceneryModel.花园花架=@"花园/花架";
                }else if (indexSwitch==1024){
                    oEstateSceneryModel.凉亭=@"凉亭";
                }else if (indexSwitch==1123){
                    oEstateSceneryModel.水池喷泉=@"水池/喷泉";
                }else if (indexSwitch==1025){
                    oEstateSceneryModel.回廊=@"回廊";
                }else if (indexSwitch==1124){
                    oEstateSceneryModel.雕塑=@"雕塑";
                }else if (indexSwitch==1026){
                    oEstateSceneryModel.休闲桌椅=@"休闲桌椅";
                }else if (indexSwitch==1125){
                    oEstateSceneryModel.假山=@"假山";
                }else if (indexSwitch==1031){
                    oEstateActivityModel.图书馆=@"图书馆";
                }else if (indexSwitch==1130){
                    oEstateActivityModel.棋牌室=@"棋牌室";
                }else if (indexSwitch==1032){
                    oEstateActivityModel.健身设施=@"健身设施";
                }else if (indexSwitch==1131){
                    oEstateActivityModel.儿童活动场所=@"儿童活动场所";
                }else if (indexSwitch==1033){
                    oEstateActivityModel.多功能活动中心=@"多功能活动中心";
                }else if (indexSwitch==1132){
                    oEstateActivityModel.其它=@"其它";
                    [_lowArray replaceObjectAtIndex:section withObject:@"YES"];
                    [self Refresh:section];
                }else if (indexSwitch==1034){
                    oEstateMotionModel.网球场=@"网球场";
                }else if (indexSwitch==1133){
                    oEstateMotionModel.羽毛球场=@"羽毛球场";
                }else if (indexSwitch==1035){
                    oEstateMotionModel.篮球场=@"篮球场";
                }else if (indexSwitch==1134){
                    oEstateMotionModel.乒乓球台=@"乒乓球台";
                }else if (indexSwitch==1036){
                    oEstateMotionModel.室内泳池=@"室内泳池";
                }else if (indexSwitch==1135){
                    oEstateMotionModel.室外泳池=@"室外泳池";
                }else if (indexSwitch==1037){
                    oEstateMotionModel.室内健身房=@"室内健身房";
                }else if (indexSwitch==1136){
                    oEstateMotionModel.桌球=@"桌球";
                }else if (indexSwitch==1038){
                    oEstateMotionModel.其它=@"其它";
                    [_lowArray replaceObjectAtIndex:section withObject:@"YES"];
                    [self Refresh:section];
                }else if (indexSwitch==1050){
                    oEstateDisadvantageModel.城中村=@"城中村";
                }else if (indexSwitch==1149){
                    oEstateDisadvantageModel.加油站=@"加油站";
                }else if (indexSwitch==1051){
                    oEstateDisadvantageModel.工厂=@"工厂";
                }else if (indexSwitch==1150){
                    oEstateDisadvantageModel.污水处理厂=@"污水处理厂";
                }else if (indexSwitch==1052){
                    oEstateDisadvantageModel.电厂=@"电厂";
                }else if (indexSwitch==1151){
                    oEstateDisadvantageModel.高压线=@"高压线";
                }else if (indexSwitch==1053){
                    oEstateDisadvantageModel.铁路=@"铁路";
                }else if (indexSwitch==1152){
                    oEstateDisadvantageModel.垃圾站=@"垃圾站";
                }else if (indexSwitch==1054){
                    oEstateDisadvantageModel.其它=@"其它";
                    [_lowArray replaceObjectAtIndex:section withObject:@"YES"];
                    [self Refresh:section];
                }
            }else{
                if (indexSwitch==1016) {
                    oEstateSecurityModel.小时保安=@"";
                }else if (indexSwitch==1115){
                    oEstateSecurityModel.定时巡逻=@"";
                }else if (indexSwitch==1017){
                    oEstateSecurityModel.闭路电视监控系统=@"";
                }else if (indexSwitch==1116){
                    oEstateSecurityModel.智能IC卡门禁系统=@"";
                }else if (indexSwitch==1018){
                    oEstateSecurityModel.可视门禁系统=@"";
                }else if (indexSwitch==1117){
                    oEstateSecurityModel.智能车场管理系统=@"";
                }else if (indexSwitch==1019){
                    oEstateSecurityModel.红外防盗报警系统=@"";
                }else if (indexSwitch==1023){
                    oEstateSceneryModel.草坪=@"";
                }else if (indexSwitch==1122){
                    oEstateSceneryModel.花园花架=@"";
                }else if (indexSwitch==1024){
                    oEstateSceneryModel.凉亭=@"";
                }else if (indexSwitch==1123){
                    oEstateSceneryModel.水池喷泉=@"";
                }else if (indexSwitch==1025){
                    oEstateSceneryModel.回廊=@"";
                }else if (indexSwitch==1124){
                    oEstateSceneryModel.雕塑=@"";
                }else if (indexSwitch==1026){
                    oEstateSceneryModel.休闲桌椅=@"";
                }else if (indexSwitch==1125){
                    oEstateSceneryModel.假山=@"假山";
                }else if (indexSwitch==1031){
                    oEstateActivityModel.图书馆=@"";
                }else if (indexSwitch==1130){
                    oEstateActivityModel.棋牌室=@"";
                }else if (indexSwitch==1032){
                    oEstateActivityModel.健身设施=@"";
                }else if (indexSwitch==1131){
                    oEstateActivityModel.儿童活动场所=@"";
                }else if (indexSwitch==1033){
                    oEstateActivityModel.多功能活动中心=@"";
                }else if (indexSwitch==1132){
                    oEstateActivityModel.其它=@"";
                    [_lowArray replaceObjectAtIndex:section withObject:@"NO"];
                    [self Refresh:section];
                }else if (indexSwitch==1034){
                    oEstateMotionModel.网球场=@"";
                }else if (indexSwitch==1133){
                    oEstateMotionModel.羽毛球场=@"";
                }else if (indexSwitch==1035){
                    oEstateMotionModel.篮球场=@"";
                }else if (indexSwitch==1134){
                    oEstateMotionModel.乒乓球台=@"";
                }else if (indexSwitch==1036){
                    oEstateMotionModel.室内泳池=@"";
                }else if (indexSwitch==1135){
                    oEstateMotionModel.室外泳池=@"";
                }else if (indexSwitch==1037){
                    oEstateMotionModel.室内健身房=@"";
                }else if (indexSwitch==1136){
                    oEstateMotionModel.桌球=@"";
                }else if (indexSwitch==1038){
                    oEstateMotionModel.其它=@"";
                    [_lowArray replaceObjectAtIndex:section withObject:@"NO"];
                    [self Refresh:section];
                }else if (indexSwitch==1050){
                    oEstateDisadvantageModel.城中村=@"";
                }else if (indexSwitch==1149){
                    oEstateDisadvantageModel.加油站=@"";
                }else if (indexSwitch==1051){
                    oEstateDisadvantageModel.工厂=@"";
                }else if (indexSwitch==1150){
                    oEstateDisadvantageModel.污水处理厂=@"";
                }else if (indexSwitch==1052){
                    oEstateDisadvantageModel.电厂=@"";
                }else if (indexSwitch==1151){
                    oEstateDisadvantageModel.高压线=@"";
                }else if (indexSwitch==1053){
                    oEstateDisadvantageModel.铁路=@"";
                }else if (indexSwitch==1152){
                    oEstateDisadvantageModel.垃圾站=@"";
                }else if (indexSwitch==1054){
                    oEstateDisadvantageModel.其它=@"";
                    [_lowArray replaceObjectAtIndex:section withObject:@"NO"];
                    [self Refresh:section];
                }
            }
        };
        lowSelectDateView.titleSwitch.on=NO;
        lowSelectDateView.titleSwitch1.on=NO;
        lowSelectDateView.cellTitleLable.text=nil;
        if (section==15) {
            lowSelectDateView.cellTitleLable.text=@"安保情况";
            if ([oEstateSecurityModel.小时保安 isEqualToString:@"24小时保安"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateSecurityModel.定时巡逻 isEqualToString:@"定时巡逻"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==16){
            if ([oEstateSecurityModel.闭路电视监控系统 isEqualToString:@"闭路电视监控系统"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateSecurityModel.智能IC卡门禁系统 isEqualToString:@"智能IC卡门禁系统"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==17){
            if ([oEstateSecurityModel.可视门禁系统 isEqualToString:@"可视门禁系统"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateSecurityModel.智能车场管理系统 isEqualToString:@"智能车场管理系统"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==18){
            if ([oEstateSecurityModel.红外防盗报警系统 isEqualToString:@"红外防盗报警系统"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            
        }else if (section==22){
            lowSelectDateView.cellTitleLable.text=@"小区景观绿化设施";
            if ([oEstateSceneryModel.草坪 isEqualToString:@"草坪"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateSceneryModel.花园花架 isEqualToString:@"花园花架"]||[oEstateSceneryModel.花园花架 isEqualToString:@"花园/花架"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
            
        }else if (section==23){
            if ([oEstateSceneryModel.凉亭 isEqualToString:@"凉亭"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateSceneryModel.水池喷泉 isEqualToString:@"水池喷泉"]||[oEstateSceneryModel.水池喷泉 isEqualToString:@"水池/喷泉"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==24){
            if ([oEstateSceneryModel.回廊 isEqualToString:@"回廊"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateSceneryModel.雕塑 isEqualToString:@"雕塑"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==25){
            if ([oEstateSceneryModel.休闲桌椅 isEqualToString:@"休闲桌椅"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateSceneryModel.假山 isEqualToString:@"假山"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==30){
            lowSelectDateView.cellTitleLable.text=@"活动设施";
            if ([oEstateActivityModel.图书馆 isEqualToString:@"图书馆"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateActivityModel.棋牌室 isEqualToString:@"棋牌室"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==31){
            if ([oEstateActivityModel.健身设施 isEqualToString:@"健身设施"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateActivityModel.儿童活动场所 isEqualToString:@"儿童活动场所"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==32){
            if ([oEstateActivityModel.多功能活动中心 isEqualToString:@"多功能活动中心"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateActivityModel.其它 isEqualToString:@"其它"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==33){
            lowSelectDateView.cellTitleLable.text=@"运动设施";
            if ([oEstateMotionModel.网球场 isEqualToString:@"网球场"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateMotionModel.羽毛球场 isEqualToString:@"羽毛球场"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==34){
            if ([oEstateMotionModel.篮球场 isEqualToString:@"篮球场"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateMotionModel.乒乓球台 isEqualToString:@"乒乓球台"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==35){
            if ([oEstateMotionModel.室内泳池 isEqualToString:@"室内泳池"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateMotionModel.室外泳池 isEqualToString:@"室外泳池"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==36){
            if ([oEstateMotionModel.室内健身房 isEqualToString:@"室内健身房"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateMotionModel.桌球 isEqualToString:@"桌球"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==37){
            if ([oEstateMotionModel.其它 isEqualToString:@"其它"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            
        }else if (section==49){
            lowSelectDateView.cellTitleLable.text=@"不利因素";
            if ([oEstateDisadvantageModel.城中村 isEqualToString:@"城中村"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateDisadvantageModel.加油站 isEqualToString:@"加油站"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==50){
            if ([oEstateDisadvantageModel.工厂 isEqualToString:@"工厂"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateDisadvantageModel.污水处理厂 isEqualToString:@"污水处理厂"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==51){
            if ([oEstateDisadvantageModel.电厂 isEqualToString:@"电厂"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateDisadvantageModel.高压线 isEqualToString:@"高压线"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==52){
            if ([oEstateDisadvantageModel.铁路 isEqualToString:@"铁路"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oEstateDisadvantageModel.垃圾站 isEqualToString:@"垃圾站"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==53){
            if ([oEstateDisadvantageModel.其它 isEqualToString:@"其它"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            
        }
        return lowSelectDateView;
    }else if(section==19||(section>=26&&section<=29)||(section>=38&&section<=48)){
        
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier6];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier6 DataArray:array];
        }
        houseSelectView.tag=section+1000;
        //        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:_SwitchIndex];
        houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            NSLog(@"%ld",Tag);
            if (selectIndex==0) {
                [self.lowArray replaceObjectAtIndex:section withObject:@"YES"];
            }else{
                [self.lowArray replaceObjectAtIndex:section withObject:@"NO"];
            }
            if (Tag==1019) {
                oEstateListModel.专业绿化养护管理=[array objectAtIndex:selectIndex];
            }else if (Tag==1026){
                oEstateListModel.商场=[array objectAtIndex:selectIndex];
            }else if (Tag==1027){
                oEstateListModel.超市=[array objectAtIndex:selectIndex];
            }else if (Tag==1028){
                oEstateListModel.社区医院=[array objectAtIndex:selectIndex];
            }else if (Tag==1029){
                oEstateListModel.会所=[array objectAtIndex:selectIndex];
            }else if (Tag==1038){
                oEstateListModel.托儿所=[array objectAtIndex:selectIndex];
            }else if (Tag==1039){
                oEstateListModel.幼儿园=[array objectAtIndex:selectIndex];
            }else if (Tag==1040){
                oEstateListModel.小学=[array objectAtIndex:selectIndex];
            }else if (Tag==1041){
                oEstateListModel.中学=[array objectAtIndex:selectIndex];
            }else if (Tag==1042){
                oEstateListModel.学位=[array objectAtIndex:selectIndex];
            }else if (Tag==1043){
                oEstateListModel.海滨=[array objectAtIndex:selectIndex];
            }else if (Tag==1044){
                oEstateListModel.河流湖泊=[array objectAtIndex:selectIndex];
            }else if (Tag==1045){
                oEstateListModel.山景=[array objectAtIndex:selectIndex];
            }else if (Tag==1046){
                oEstateListModel.人文景观广场=[array objectAtIndex:selectIndex];
            }else if (Tag==1047){
                oEstateListModel.公园=[array objectAtIndex:selectIndex];
            }else if (Tag==1048){
                oEstateListModel.高尔夫球场=[array objectAtIndex:selectIndex];
            }
            [self Refresh:section];
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:1];
        if (section==19) {
            [self select_init:oEstateListModel.专业绿化养护管理 SelectView:houseSelectView];
        }else if (section==26){
            [self select_init:oEstateListModel.商场 SelectView:houseSelectView];
        }else if (section==27){
            [self select_init:oEstateListModel.超市 SelectView:houseSelectView];
        }else if (section==28){
            [self select_init:oEstateListModel.社区医院 SelectView:houseSelectView];
        }else if (section==29){
            [self select_init:oEstateListModel.会所 SelectView:houseSelectView];
        }else if (section==38){
            [self select_init:oEstateListModel.托儿所 SelectView:houseSelectView];
        }else if (section==39){
            [self select_init:oEstateListModel.幼儿园 SelectView:houseSelectView];
        }else if (section==40){
            [self select_init:oEstateListModel.小学 SelectView:houseSelectView];
        }else if (section==41){
            [self select_init:oEstateListModel.中学 SelectView:houseSelectView];
        }else if (section==42){
            [self select_init:oEstateListModel.学位 SelectView:houseSelectView];
        }else if (section==43){
            [self select_init:oEstateListModel.海滨 SelectView:houseSelectView];
        }else if (section==44){
            [self select_init:oEstateListModel.河流湖泊 SelectView:houseSelectView];
        }else if (section==45){
            [self select_init:oEstateListModel.山景 SelectView:houseSelectView];
        }else if (section==46){
            [self select_init:oEstateListModel.人文景观广场 SelectView:houseSelectView];
        }else if (section==47){
            [self select_init:oEstateListModel.公园 SelectView:houseSelectView];
        }else if (section==48){
            [self select_init:oEstateListModel.高尔夫球场 SelectView:houseSelectView];
        }

        return houseSelectView;
    } else
    {
        //        图片
        PhotoView *lowSelectDateView=(PhotoView *)[self C_init:Identifier20 ];
        lowSelectDateView.tag=section+1000;
        NSArray *array=[_dropDownArray objectAtIndex:section];
        [lowSelectDateView _init:[key objectAtIndex:0]PhImage:nil];
//        if (array.count!=0) {
//            if ([[array objectAtIndex:3] count]!=0) {
//                [lowSelectDateView _init:[key objectAtIndex:0]PhImage:[[array objectAtIndex:3] objectAtIndex:0]];
//            }
//            
//        }
        if (section==55&&oEstateListModel.楼栋平面图) {
            [NetworkManager _initSdImage:[NetworkManager jiequStr:oEstateListModel.楼栋平面图 rep:@","] ImageView:lowSelectDateView.phImageView];
        }else if (section==56&&oEstateListModel.楼盘外观照片){
            [NetworkManager _initSdImage:[NetworkManager jiequStr:oEstateListModel.楼盘外观照片 rep:@","] ImageView:lowSelectDateView.phImageView];
        }
        lowSelectDateView.Clock=^(NSInteger ClockTag){
//            NSArray *array=[_dropDownArray objectAtIndex:ClockTag-1000];
            NSLog(@"%ld",ClockTag);
            NSString *str=[NetworkManager Datastrings:[[self.baseArray objectAtIndex:ClockTag-1000] allKeys]];
            NSLog(@"%@",str);
            POHViewController *pOHViewController=[[POHViewController alloc]initWithNibName:@"POHViewController" bundle:nil];
            
            if (ClockTag==1055) {
                NSMutableArray *PHarray=[NetworkManager address:oEstateListModel.楼栋平面图];
                if (PHarray.count==0) {
                    PHarray = [NSMutableArray arrayWithCapacity:1];
                }
                pOHViewController.PHOarray=PHarray;
                pOHViewController.successfulIndex = PHarray.count;
            }else if (ClockTag==1056) {
                NSMutableArray *PHarray=[NetworkManager address:oEstateListModel.楼盘外观照片];
                if (PHarray.count==0) {
                    PHarray = [NSMutableArray arrayWithCapacity:1];
                }
                pOHViewController.PHOarray=PHarray;
                pOHViewController.successfulIndex = PHarray.count;
            }
            
            
            [self.navigationController pushViewController:pOHViewController animated:YES];
            pOHViewController.ClockSave=^(NSArray *ArrayID,NSString *ImageUrl){
                if (ClockTag==1055) {
                    oEstateListModel.楼栋平面图=ImageUrl;
                    [IDs addObject:ArrayID];
                }else if (ClockTag==1056) {
                    oEstateListModel.楼盘外观照片=ImageUrl;
                    [IDs addObject:ArrayID];
                }
                [tableView reloadData];
            };
            pOHViewController.imageType=str;
            pOHViewController.orderType=@"houseDLoupan";
            pOHViewController.ID=oEstateListModel.ID;
            pOHViewController.stakID=self.estateID;
            pOHViewController.selectMax=5;
//            NSArray *array=[_dropDownArray objectAtIndex:ClockTag-1000];
//            NSLog(@"%d",ClockTag);
//            PhotoPickerViewController *photoPickerViewController=[[PhotoPickerViewController alloc]init];
//            if (array.count!=0) {
//                photoPickerViewController.LQPhotoPicker_selectedAssetArray=[NSMutableArray arrayWithArray:[array objectAtIndex:0]];
//                photoPickerViewController.LQPhotoPicker_smallImageArray=[NSMutableArray arrayWithArray:[array objectAtIndex:3]];
//                photoPickerViewController.LQPhotoPicker_bigImageArray=[NSMutableArray arrayWithArray:[array objectAtIndex:1]];
//            }
//            if (ClockTag==1057) {
//                NSArray *aray=[NetworkManager address: oEstateListModel.楼栋平面图];
//                photoPickerViewController.LQPhotoPicker_smallImageArray=[NSMutableArray arrayWithArray:aray];
//                photoPickerViewController.Arraycount=aray.count;
//            }else if (ClockTag==1058) {
//                NSArray *aray=[NetworkManager address:oEstateListModel.楼盘外观照片];
//                photoPickerViewController.LQPhotoPicker_smallImageArray=[NSMutableArray arrayWithArray:aray];
//                photoPickerViewController.Arraycount=aray.count;
//            }
//
//            photoPickerViewController.ClockPhon=^(NSArray *phionImgeArray){
//                [_dropDownArray replaceObjectAtIndex:ClockTag-1000 withObject:phionImgeArray];
//                [self Refresh:ClockTag-1000];
//            };
//            photoPickerViewController.ClockSave=^(NSArray *ArrayID,NSString *ImageUrl){
//                if (ClockTag==1057) {
//                    oEstateListModel.楼栋平面图=ImageUrl;
//                    [IDs addObject:ArrayID];
//                }else if (ClockTag==1058) {
//                    oEstateListModel.楼盘外观照片=ImageUrl;
//                    [IDs addObject:ArrayID];
//                }
//            };
//            photoPickerViewController.type=self.selectSee;
//            NSString *str=[NetworkManager Datastrings:[[self.baseArray objectAtIndex:ClockTag-1000] allKeys]];
//            photoPickerViewController.imageType=str;
//            photoPickerViewController.orderType=@"houseDLoupan";
//            photoPickerViewController.ID=oEstateListModel.ID;
//            photoPickerViewController.stakID=self.estateID;
//            //            photoPickerViewController.LQPhotoPicker_selectedAssetArray=array;
//            [self.navigationController pushViewController:photoPickerViewController animated:YES];
        };
        return lowSelectDateView;

    }
    
}

-(void)select_init:(NSString *)title SelectView:(HouseSelectView *)selectView{
    if (!title) {
        title=@"无";
        }
        if ([title isEqualToString:@"有"]) {
            selectView.dVSwitch.selectedIndex=0;
        }else if([title isEqualToString:@"无"]){
            selectView.dVSwitch.selectedIndex=1;
        }
        
    
}

-(void)repleStr:(OEstateListModel *)RepleoEstateListModel{
    if ([RepleoEstateListModel.托儿所 isEqualToString:@"有"]) {
        [self reple:38];
    }else if([RepleoEstateListModel.幼儿园 isEqualToString:@"有"]){
        [self reple:39];
    }else if([RepleoEstateListModel.小学 isEqualToString:@"有"]){
        [self reple:40];
    }else if([RepleoEstateListModel.中学 isEqualToString:@"有"]){
        [self reple:41];
    }else if([RepleoEstateListModel.海滨 isEqualToString:@"有"]){
        [self reple:43];
    }else if([RepleoEstateListModel.河流湖泊 isEqualToString:@"有"]){
        [self reple:44];
    }else if([RepleoEstateListModel.山景 isEqualToString:@"有"]){
        [self reple:45];
    }else if([RepleoEstateListModel.人文景观广场 isEqualToString:@"有"]){
        [self reple:46];
    }else if([RepleoEstateListModel.公园 isEqualToString:@"有"]){
        [self reple:47];
    }else if([RepleoEstateListModel.高尔夫球场 isEqualToString:@"有"]){
        [self reple:48];
    }
}

-(void)reple:(NSInteger)index{
    [self.lowArray replaceObjectAtIndex:index withObject:@"YES"];
}

-(UITableViewHeaderFooterView *)C_init:(NSString *)mark{
    return [self.baseTableView dequeueReusableHeaderFooterViewWithIdentifier:mark];
    //    return [[[NSBundle mainBundle]loadNibNamed:xibName owner:self options:nil]lastObject];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (![self.selectSee isEqualToString:@"查看"]) {
        if (section==56) {
            return 44;
        }
    }
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (![self.selectSee isEqualToString:@"查看"]) {
        if (section==56) {
            LowFootView *lowFootView=(LowFootView *)[self C_init:Identifier7];
            lowFootView.SaveClock=^(){
                [self required];
            };
            return lowFootView;
        }
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)Refresh:(NSInteger)section{
    if (section==55) {
        [self.baseTableView reloadData];
    }else{
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
        [self.baseTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}

#pragma mark - 键盘弹出消失通知
- (void)registerForKeyboardNotifications
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
}


// Called when the UIKeyboardDidShowNotification is sent.

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    //    keyboardrHeight = kbSize.height;
    self.baseTableView.contentInset = contentInsets;
    self.baseTableView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    
    // Your app might not need or want this behavior.
    
    CGRect aRect = self.baseTableView.frame;
    
    aRect.size.height -= kbSize.height;
    
    if (!CGRectContainsPoint(aRect, fistTextField.frame.origin) ) {
        
        [self.baseTableView scrollRectToVisible:fistTextField.frame animated:YES];
    }
}


// Called when the UIKeyboardWillHideNotification is sent

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    self.baseTableView.contentInset = contentInsets;
    
    self.baseTableView.scrollIndicatorInsets = contentInsets;
    
}

#pragma mark UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    fistTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%ld",textField.tag);
    if (textField.tag==1000) {
        oEstateListModel.调查人=textField.text;
    }else if (textField.tag==1001){
        oEstateListModel.调查时间=textField.text;
    }else if (textField.tag==1004){
        oEstateListModel.实际楼盘名称=textField.text;
    }else if (textField.tag==10005){
        [self repn:textField.text Index:0 Datas:addressArray1];
    }else if (textField.tag==105){
        [self repn:textField.text Index:1 Datas:addressArray1];
    }else if (textField.tag==15){
        [self repn:textField.text Index:2 Datas:addressArray1];
    }else if (textField.tag==10006){
        [self repn:textField.text Index:0 Datas:addressArray2];
    }else if (textField.tag==106){
        [self repn:textField.text Index:1 Datas:addressArray2];
    }else if (textField.tag==16){
        [self repn:textField.text Index:2 Datas:addressArray2];
    }else if (textField.tag==1007){
        oEstateListModel.开发商=textField.text;
    }else if (textField.tag==1008){
        oEstateListModel.竣工年代=textField.text;
    }else if (textField.tag==1009){
        oEstateListModel.占地面积=textField.text;
    }else if (textField.tag==1010){
        oEstateListModel.车位总数=textField.text;
    }else if (textField.tag==1011){
        oEstateListModel.室内车位数=textField.text;
    }else if (textField.tag==1012){
        oEstateListModel.露天车位数=textField.text;
    }else if (textField.tag==1013){
        oEstateListModel.物业公司=textField.text;
    }else if (textField.tag==1014){
        oEstateListModel.物业管理费=textField.text;
    }else if (textField.tag==1020){
        oEstateListModel.容积率=textField.text;
    }else if (textField.tag==1021){
        oEstateListModel.绿地率=textField.text;
    }else if (textField.tag==1026){
        oEstateListModel.商场名称=textField.text;
    }else if (textField.tag==1027){
        oEstateListModel.超市名称=textField.text;
    }else if (textField.tag==1028){
        oEstateListModel.社区医院名称=textField.text;
    }else if (textField.tag==1029){
        oEstateListModel.会所个数=textField.text;
    }else if (textField.tag==10032){
        oEstateListModel.活动设施其它=textField.text;
    }else if (textField.tag==10037){
        oEstateListModel.运动设施其它=textField.text;
    }else if (textField.tag==10053){
        oEstateListModel.不利因素其它=textField.text;
    }else if (textField.tag==1054){
        oEstateListModel.楼盘其它特点=textField.text;
    }else if (textField.tag==10038){
        oEstateListModel.托儿所名称=textField.text;
    }else if (textField.tag==10039){
        oEstateListModel.幼儿园名称=textField.text;
    }else if (textField.tag==10040){
        oEstateListModel.小学名称=textField.text;
    }else if (textField.tag==10041){
        oEstateListModel.中学名称=textField.text;
    }else if (textField.tag==10043){
        oEstateListModel.海滨名称=textField.text;
    }else if (textField.tag==10044){
        oEstateListModel.河流湖泊名称=textField.text;
    }else if (textField.tag==10045){
        oEstateListModel.山景名称=textField.text;
    }else if (textField.tag==10046){
        oEstateListModel.人文景观广场名称=textField.text;
    }else if (textField.tag==10047){
        oEstateListModel.公园名称=textField.text;
    }else if (textField.tag==10048){
        oEstateListModel.高尔夫球场名称=textField.text;
    }else if (textField.tag==10026){
        oEstateListModel.商场名称=textField.text;
    }else if (textField.tag==10027){
        oEstateListModel.超市名称=textField.text;
    }else if (textField.tag==10028){
        oEstateListModel.社区医院名称=textField.text;
    }else if (textField.tag==10029){
        oEstateListModel.会所个数=textField.text;
    }
    fistTextField = nil;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"%ld",textField.tag);
    Indext=textField.tag;
    if (textField.tag==10006||textField.tag==10005){
        _citypick.trafficArray=[NetworkManager _readInit:@"city"];
    }
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

-(void)netSaveFormData{
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"保存中..."];
    typeof(self)SelfWeek=self;
    
    oEstateListModel.安保情况=[NSString stringWithFormat:@"24%@",[NetworkManager Datastrings:[oEstateSecurityModel.toDictionary allValues]]];
    NSLog(@"%@",[NetworkManager Datastrings:[oEstateDisadvantageModel.toDictionary allValues]]);
    oEstateListModel.不利因素=[NetworkManager Datastrings:[oEstateDisadvantageModel.toDictionary allValues]];
    NSLog(@"%@",oEstateListModel.不利因素);
    oEstateListModel.活动设施=[NetworkManager Datastrings:[oEstateActivityModel.toDictionary allValues]];
    NSLog(@"%@",oEstateListModel.活动设施);
    NSLog(@"%@",[NetworkManager Datastrings:[oEstateActivityModel.toDictionary allValues]]);
    oEstateListModel.运动设施=[NetworkManager Datastrings:[oEstateMotionModel.toDictionary allValues]];
    oEstateListModel.楼盘景观设施=[NetworkManager Datastrings:[oEstateSceneryModel.toDictionary allValues]];
    NSLog(@"%@",oEstateListModel.楼盘景观设施);
    NSLog(@"%@",[NetworkManager Datastrings:[oEstateSceneryModel.toDictionary allValues]]);
    //    把位置信息转成字符串付给对象属性
    oEstateListModel.地理位置1=[NetworkManager Datastrings:addressArray1];
    oEstateListModel.地理位置2=[NetworkManager Datastrings:addressArray2];
    
    NSMutableDictionary *dictSave=[[NSMutableDictionary alloc]initWithDictionary:oEstateListModel.toDictionary];
    if (self.estateID) {
        [dictSave setObject:self.estateID forKey:@"taskId"];
    }
    [dictSave setObject:@"houseDLoupan" forKey:@"makeType"];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dictSave relativePath:@"appAction!saveMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        SaveModel *saveModel=[[SaveModel alloc]initWithDictionary:responseObject error:nil];
        if (saveModel) {
            if ([saveModel.status isEqualToString:@"1"]) {
                for (NSArray *numbers in IDs) {
                    for (NSNumber *number in numbers) {
                        [[NetworkManager shar]updata:[number longLongValue] FormID:saveModel.ID TackId:[super replaceString:self.estateID]];
                    }
                }
                oEstateListModel.ID = saveModel.ID;

                [BaseView _init:saveModel.message View:SelfWeek.view];
                if (![self.selectSee isEqualToString:@"编辑"]) {
                    [SelfWeek postValues:@{@"ID":saveModel.ID,@"NAME":oEstateListModel.实际楼盘名称}];
                    
                    UIScrollView *scrollView=(UIScrollView *)self.view.superview;
                    [scrollView setContentOffset:CGPointMake(1*self.view.frame.size.width, 0) animated:YES];
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

-(void)postValues:(NSDictionary *)dict{
    //    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:self.textFieldOne.text,@"textOne",self.textFieldTwo.text,@"textTwo", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"OEloupan" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

//判断必填项
-(void)required{
    __block int count1 = 0;
    __block int count2 = 0;
    
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
    if (!oEstateListModel.实际楼盘名称){
        [BaseView _init:@"请输入实际楼盘名称" View:self.view];
    }else if (count1!=3&&count2!=3){
        [BaseView _init:@"请输入任意一个完整的地理位置信息" View:self.view];
    }else if (!oEstateListModel.物业公司){
        [BaseView _init:@"请输入物业公司" View:self.view];
    }else if (!oEstateListModel.楼栋平面图){
        [BaseView _init:@"请选择楼栋平面图" View:self.view];
    }else if ([NetworkManager address:oEstateListModel.楼栋平面图].count>1){
        [BaseView _init:@"楼栋平面图1张" View:self.view];
    }else if (!oEstateListModel.楼盘外观照片){
        [BaseView _init:@"请选择楼盘外观照片" View:self.view];
    }else if ([NetworkManager address:oEstateListModel.楼盘外观照片].count<2){
        [BaseView _init:@"楼盘外观照片2-5张" View:self.view];
    }else if ([oEstateListModel.托儿所 isEqualToString:@"有"]&&!oEstateListModel.托儿所名称){
        [BaseView _init:@"请输入托儿所名称" View:self.view];
    }else if ([oEstateListModel.幼儿园 isEqualToString:@"有"]&&!oEstateListModel.幼儿园名称){
        [BaseView _init:@"请输入幼儿园名称" View:self.view];
    }else if ([oEstateListModel.小学 isEqualToString:@"有"]&&!oEstateListModel.小学名称){
        [BaseView _init:@"请输入小学名称" View:self.view];
    }else if ([oEstateListModel.中学 isEqualToString:@"有"]&&!oEstateListModel.中学名称){
        [BaseView _init:@"请输入中学名称" View:self.view];
    }else if ([oEstateListModel.海滨 isEqualToString:@"有"]&&!oEstateListModel.海滨名称){
        [BaseView _init:@"请输入海滨名称" View:self.view];
    }else if ([oEstateListModel.河流湖泊 isEqualToString:@"有"]&&!oEstateListModel.河流湖泊名称){
        [BaseView _init:@"请输入河流湖泊名称" View:self.view];
    }else if ([oEstateListModel.山景 isEqualToString:@"有"]&&!oEstateListModel.山景名称){
        [BaseView _init:@"请输入山景名称" View:self.view];
    }else if ([oEstateListModel.人文景观广场 isEqualToString:@"有"]&&!oEstateListModel.人文景观广场名称){
        [BaseView _init:@"请输入人文景观广场名称" View:self.view];
    }else if ([oEstateListModel.公园 isEqualToString:@"有"]&&!oEstateListModel.公园名称){
        [BaseView _init:@"请输入公园名称" View:self.view];
    }else if ([oEstateListModel.高尔夫球场 isEqualToString:@"有"]&&!oEstateListModel.高尔夫球场名称){
        [BaseView _init:@"请输入高尔夫球场名称" View:self.view];
    }else{
        [self netSaveFormData];
    }
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
