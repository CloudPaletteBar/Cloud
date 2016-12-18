//
//  OfficeBanViewController.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "OfficeBanViewController.h"
#import "CloudPaletteBar.h"
#import "NetworkManager.h"
#import "LowEstateCell.h"
#import "LowPropertyNameView.h"
#import "FormInPutView.h"
#import "LowInvestigationView.h"
#import "LowSelectDateView.h"
#import "LowFootView.h"
#import "LowPackView.h"
#import "HouseSelectView.h"
#import "LowHouseSwitchView.h"
#import "PhotoView.h"
#import "PhotoPickerViewController.h"
#import "CalendarView.h"
#import "SelectFormPickerView.h"
#import "OfficeBanModel.h"
#import "ObtainModel.h"
#import "FormSelectTableView.h"
#import "MJRefresh.h"
#import "SaveModel.h"
#import "SaveImageModel.h"
#import "OSystemModel.h"
#import "POHViewController.h"

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

@interface OfficeBanViewController ()<UITextFieldDelegate,UISearchBarDelegate>{
    UITextField *fistTextField;
    OfficeBanModel *officeBanModel;
    OfficeBanListModel *officeBanListModel;
//    外墙照片
    OfficeBanListStandardPhModel *officeBanListStandardPhModel1;
    ////大堂照片
    OfficeBanListStandardPhModel *officeBanListStandardPhModel2;
    //标准层照片
    OfficeBanListStandardPhModel *officeBanListStandardPhModel3;
    NSInteger imageIndex;
//    主要用途
    OfficeBanListMainModel *officeBanListMainModel;
//    内部配套
    OfficeBanListInsideModel *officeBanListInsideModel;
    
//    租售模式
    OfficePatternListModel *officePatternListModel;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    FormSelectTableView *formSelectTableView;
    NSMutableDictionary *dicImage;
    NSMutableArray  *IDs;
    NSInteger TagView;
    NSMutableArray *timeArray;
    NSString *secarchName;
    UIView *formSelectView;
}
@property(nonatomic,strong)CalendarView *calendarView;
@property(nonatomic,strong)NSMutableArray *lowArray;
@property(nonatomic,strong)NSMutableArray *dropDownArray;
@property(nonatomic,assign)CGFloat noInvestigation;
@property(nonatomic,strong)SelectFormPickerView *selectFormPickerView;
@property(nonatomic,strong)NSMutableArray *selectArrays;
@property (nonatomic ,strong)UISearchBar *searchBar;
@end


@implementation OfficeBanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _noInvestigation=48;
    IDs=[[NSMutableArray alloc]init];
    dicImage=[[NSMutableDictionary alloc]init];
    self.baseTableView.frame=CGRectMake(0, 0, screen_width, screen_height-50-64);
     self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerHeat];
    self.lowArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OpenOrClose"]];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"LowEstateCell" bundle:nil] forCellReuseIdentifier:Identifier];
    //    LowEstate
    self.selectArrays=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"SelectIndex"]];
    self.baseArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OfficeBan"]];
    self.dropDownArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"Ban"]];
    _calendarView=[[[NSBundle mainBundle]loadNibNamed:@"CalendarView" owner:self options:nil]lastObject];
    [self.calendarView reloadWithDate: 3];
    _selectFormPickerView=[[[NSBundle mainBundle]loadNibNamed:@"SelectFormPickerView" owner:self options:nil]lastObject];
    [_selectFormPickerView _init:nil];
    [self registerForKeyboardNotifications];
//    [self netSysData:1];
    [self netFormData];
    
    formSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-150)];
    self.searchBar.frame = CGRectMake(0, 0, screen_width, 50.0);
    formSelectTableView=[[FormSelectTableView alloc]initWithFrame:CGRectMake(0, 50, screen_width, formSelectView.frame.size.height-50)];
    [formSelectView addSubview:formSelectTableView];
    __weak typeof(self)SelfWeak=self;
    [formSelectTableView _initOrderUP:^(int Page) {
        if (TagView==1000) {
            [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
        }else{
        [SelfWeak netSysData2:Page andName:[super replaceString:secarchName]];
        }
        
    } Down:^(int Page) {
        if (TagView==1000) {
            [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
        }else{
            [SelfWeak netSysData2:Page andName:[super replaceString:secarchName]];
        }
    }];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(officeloupan:) name:@"officeloupan" object:nil];
}


-(void)officeloupan:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"ID"]);
     NSLog(@"%@",text.userInfo[@"NAME"]);
    officeBanListModel.楼盘ID=text.userInfo[@"ID"];
    officeBanListModel.楼盘名称=text.userInfo[@"NAME"];
    [self.baseTableView reloadData];
}

-(void)registerHeat{
    [self registerHeat:@"FormInPutView" Mark:Identifier1];
    [self registerHeat:@"LowSelectDateView" Mark:Identifier2];
    [self registerHeat:@"LowPropertyNameView" Mark:Identifier3];
    [self registerHeat:@"LowInvestigationView" Mark:Identifier4];
    [self registerHeat:@"LowPackView" Mark:Identifier5];
    [self registerHeat:@"LowFootView" Mark:Identifier7];
    [self registerHeat:@"LowHouseSwitchView" Mark:Identifier12];
    [self registerHeat:@"PhotoView" Mark:Identifier20];
    
    //    [self registerHeat:@"HouseSelectView" Mark:Identifier6];
    //    [self.baseTableView registerClass:[HouseSelectView class] forHeaderFooterViewReuseIdentifier:Identifier6];
}
//获取系统楼盘编号和系统楼盘名称
-(void)netSysData2:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"tradeBuding",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":[super replaceString:officeBanListModel.楼盘名称],@"budingName":name}];
    if (self.estateID) {
        [dic setObject:self.estateID forKey:@"taskId"];
    }
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appSelect!getBuding.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        Arraykeys=[[NSMutableArray alloc]init];
        Arrayvalues=[[NSMutableArray alloc]init];
        timeArray=[[NSMutableArray alloc]init];
        [SelfWeek tableviewEnd];
        ObtainModel *systemModel = [[ObtainModel alloc]initWithDictionary:responseObject error:nil];
        if (systemModel) {
            if ([systemModel.status isEqualToString:@"1"]) {
                for (ObtainListModel *systemListModel in systemModel.list) {
                    [ Arraykeys addObject:systemListModel.楼栋编号];
                    [timeArray addObject:[NetworkManager interceptStrTo:systemListModel.CONST_ENDDATE PleStr:@" "]];
                    [ Arrayvalues addObject:systemListModel.系统楼栋名称];
                }
                    formSelectTableView.formSelectArray=Arrayvalues;
            }
        }
        
    } failure:^(NSError *error) {
        [SelfWeek tableviewEnd];
    }];
}

//获取楼盘选择
-(void)netSysData:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"officeLoupan",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":name}];
    if (self.estateID) {
        [dic setObject:self.estateID forKey:@"taskId"];
    }
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appSelect!getLoupan.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        Arraykeys=[[NSMutableArray alloc]init];
        Arrayvalues=[[NSMutableArray alloc]init];
        [SelfWeek tableviewEnd];
        OSystemModel *obtainModel = [[OSystemModel alloc]initWithDictionary:responseObject error:nil];
        if (obtainModel) {
            if ([obtainModel.status isEqualToString:@"1"]) {
                for (OSystemListModel *obtainListModel in obtainModel.list) {
                    [ Arraykeys addObject:obtainListModel.楼盘ID];
                    [ Arrayvalues addObject:obtainListModel.实际楼盘名称];
                }
                    formSelectTableView.formSelectArray=Arrayvalues;
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
    if (TagView==1000) {
        [self netSysData:1 andName:secarchName];
    }else{
        [self netSysData2:1 andName:secarchName];
    }
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
    if (TagView==1000) {
        [self netSysData:1 andName:secarchName];
    }else{
        [self netSysData2:1 andName:secarchName];
    }
}

-(void)tableviewEnd{
    [formSelectTableView.mj_header endRefreshing];
    [formSelectTableView.mj_footer endRefreshing];
}

-(void)Init_o{
    officeBanListMainModel=[[OfficeBanListMainModel alloc]init];
    officeBanListModel=[[OfficeBanListModel alloc]init];
    officeBanListInsideModel=[[OfficeBanListInsideModel alloc]init];
    officeBanListStandardPhModel1=[[OfficeBanListStandardPhModel alloc]init];
    officeBanListStandardPhModel2=[[OfficeBanListStandardPhModel alloc]init];
    officeBanListStandardPhModel3=[[OfficeBanListStandardPhModel alloc]init];
    officePatternListModel=[[OfficePatternListModel alloc]init];
}
//获取表单数据

-(void)netFormData{
   
   
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"officeBuding"}];
    if (self.estateID) {
        if ([kUserDefaults objectForKey:@"officeId"]!=NULL) {
            [dic setObject:self.estateID forKey:@"taskId"];
//            if (self.selectIndex==1) {
                [dic setObject:[super replaceString:[kUserDefaults objectForKey:@"officeId" ]] forKey:@"ID"];
//            }else{
//                [dic setObject:@"0" forKey:@"ID"];
//            }
            [self Init_o];
            [self netWork:dic];
        }else{
            [self Init_o];
        }
    }else{
        if ([kUserDefaults objectForKey:@"officeId" ]!=NULL) {
//            if (self.selectIndex==1) {
                [dic setObject:[super replaceString:[kUserDefaults objectForKey:@"officeId" ]] forKey:@"ID"];
//            }else{
//                [dic setObject:@"0" forKey:@"ID"];
//            }
            [self Init_o];
            [self netWork:dic];
        }else{
            [self Init_o];
        }
    }
}

-(void)netWork:(NSDictionary *)dic{
     typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressOneHUD:self.view Title:@"获取中..."];
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        officeBanModel = [[OfficeBanModel alloc]initWithDictionary:responseObject error:nil];
        if (officeBanModel) {
            if ([officeBanModel.status isEqualToString:@"1"]) {
                if (officeBanModel.list.count>0) {
                    officeBanListModel=[officeBanModel.list objectAtIndex:0];
                    officeBanListMainModel=[[OfficeBanListMainModel alloc]initWithDictionary:[NetworkManager stringDictionary:officeBanListModel.主要用途] error:nil];
                    officeBanListInsideModel=[[OfficeBanListInsideModel alloc]initWithDictionary:[NetworkManager stringDictionary:officeBanListModel.内部配套] error:nil];
                    officeBanListStandardPhModel1=[[OfficeBanListStandardPhModel alloc]initWithDictionary:[NetworkManager stringDictionaryImge:officeBanListModel.外墙照片] error:nil];
                    officeBanListStandardPhModel2=[[OfficeBanListStandardPhModel alloc]initWithDictionary:[NetworkManager stringDictionaryImge:officeBanListModel.大堂照片] error:nil];
                    officeBanListStandardPhModel3=[[OfficeBanListStandardPhModel alloc]initWithDictionary:[NetworkManager stringDictionaryImge:officeBanListModel.标准层平面图] error:nil];
                    officePatternListModel=[[OfficePatternListModel alloc]initWithDictionary:[NetworkManager stringDictionary:officeBanListModel.租售模式] error:nil];
                    [self re];
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

-(void)re{
   
    if([self panduan:officeBanListModel.主要用途 Baohan:@"其它"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:12 withObject:@"YES"];
    }
    if ([self panduan: officeBanListModel.内部配套 Baohan:@"其它"]) {
        [_lowArray replaceObjectAtIndex:35 withObject:@"YES"];
    }if ([self panduan: officeBanListModel.租售模式 Baohan:@"其它"]) {
        [_lowArray replaceObjectAtIndex:43 withObject:@"YES"];
    }if ([self panduan: officeBanListModel.办公楼栋类型 Baohan:@"其他" ]||[self panduan: officeBanListModel.办公楼栋类型 Baohan:@"其它"]) {
        [_lowArray replaceObjectAtIndex:9 withObject:@"YES"];
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
    return _noInvestigation;
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
    NSLog(@"%d   %d",indexPath.section,indexPath.row);
    LowEstateCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary *dic=[self.baseArray objectAtIndex:indexPath.section];
    NSArray *key=[dic allKeys];
    NSArray *value=[dic objectForKey:[key objectAtIndex:0]];
    [cell _cellInit:[value objectAtIndex:indexPath.row] Weather:@"必填"];
    cell.cellTextField.text=@"";
    cell.cellTextField.tag=10000+indexPath.section;
    cell.cellTextField.delegate=self;
    if (officeBanListModel.无法调查说明) {
        cell.cellTextField.text=officeBanListModel.无法调查说明;
    }else if (indexPath.section==9){
        cell.cellTextField.text=officeBanListModel.楼栋类型其它;
    }else if (indexPath.section==13){
        cell.cellTextField.text=officeBanListModel.主要用途其它;
    }else if (indexPath.section==13){
        cell.cellTextField.text=officeBanListModel.主要用途其它;
    }else if (indexPath.section==35){
        cell.cellTextField.text=officeBanListModel.内部配套其它;
    }else if (indexPath.section==43){
        cell.cellTextField.text=officeBanListModel.租售模式其它;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (!self.estateID) {
        if (section==4) {
            return 0;
        }else if (section==11||section==15||section==18||section==21||section==31||section==42) {
            return 65;
        }else if (section==10)
        {
            return 0;
        }
            return 44;
    }else{
        if (section==11||section==15||section==18||section==21||section==31||section==42) {
            return 65;
        }else if (section==10)
        {
            return 0;
        }
        return 44;
    }
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary *dic=[self.baseArray objectAtIndex:section];
    NSArray *key=[dic allKeys];
    typeof(self)SelfWeek=self;
    if (section==3||section==7||section==8||section==26||section==27||section==29||section==30||section==37||section==38||section==46) {
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier1 ];
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        formInPutView.formTextField.keyboardType=UIKeyboardTypeDefault;
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"必填"];
        formInPutView.formTextField.text=@"";
        if (section==3&&officeBanListModel.实际楼栋名称) {
            formInPutView.formTextField.text=officeBanListModel.实际楼栋名称;
        }else if (section==7){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (officeBanListModel.地上楼层) {
                formInPutView.formTextField.text=officeBanListModel.地上楼层;
            }
            
        }else if (section==8){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (officeBanListModel.地下楼层) {
                formInPutView.formTextField.text=officeBanListModel.地下楼层;
            }
            
        }else if (section==26){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (officeBanListModel.客梯数量) {
                formInPutView.formTextField.text=officeBanListModel.客梯数量;
            }
            
        }else if (section==27){
             formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (officeBanListModel.货梯数量) {
                formInPutView.formTextField.text=officeBanListModel.货梯数量;
            }
            
        }else if (section==29){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (officeBanListModel.地上停车位) {
                formInPutView.formTextField.text=officeBanListModel.地上停车位;
            }
            
        }else if (section==30){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (officeBanListModel.地下停车位) {
                formInPutView.formTextField.text=officeBanListModel.地下停车位;
            }
            
        }else if (section==37&&officeBanListModel.物业管理公司){
            formInPutView.formTextField.text=officeBanListModel.物业管理公司;
        }else if (section==38){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (officeBanListModel.物业管理费) {
                formInPutView.formTextField.text=officeBanListModel.物业管理费;
            }
            
        }else if (section==46){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (officeBanListModel.租金) {
                formInPutView.formTextField.text=officeBanListModel.租金;
            }
            
        }
        return formInPutView;
    }else if (section==5){
        LowSelectDateView *lowSelectDateView=(LowSelectDateView *)[self C_init:Identifier2 ];
        lowSelectDateView.titleTextField.tag=section+1000;
        lowSelectDateView.titleTextField.delegate=self;
        [lowSelectDateView _init:[key objectAtIndex:0]InPutView:_calendarView];
        _calendarView.ClockDate=^(NSString * dateStr){
            lowSelectDateView.titleTextField.text=[NetworkManager str:dateStr];
        };
//        if (!officeBanListModel.竣工时间) {
//            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//            [formatter setDateFormat:@"yyyy.MM.dd"];
//            officeBanListModel.竣工时间=[formatter stringFromDate:[NSDate date]];
//            
//        }
        lowSelectDateView.titleTextField.text=officeBanListModel.竣工时间;
        return lowSelectDateView;
        
    }else if (section>=0&&section<=2){
        LowPropertyNameView *lowPropertyNameView=(LowPropertyNameView *)[self C_init:Identifier3 ];
        lowPropertyNameView.tag=1000+section;
        [lowPropertyNameView _init:[key objectAtIndex:0] Weather:@"自动设置"];
        
        lowPropertyNameView.ClockLow=^(NSInteger Tag){
            if (Tag) {
                NSLog(@"%ld",Tag);
                TagView=Tag;
                if (Tag==1002) {
                    if (!officeBanListModel.楼盘ID) {
                        [BaseView _init:@"请选择楼盘" View:SelfWeek.view];
                         return;
                    }
                   
                }
                formSelectTableView.formSelectArray=nil;
                [formSelectTableView.mj_header beginRefreshing];
                
                
//                else{
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
            if (formSelectTableView.TagT==1002) {
                officeBanListModel.系统楼栋名称=selectStr;
                officeBanListModel.楼栋编号=[Arraykeys objectAtIndex:Index];
                officeBanListModel.竣工时间=[NetworkManager interceptStrTo:[timeArray objectAtIndex:Index] PleStr:@" "]; 
                
            }else{
                officeBanListModel.楼盘名称=selectStr;
                officeBanListModel.楼盘ID=[Arraykeys objectAtIndex:Index];
//                officeBanListModel.楼栋编号=[Arrayvalues objectAtIndex:Index];
//                officeBanListModel.系统楼栋名称=selectStr;
            }
            [self.baseTableView reloadData];
        };
        lowPropertyNameView.titleTextField.text=@"";
        lowPropertyNameView.selectButton.hidden=NO;
        if (section==0&&officeBanListModel.楼盘名称) {
            lowPropertyNameView.titleTextField.text=officeBanListModel.楼盘名称;
        }else if (section==1){
            lowPropertyNameView.selectButton.hidden=YES;
            if (officeBanListModel.楼栋编号) {
                lowPropertyNameView.titleTextField.text=officeBanListModel.楼栋编号;
            }
            
        }else if (section==2&&officeBanListModel.系统楼栋名称){
            lowPropertyNameView.titleTextField.text=officeBanListModel.系统楼栋名称;
        }
        return lowPropertyNameView;
    }else if (section==10||section==14||section==25||section==36||section==41||section==45||section==47) {
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier1 ];
        formInPutView.formTextField.keyboardType=UIKeyboardTypeDefault;
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"选填"];
        formInPutView.formTextField.text=@"";
        if (section==0&&officeBanListModel.楼盘名称) {
            formInPutView.formTextField.text=officeBanListModel.楼盘名称;
        }else if (section==10&&officeBanListModel.楼栋类型其它) {
            formInPutView.formTextField.text=officeBanListModel.楼栋类型其它;
        }
        else if (section==14&&officeBanListModel.主要用途其它){
            formInPutView.formTextField.text=officeBanListModel.主要用途其它;
        }else if (section==36&&officeBanListModel.配套设施备注){
            formInPutView.formTextField.text=officeBanListModel.配套设施备注;
        }else if (section==41&&officeBanListModel.物业管理备注){
            formInPutView.formTextField.text=officeBanListModel.物业管理备注;
        }else if (section==45){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (officeBanListModel.售价) {
                formInPutView.formTextField.text=officeBanListModel.售价;
            }
            
        }else if (section==47&&officeBanListModel.租售情况备注){
            formInPutView.formTextField.text=officeBanListModel.租售情况备注;
        }
        return formInPutView;
    }else if(section==4)
    {
        LowInvestigationView *lowInvestigationView=(LowInvestigationView *)[self C_init:Identifier4 ];
        lowInvestigationView.tag=1000000;
        lowInvestigationView.Clock=^(BOOL open){
            if (open) {
                UIActionSheet *alettView=[[UIActionSheet alloc]initWithTitle:nil delegate:SelfWeek cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"无法找到楼栋位置",@"已找到楼栋但无法进入", nil];
                [alettView showInView:self.view];

            }else{
                _noInvestigation=48;
                [_lowArray replaceObjectAtIndex:4 withObject:@"NO"];
                [_lowArray replaceObjectAtIndex:17 withObject:@"NO"];
                [tableView reloadData];
            }
            
            
        };
        [lowInvestigationView _init:[key objectAtIndex:0] OpenClose:[[_lowArray objectAtIndex:section]boolValue]];
        return lowInvestigationView;
    }else if(section==9||section==44){
        LowPackView *lowPackView=(LowPackView *)[self C_init:Identifier5];
        lowPackView.titleTextField.delegate=self;
        lowPackView.titleTextField.tag=100+section;
        [lowPackView _init:[key objectAtIndex:0] Weather:@"必填" InPutView:_selectFormPickerView];
        _selectFormPickerView.Clock=^(NSString *str){
            if (section==9) {
                lowPackView.titleTextField.text=str;
            }else
            lowPackView.titleTextField.text=str;
        };
        if (section==9) {
            if (!officeBanListModel.办公楼栋类型) {
                officeBanListModel.办公楼栋类型=@"商住写字楼";
            }
            lowPackView.titleTextField.text=officeBanListModel.办公楼栋类型;
        }else{
            if (!officeBanListModel.空置率) {
                officeBanListModel.空置率=@"大于50%";
            }
            lowPackView.titleTextField.text=officeBanListModel.空置率;
        }
        return lowPackView;
    }else if (section==6){
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier6];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier6 DataArray:array];
        } houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            [_selectArrays replaceObjectAtIndex:section withObject:[NSNumber numberWithInteger:selectIndex]];
            officeBanListModel.竣工时间准确性=[array objectAtIndex:selectIndex];
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:[[_selectArrays objectAtIndex:section] integerValue]];
            if ([officeBanListModel.竣工时间准确性 isEqualToString:@"估计"]) {
                houseSelectView.dVSwitch.selectedIndex=1;
            }else{
                houseSelectView.dVSwitch.selectedIndex=0;
                officeBanListModel.竣工时间准确性=@"精确";
            }
            
        return houseSelectView;
    }else if (section==15||section==16||section==18||section==19||section==21||section==22){
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier8];
       
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier8 DataArray:array];
             houseSelectView.tag=1000+section;
        } houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            [_selectArrays replaceObjectAtIndex:section withObject:[NSNumber numberWithInteger:selectIndex]];
            
            NSLog(@"%ld",(long)Tag);
            if (Tag==1015) {
                officeBanListModel.外墙装修情况=[array objectAtIndex:selectIndex];
            }else if (Tag==1016){
                officeBanListModel.外墙保养情况=[array objectAtIndex:selectIndex];
            }else if (Tag==1018){
                officeBanListModel.大堂装修情况=[array objectAtIndex:selectIndex];
            }else if (Tag==1019){
                officeBanListModel.大堂保养情况=[array objectAtIndex:selectIndex];
            }else if (Tag==1021){
                officeBanListModel.标准层装修情况=[array objectAtIndex:selectIndex];
            }else if (Tag==1022){
                officeBanListModel.标准层保养情况=[array objectAtIndex:selectIndex];
            }
        };
        houseSelectView.cellLable.text=nil;
        if (section==15) {
            houseSelectView.cellLable.text=@"外墙情况";
        }else if (section==18){
             houseSelectView.cellLable.text=@"大堂";
        }else if (section==21){
            houseSelectView.cellLable.text=@"标注层";
        }
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
        if (section==15) {
        
             if ([officeBanListModel.外墙装修情况 isEqualToString:@"好" ]){
                houseSelectView.dVSwitch.selectedIndex=1;
            }else if ([officeBanListModel.外墙装修情况 isEqualToString:@"一般" ]){
                houseSelectView.dVSwitch.selectedIndex=2;
            }else if ([officeBanListModel.外墙装修情况 isEqualToString:@"差" ]){
                houseSelectView.dVSwitch.selectedIndex=3;
            }else {
                houseSelectView.dVSwitch.selectedIndex=0;
                officeBanListModel.外墙装修情况=@"很好";
            }

        }else if (section==16){
            if ([officeBanListModel.外墙保养情况 isEqualToString:@"好" ]){
                houseSelectView.dVSwitch.selectedIndex=1;
            }else if ([officeBanListModel.外墙保养情况 isEqualToString:@"一般" ]){
                houseSelectView.dVSwitch.selectedIndex=2;
            }else if ([officeBanListModel.外墙装修情况 isEqualToString:@"差" ]){
                houseSelectView.dVSwitch.selectedIndex=3;
            }else  {
                houseSelectView.dVSwitch.selectedIndex=0;
                officeBanListModel.外墙保养情况=@"很好";
            }
        }else if (section==18){
             if ([officeBanListModel.大堂装修情况 isEqualToString:@"好" ]){
                houseSelectView.dVSwitch.selectedIndex=1;
            }else if ([officeBanListModel.大堂装修情况 isEqualToString:@"一般" ]){
                houseSelectView.dVSwitch.selectedIndex=2;
            }else if ([officeBanListModel.外墙装修情况 isEqualToString:@"差" ]){
                houseSelectView.dVSwitch.selectedIndex=3;
            }else  {
                houseSelectView.dVSwitch.selectedIndex=0;
                officeBanListModel.大堂装修情况=@"很好";
            }
        }else if (section==19){
             if ([officeBanListModel.大堂保养情况 isEqualToString:@"好" ]){
                houseSelectView.dVSwitch.selectedIndex=1;
            }else if ([officeBanListModel.大堂保养情况 isEqualToString:@"一般" ]){
                houseSelectView.dVSwitch.selectedIndex=2;
            }else if ([officeBanListModel.外墙装修情况 isEqualToString:@"差" ]){
                houseSelectView.dVSwitch.selectedIndex=3;
            }else  {
                houseSelectView.dVSwitch.selectedIndex=0;
                officeBanListModel.大堂保养情况=@"很好";
            }
        }else if (section==21){
             if ([officeBanListModel.标准层装修情况 isEqualToString:@"好" ]){
                houseSelectView.dVSwitch.selectedIndex=1;
            }else if ([officeBanListModel.标准层装修情况 isEqualToString:@"一般" ]){
                houseSelectView.dVSwitch.selectedIndex=2;
            }else if ([officeBanListModel.外墙装修情况 isEqualToString:@"差" ]){
                houseSelectView.dVSwitch.selectedIndex=3;
            }else  {
                houseSelectView.dVSwitch.selectedIndex=0;
                officeBanListModel.标准层装修情况=@"很好";
            }
        }else if (section==22){
            if ([officeBanListModel.标准层保养情况 isEqualToString:@"好" ]){
                houseSelectView.dVSwitch.selectedIndex=1;
            }else if ([officeBanListModel.标准层保养情况 isEqualToString:@"一般" ]){
                houseSelectView.dVSwitch.selectedIndex=2;
            }else if ([officeBanListModel.外墙装修情况 isEqualToString:@"差" ]){
                houseSelectView.dVSwitch.selectedIndex=3;
            }else  {
                houseSelectView.dVSwitch.selectedIndex=0;
                officeBanListModel.标准层保养情况=@"很好";
            }
        }
                return houseSelectView;
    }else if (section==28){
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier9];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier9 DataArray:array];
        } houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            [_selectArrays replaceObjectAtIndex:section withObject:[NSNumber numberWithInteger:selectIndex]];
            NSLog(@"%ld",Tag);
            officeBanListModel.空调类型=[array objectAtIndex:selectIndex];
        };
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
        if ([officeBanListModel.空调类型 isEqualToString:@"分体空调"]){
            houseSelectView.dVSwitch.selectedIndex=1;
        }else if ([officeBanListModel.空调类型 isEqualToString:@"中央/分体空调混合"]){
            houseSelectView.dVSwitch.selectedIndex=2;
        }else {
            houseSelectView.dVSwitch.selectedIndex=0;
            officeBanListModel.空调类型=@"中央空调";
        }
        
        return houseSelectView;
    }else if (section==39){
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier10];
         NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
           
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier10 DataArray:array];
        } houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            [_selectArrays replaceObjectAtIndex:section withObject:[NSNumber numberWithInteger:selectIndex]];
            NSLog(@"%ld",Tag);
            officeBanListModel.包含中央空调费=[array objectAtIndex:selectIndex];
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
        if ([officeBanListModel.包含中央空调费 isEqualToString:@"是"]) {
            houseSelectView.dVSwitch.selectedIndex=0;
        }else{
            houseSelectView.dVSwitch.selectedIndex=1;
            officeBanListModel.包含中央空调费=@"否";
        }
        return houseSelectView;
    }else if (section==40){
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier11];
         NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
           
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier11 DataArray:array];
        } houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            [_selectArrays replaceObjectAtIndex:section withObject:[NSNumber numberWithInteger:selectIndex]];
            NSLog(@"%ld",Tag);
            officeBanListModel.物业管理评价=[array objectAtIndex:selectIndex];
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
        if ([officeBanListModel.物业管理评价 isEqualToString:@"很好"]){
            houseSelectView.dVSwitch.selectedIndex=1;
        }else if ([officeBanListModel.物业管理评价 isEqualToString:@"一般"]){
            houseSelectView.dVSwitch.selectedIndex=2;
        }else if ([officeBanListModel.物业管理评价 isEqualToString:@"较差"]){
            houseSelectView.dVSwitch.selectedIndex=3;
        }else if ([officeBanListModel.物业管理评价 isEqualToString:@"差"]){
            houseSelectView.dVSwitch.selectedIndex=4;
        } else {
            houseSelectView.dVSwitch.selectedIndex=0;
            officeBanListModel.物业管理评价=@"好";
        }
        return houseSelectView;
    } else if ((section>=11&&section<=13)||(section>=31&&section<=35)||section==42||section==43){
        LowHouseSwitchView *lowSelectDateView=(LowHouseSwitchView *)[self C_init:Identifier12 ];
        lowSelectDateView.tag=section+1000;
        NSString *keyStr=[key objectAtIndex:0];
        [lowSelectDateView _init:[NetworkManager interceptStrTo:keyStr PleStr:@"+"] Title1:[NetworkManager interceptStrFrom:keyStr PleStr:@"+"] TitleSwitch:NO TitleSwitch1:NO];
        lowSelectDateView.Clock=^(NSInteger indexSwitch,BOOL open){
     
            if (open) {
                if (indexSwitch==1012) {
                    officeBanListMainModel.办公=@"办公";
                }else if (indexSwitch==1111){
                    officeBanListMainModel.住宅=@"住宅";
                }else if (indexSwitch==1013){
                    officeBanListMainModel.零售商业=@"零售商业";
                }else if (indexSwitch==1112){
                    officeBanListMainModel.酒店住宿=@"酒店住宿";
                }else if (indexSwitch==1014){
                    officeBanListMainModel.工业=@"工业";
                }else if (indexSwitch==1113){
                    officeBanListMainModel.其它=@"其它";
                    [_lowArray replaceObjectAtIndex:section withObject:@"YES"];
                    [self Refresh:section];
                    
                }else if (indexSwitch==1032){
                    officeBanListInsideModel.银行=@"银行";
                }else if (indexSwitch==1131){
                    officeBanListInsideModel.餐饮=@"餐饮";
                }else if (indexSwitch==1033){
                    officeBanListInsideModel.购物中心=@"购物中心";
                }else if (indexSwitch==1132){
                    officeBanListInsideModel.空中花园=@"空中花园";
                }else if (indexSwitch==1034){
                    officeBanListInsideModel.会议中心=@"会议中心";
                }else if (indexSwitch==1133){
                    officeBanListInsideModel.便利店=@"便利店";
                }else if (indexSwitch==1035){
                    officeBanListInsideModel.酒店宾馆=@"酒店宾馆";
                }else if (indexSwitch==1134){
                    officeBanListInsideModel.商务中心=@"商务中心";
                }else if (indexSwitch==1036){
                    officeBanListInsideModel.健身中心=@"健身中心";
                }else if (indexSwitch==1135){
                    officeBanListInsideModel.其它=@"其它";
                    [_lowArray replaceObjectAtIndex:section withObject:@"YES"];
                    [self Refresh:section];
                }else if (indexSwitch==1043){
                    officePatternListModel.自持自用=@"自持自用";
                }else if (indexSwitch==1142){
                    officePatternListModel.统一出租=@"统一出租";
                }else if (indexSwitch==1044){
                    officePatternListModel.租售混合=@"租售混合";
                }else if (indexSwitch==1143){
                    officePatternListModel.其它=@"其它";
                    [_lowArray replaceObjectAtIndex:section withObject:@"YES"];
                    [self Refresh:section];
                }
            }else{
                if (indexSwitch==1012) {
                    
                    officeBanListMainModel.办公=@"";
                }else if (indexSwitch==1111){
                    officeBanListMainModel.住宅=@"";
                }else if (indexSwitch==1013){
                    officeBanListMainModel.零售商业=@"";
                }else if (indexSwitch==1112){
                    officeBanListMainModel.酒店住宿=@"";
                }else if (indexSwitch==1014){
                    officeBanListMainModel.工业=@"";
                }else if (indexSwitch==1113){
                    officeBanListMainModel.其它=@"";
                    [_lowArray replaceObjectAtIndex:section withObject:@"NO"];
                    [self Refresh:section];
                }else if (indexSwitch==1032){
                    officeBanListInsideModel.银行=@"";
                }else if (indexSwitch==1131){
                    officeBanListInsideModel.餐饮=@"";
                }else if (indexSwitch==1033){
                    officeBanListInsideModel.购物中心=@"";
                }else if (indexSwitch==1132){
                    officeBanListInsideModel.空中花园=@"";
                }else if (indexSwitch==1034){
                    officeBanListInsideModel.会议中心=@"";
                }else if (indexSwitch==1133){
                    officeBanListInsideModel.便利店=@"";
                }else if (indexSwitch==1035){
                    officeBanListInsideModel.酒店宾馆=@"";
                }else if (indexSwitch==1134){
                    officeBanListInsideModel.商务中心=@"";
                }else if (indexSwitch==1036){
                    officeBanListInsideModel.健身中心=@"";
                }else if (indexSwitch==1135){
                    officeBanListInsideModel.其它=@"";
                    [_lowArray replaceObjectAtIndex:section withObject:@"NO"];
                    [self Refresh:section];
                }else if (indexSwitch==1043){
                    officePatternListModel.自持自用=@"";
                }else if (indexSwitch==1142){
                    officePatternListModel.统一出租=@"";
                }else if (indexSwitch==1044){
                    officePatternListModel.租售混合=@"";
                }else if (indexSwitch==1143){
                    officePatternListModel.其它=@"";
                    [_lowArray replaceObjectAtIndex:section withObject:@"NO"];
                    [self Refresh:section];
                }
            }
            
        };
        lowSelectDateView.cellTitleLable.text=nil;
        if (section==11) {
            lowSelectDateView.titleSwitch.on=NO;
            lowSelectDateView.cellTitleLable.text=@"主要用途";
            if ([officeBanListMainModel.办公 isEqualToString:@"办公"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
           lowSelectDateView.titleSwitch1.on=NO;
            if ([officeBanListMainModel.住宅 isEqualToString:@"住宅"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==12){
            lowSelectDateView.titleSwitch.on=NO;
            if ([officeBanListMainModel.零售商业 isEqualToString:@"零售商业"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            lowSelectDateView.titleSwitch1.on=NO;
            if ([officeBanListMainModel.酒店住宿 isEqualToString:@"酒店住宿"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==13){
            lowSelectDateView.titleSwitch.on=NO;
            if ([officeBanListMainModel.工业 isEqualToString:@"工业"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            lowSelectDateView.titleSwitch1.on=NO;

            if ([officeBanListMainModel.其它 isEqualToString:@"其它"]) {
                lowSelectDateView.titleSwitch1.on=YES;

            }
        }else if (section==31){
             lowSelectDateView.cellTitleLable.text=@"内部配套";
            lowSelectDateView.titleSwitch.on=NO;
            if ([officeBanListInsideModel.银行 isEqualToString:@"银行"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            lowSelectDateView.titleSwitch1.on=NO;
            if ([officeBanListInsideModel.餐饮 isEqualToString:@"餐饮"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==32){
            lowSelectDateView.titleSwitch.on=NO;
            if ([officeBanListInsideModel.购物中心 isEqualToString:@"购物中心"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            lowSelectDateView.titleSwitch1.on=NO;
            if ([officeBanListInsideModel.空中花园 isEqualToString:@"空中花园"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==33){
            lowSelectDateView.titleSwitch.on=NO;
            if ([officeBanListInsideModel.会议中心 isEqualToString:@"会议中心"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            lowSelectDateView.titleSwitch1.on=NO;
            if ([officeBanListInsideModel.便利店 isEqualToString:@"便利店"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==34){
            lowSelectDateView.titleSwitch.on=NO;
            if ([officeBanListInsideModel.酒店宾馆 isEqualToString:@"酒店宾馆"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            lowSelectDateView.titleSwitch1.on=NO;
            if ([officeBanListInsideModel.商务中心 isEqualToString:@"商务中心"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==35){
            lowSelectDateView.titleSwitch.on=NO;
            if ([officeBanListInsideModel.健身中心 isEqualToString:@"健身中心"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            lowSelectDateView.titleSwitch1.on=NO;
            if ([officeBanListInsideModel.其它 isEqualToString:@"其它"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==42){
            lowSelectDateView.titleSwitch.on=NO;
             lowSelectDateView.cellTitleLable.text=@"租售模式";
            if ([officePatternListModel.自持自用 isEqualToString:@"自持自用"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            lowSelectDateView.titleSwitch1.on=NO;
            if ([officePatternListModel.统一出租 isEqualToString:@"统一出租"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==43){
            lowSelectDateView.titleSwitch.on=NO;
            if ([officePatternListModel.租售混合 isEqualToString:@"租售混合"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            lowSelectDateView.titleSwitch1.on=NO;
            if ([officePatternListModel.其它 isEqualToString:@"其它"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }
        
                return lowSelectDateView;
    }else{
        NSLog(@"%ld",section);
//        图片
        PhotoView *lowSelectDateView=(PhotoView *)[self C_init:Identifier20 ];
        lowSelectDateView.tag=section+1000;
        NSArray *array=[_dropDownArray objectAtIndex:section];
        [lowSelectDateView _init:[key objectAtIndex:0]PhImage:nil];

        if (section==17&&officeBanListModel.外墙照片) {
            [NetworkManager _initSdImage:[NetworkManager jiequStr:officeBanListModel.外墙照片 rep:@","] ImageView:lowSelectDateView.phImageView];
        }else if (section==20&&officeBanListModel.大堂照片){
            [NetworkManager _initSdImage:[NetworkManager jiequStr:officeBanListModel.大堂照片 rep:@","] ImageView:lowSelectDateView.phImageView];
        }else if (section==23&&officeBanListModel.标准层装修照片){
            [NetworkManager _initSdImage:[NetworkManager jiequStr:officeBanListModel.标准层装修照片 rep:@","] ImageView:lowSelectDateView.phImageView];
        }else if (section==24&&officeBanListModel.标准层平面图){
            [NetworkManager _initSdImage:[NetworkManager jiequStr:officeBanListModel.标准层平面图 rep:@","] ImageView:lowSelectDateView.phImageView];
        }
        lowSelectDateView.Clock=^(NSInteger ClockTag){
            NSLog(@"%ld",ClockTag);

            NSString *str=[NetworkManager Datastrings:[[self.baseArray objectAtIndex:ClockTag-1000] allKeys]];
            NSLog(@"%@",str);
           str= [NetworkManager interceptStrTo:str PleStr:@"("];
             NSLog(@"%@",str);
            POHViewController *pOHViewController=[[POHViewController alloc]initWithNibName:@"POHViewController" bundle:nil];
            if (ClockTag==1017) {
                NSMutableArray *PHarray=[NetworkManager address:officeBanListModel.外墙照片];
                if (PHarray.count==0) {
                    PHarray = [NSMutableArray arrayWithCapacity:1];
                }
                pOHViewController.PHOarray=PHarray;
                pOHViewController.successfulIndex = PHarray.count;
            }else if (ClockTag==1020) {
                NSMutableArray *PHarray=[NetworkManager address:officeBanListModel.大堂照片];
                if (PHarray.count==0) {
                    PHarray = [NSMutableArray arrayWithCapacity:1];
                }
                pOHViewController.PHOarray=PHarray;
                pOHViewController.successfulIndex = PHarray.count;
            }else if (ClockTag==1023) {
                NSMutableArray *PHarray=[NetworkManager address:officeBanListModel.标准层装修照片];
                if (PHarray.count==0) {
                    PHarray = [NSMutableArray arrayWithCapacity:1];
                }
                pOHViewController.PHOarray=PHarray;
                pOHViewController.successfulIndex = PHarray.count;
            }else if (ClockTag==1024) {
                NSMutableArray *PHarray=[NetworkManager address:officeBanListModel.标准层平面图];
                if (PHarray.count==0) {
                    PHarray = [NSMutableArray arrayWithCapacity:1];
                }
                pOHViewController.PHOarray=PHarray;
                pOHViewController.successfulIndex = PHarray.count;
            }

            [self.navigationController pushViewController:pOHViewController animated:YES];
            pOHViewController.ClockSave=^(NSArray *ArrayID,NSString *ImageUrl){
                if (ClockTag==1017) {
                    officeBanListModel.外墙照片=ImageUrl;
                    [IDs addObject:ArrayID];
                }else if (ClockTag==1020) {
                    officeBanListModel.大堂照片=ImageUrl;
                    [IDs addObject:ArrayID];
                }else if (ClockTag==1023) {
                    officeBanListModel.标准层装修照片=ImageUrl;
                    [IDs addObject:ArrayID];
                }else if (ClockTag==1024) {
                    officeBanListModel.标准层平面图=ImageUrl;
                    [IDs addObject:ArrayID];
                }
                [tableView reloadData];
            };
            pOHViewController.stakID=self.estateID;
            pOHViewController.ID=officeBanListModel.ID;
            pOHViewController.type=self.selectSee;
            pOHViewController.imageType=str;
            pOHViewController.orderType=@"officeBuding";
            pOHViewController.selectMax=10;
        };
        return lowSelectDateView;
    }
}

-(UITableViewHeaderFooterView *)C_init:(NSString *)mark{
    return [self.baseTableView dequeueReusableHeaderFooterViewWithIdentifier:mark];
    //    return [[[NSBundle mainBundle]loadNibNamed:xibName owner:self options:nil]lastObject];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_noInvestigation==5) {
        if (section==4) {
            return 44;
        }
    }else if (_noInvestigation==18){
        if (section==17) {
            return 44;
        }
    } else{
        if (section==47) {
            return 44;
        }
    }
   
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_noInvestigation==5) {
        if (section==4) {
            LowFootView *lowFootView=(LowFootView *)[self C_init:Identifier7];
            lowFootView.SaveClock=^(){
                [self required];
            };
            return lowFootView;
        }
    }else if (_noInvestigation==18){
        if (section==17) {
            LowFootView *lowFootView=(LowFootView *)[self C_init:Identifier7];
            lowFootView.SaveClock=^(){
                [self required];
            };
            return lowFootView;
        }
        
        
    } else {
        if (section==47) {
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
    NSLog(@"%ld",(long)section);
    
    if (section==43) {
        [self.baseTableView reloadData];
    }else{
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
        [self.baseTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
//    [self.baseTableView reloadData];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%d",buttonIndex);
    if (buttonIndex==0) {
        _noInvestigation=5;
        [_lowArray replaceObjectAtIndex:4 withObject:@"YES"];
    }else if (buttonIndex==1){
        _noInvestigation=18;
        [_lowArray replaceObjectAtIndex:4 withObject:@"YES"];
    }else{
        _noInvestigation=47;
        [_lowArray replaceObjectAtIndex:4 withObject:@"NO"];
        LowInvestigationView *lowInvestigationView=[self.view viewWithTag:1000000];
        lowInvestigationView.titleSwitch.on=NO;
    }
    [self.baseTableView reloadData];
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

- (void)textFieldDidEndEditing:(UITextField *)textField{

    NSLog(@"%ld------",textField.tag);
    if (textField.tag==1003) {
        officeBanListModel.实际楼栋名称=textField.text;
    }else if (textField.tag==1005){
        officeBanListModel.竣工时间=textField.text;
    }else if (textField.tag==1007){
        officeBanListModel.地上楼层=textField.text;
    }else if (textField.tag==1008){
        officeBanListModel.地下楼层=textField.text;
    }else if (textField.tag==109){
        officeBanListModel.办公楼栋类型=textField.text;
        [_lowArray replaceObjectAtIndex:9 withObject:@"NO"];
        if ([officeBanListModel.办公楼栋类型 isEqualToString:@"其他"]) {
            [_lowArray replaceObjectAtIndex:9 withObject:@"YES"];
            
        }
        [self Refresh:9];
    }else if (textField.tag==10009){
        officeBanListModel.楼栋类型其它=textField.text;
    }else if (textField.tag== 1014){
        officeBanListModel.主要用途备注=textField.text;
    }else if (textField.tag== 1025){
        officeBanListModel.装修情况备注=textField.text;
    }else if (textField.tag== 1026){
        officeBanListModel.客梯数量=textField.text;
    }else if (textField.tag==1027){
        officeBanListModel.货梯数量=textField.text;
    }else if (textField.tag==1029){
        officeBanListModel.地上停车位=textField.text;
    }else if (textField.tag==1030){
        officeBanListModel.地下停车位=textField.text;
    }else if (textField.tag==1036){
        officeBanListModel.配套设施备注=textField.text;
    }else if (textField.tag==1037){
        officeBanListModel.物业管理公司=textField.text;
    }else if (textField.tag==1038){
        officeBanListModel.物业管理费=textField.text;
    }else if (textField.tag==1041){
        officeBanListModel.物业管理备注=textField.text;
    }else if (textField.tag==144){
        officeBanListModel.空置率=textField.text;
    }else if (textField.tag==1045){
        officeBanListModel.售价=textField.text;
    }else if (textField.tag==1046){
        officeBanListModel.租金=textField.text;
    }else if (textField.tag==10004){
        officeBanListModel.无法调查说明=textField.text;
    }else if (textField.tag==10013){
        officeBanListModel.主要用途其它=textField.text;
    }else if (textField.tag==10035){
        officeBanListModel.内部配套其它=textField.text;
    }else if (textField.tag==10043){
        officeBanListModel.租售模式其它=textField.text;
    }
    fistTextField = nil;
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"%d",textField.tag);
    if (textField.tag==109||textField.tag==144) {
        _selectFormPickerView.trafficArray=[self.dropDownArray objectAtIndex:textField.tag-100];
    }
    
    return YES;
}

-(void)netSaveFormData{
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"保存中..."];
    typeof(self)SelfWeek=self;

    NSMutableDictionary *dictSave=[[NSMutableDictionary alloc]initWithDictionary:officeBanListModel.toDictionary];
    if (self.estateID) {
        [dictSave setObject:self.estateID forKey:@"taskId"];
    }
    [dictSave setObject:@"officeBuding" forKey:@"makeType"];
    
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
                [BaseView _init:saveModel.message View:SelfWeek.view];
                officeBanListModel.ID = saveModel.ID;
                if (![self.selectSee isEqualToString:@"编辑"]) {
                    [SelfWeek postValues:@{@"ID":[super replaceString:officeBanListModel.楼栋编号],@"NAME":officeBanListModel.实际楼栋名称,@"楼盘名称":officeBanListModel.楼盘名称}];
                    
                    UIScrollView *scrollView=(UIScrollView *)self.view.superview;
                    [scrollView setContentOffset:CGPointMake(2*self.view.frame.size.width, 0) animated:YES];
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
    NSNotification *notification =[NSNotification notificationWithName:@"officeloudong" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}


//判断必填项
-(void)required{
    officeBanListModel.主要用途=[NetworkManager Datastrings:[officeBanListMainModel.toDictionary allValues]];
    officeBanListModel.内部配套=[NetworkManager Datastrings:[officeBanListInsideModel.toDictionary allValues]];
    officeBanListModel.租售模式=[NetworkManager Datastrings:[officePatternListModel.toDictionary allValues]];
    
    if (!(officeBanListModel.楼盘ID.length>0)) {
        [BaseView _init:@"请选择楼盘" View:self.view];
    }else if (!(officeBanListModel.实际楼栋名称.length>0)){
        [BaseView _init:@"请输入实际楼栋名称" View:self.view];
    }else if (!(officeBanListModel.竣工时间.length>0)){
        [BaseView _init:@"请选择竣工时间" View:self.view];
    }else if (!(officeBanListModel.竣工时间准确性.length>0)){
        [BaseView _init:@"请选择竣工时间准确性" View:self.view];
    }else if (_noInvestigation==5&&!(officeBanListModel.无法调查说明.length>0)){
        [BaseView _init:@"请输入无法调查说明" View:self.view];
    }else if(_noInvestigation==5){
            [self netSaveFormData];
    }else if (_noInvestigation==18){
          if (!(officeBanListModel.地上楼层.length>0)){
              [BaseView _init:@"请输入地上楼层" View:self.view];
          }else if (!(officeBanListModel.地上楼层.length>0)){
              [BaseView _init:@"请输入地上楼层" View:self.view];
          }else if (!(officeBanListModel.办公楼栋类型.length>0)){
              [BaseView _init:@"请选择办公楼栋类型" View:self.view];
          }else if (!(officeBanListModel.主要用途.length>0)){
              [BaseView _init:@"请选择主要用途" View:self.view];
          }else if (!(officeBanListModel.外墙装修情况.length>0)){
              [BaseView _init:@"请选择外墙装修情况" View:self.view];
          }else if (!(officeBanListModel.外墙保养情况.length>0)){
              [BaseView _init:@"请选择外墙保养情况" View:self.view];
          }else if (!officeBanListModel.外墙照片){
              [BaseView _init:@"请选择外墙照片" View:self.view];
          }else if ([NetworkManager address:officeBanListModel.外墙照片].count<3 ){
              [BaseView _init:@"外墙照片3-10张" View:self.view];
          }else if (!(officeBanListModel.无法调查说明.length>0)){
              [BaseView _init:@"请输入无法调查说明" View:self.view];
          }else{
              [self netSaveFormData];
          }
    }else{
        if (!(officeBanListModel.地上楼层.length>0)){
            [BaseView _init:@"请输入地上楼层" View:self.view];
        }else if (!(officeBanListModel.地上楼层.length>0)){
            [BaseView _init:@"请输入地上楼层" View:self.view];
        }else if (!(officeBanListModel.办公楼栋类型.length>0)){
            [BaseView _init:@"请选择办公楼栋类型" View:self.view];
        }else if (!(officeBanListModel.主要用途.length>0)){
            [BaseView _init:@"请选择主要用途" View:self.view];
        }else if ([officeBanListModel.主要用途 containsString:@"其它"]&&!(officeBanListModel.主要用途其它.length>0)){
            [BaseView _init:@"请输入主要用途其他" View:self.view];
        }else if (!(officeBanListModel.外墙装修情况.length>0)){
            [BaseView _init:@"请选择外墙装修情况" View:self.view];
        }else if (!(officeBanListModel.外墙保养情况.length>0)){
            [BaseView _init:@"请选择外墙保养情况" View:self.view];
        }else if (!officeBanListModel.外墙照片){
            [BaseView _init:@"请选择外墙照片" View:self.view];
        }else if ([NetworkManager address:officeBanListModel.外墙照片].count<3||[NetworkManager address:officeBanListModel.外墙照片].count>11 ){
            [BaseView _init:@"外墙照片3-10张" View:self.view];
        }else if (!(officeBanListModel.大堂照片.length>0)){
            [BaseView _init:@"请选择大堂照片" View:self.view];
        }else if ([NetworkManager address:officeBanListModel.大堂照片].count<3||[NetworkManager address:officeBanListModel.大堂照片].count>11 ){
            [BaseView _init:@"大堂照片3-10张" View:self.view];
        }else if (!officeBanListModel.标准层装修照片){
            [BaseView _init:@"请选择标准层装修照片" View:self.view];
        }else if ([NetworkManager address:officeBanListModel.标准层装修照片].count<3||[NetworkManager address:officeBanListModel.标准层装修照片].count>11 ){
            [BaseView _init:@"标准层装修照片3-10张" View:self.view];
        }else if (!officeBanListModel.标准层平面图){
            [BaseView _init:@"请选择标准层平面图" View:self.view];
        }else if ([NetworkManager address:officeBanListModel.标准层平面图].count<1||[NetworkManager address:officeBanListModel.标准层平面图].count>11){
            [BaseView _init:@"标准层平面图1-10张" View:self.view];
        } else if (!(officeBanListModel.客梯数量.length>0)){
            [BaseView _init:@"请输入客梯数量" View:self.view];
        }else if (!(officeBanListModel.货梯数量.length>0)){
            [BaseView _init:@"请输入货梯数量" View:self.view];
        }else if (!(officeBanListModel.地上停车位.length>0)){
            [BaseView _init:@"请输入地上停车位" View:self.view];
        }else if (!(officeBanListModel.地下停车位.length>0)){
            [BaseView _init:@"请输入地下停车位" View:self.view];
        }else if ([officeBanListModel.内部配套 containsString:@"其它"]&&!(officeBanListModel.内部配套其它.length>0)){
            [BaseView _init:@"请输入内部配套其它" View:self.view];
        }else if (!(officeBanListModel.物业管理公司.length>0)){
            [BaseView _init:@"请输入物业管理公司" View:self.view];
        }else if (!(officeBanListModel.物业管理费.length>0)){
            [BaseView _init:@"请输入物业管理费" View:self.view];
        }else if (!(officeBanListModel.租售模式.length>0)){
            [BaseView _init:@"请选择租售模式" View:self.view];
        }else if ([officeBanListModel.租售模式 containsString:@"其它"]&&!(officeBanListModel.租售模式其它.length>0)){
            [BaseView _init:@"请输入租售模式其它" View:self.view];
        }else if (!(officeBanListModel.空置率.length>0)){
            [BaseView _init:@"请输入空置率" View:self.view];
        }else if (!(officeBanListModel.租金.length>0)){
            [BaseView _init:@"请输入租金平均租金" View:self.view];
        }else if ([officeBanListModel.办公楼栋类型 containsString:@"其他"]&&!(officeBanListModel.楼栋类型其它.length>0)){
            [BaseView _init:@"请输入楼栋类型其它" View:self.view];
        }else{
            [self netSaveFormData];
        }

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
