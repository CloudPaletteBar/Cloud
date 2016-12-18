//
//  LowEstateViewController.m
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "LowEstateViewController.h"
#import "NetworkManager.h"
#import "LowEstateCell.h"
#import "FormInPutView.h"
#import "LowSelectDateView.h"
#import "LowPropertyNameView.h"
#import "OfficeEstateAddressView.h"
#import "LowPackView.h"
#import "HouseSelectView.h"
#import "CloudPaletteBar.h"
#import "LowFootView.h"
#import "PhotoView.h"
#import "PhotoPickerViewController.h"
#import "CalendarView.h"
#import "SelectFormPickerView.h"
#import "LowEstateModel.h"
#import "SystemModel.h"
#import "FormSelectTableView.h"
#import "MJRefresh.h"
#import "LowHouseSwitchView.h"
#import "SaveModel.h"
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
static NSString *Identifier21=@"Identifier21";
static NSString *Identifier22=@"Identifier22";

@interface LowEstateViewController ()<UITextFieldDelegate,UISearchBarDelegate>{
    UITextField *fistTextField;
    LowEstateListModel *lowEstateListModel;
//    楼盘效果图
    LowEstateStandardPhModel *lowEstateStandardPhModel1;
    //    楼盘平面图
    LowEstateStandardPhModel *lowEstateStandardPhModel2;
    //    配套设施图
    LowEstateStandardPhModel *lowEstateStandardPhModel3;
    //    内外部景观图
    LowEstateStandardPhModel *lowEstateStandardPhModel4;
//    运动设施
    LowEstateMovementModel *lowEstateMovementModel;
//    景观设施
    LowEstateLandscapeModel *lowEstateLandscapeModel;
//    商业配套
    LowEstateBusinessModel *lowEstateBusinessModel;
    NSInteger Indext;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    FormSelectTableView *formSelectTableView;
    NSMutableArray *addressArray1;
    NSMutableArray *addressArray2;
    NSMutableArray  *IDs;
    NSString *secarchName;
    UIView *formSelectView;
}
@property(nonatomic,strong)SelectFormPickerView *citypick;
@property(nonatomic,strong)SelectFormPickerView *selectFormPickerView;
@property(nonatomic,strong)CalendarView *calendarView;
@property(nonatomic,strong)NSMutableArray *lowArray;
@property(nonatomic,strong)NSMutableArray *dropDownArray;
@property (nonatomic ,strong)UISearchBar *searchBar;
@end

@implementation LowEstateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _citypick=[[[NSBundle mainBundle]loadNibNamed:@"SelectFormPickerView" owner:self options:nil]lastObject];
    [_citypick _init:nil];
    NSLog(@"%@",self.estateID);
    IDs=[[NSMutableArray alloc]init];
    self.baseTableView.frame=CGRectMake(0, 0, screen_width, screen_height-50-64);
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerHeat];
    self.lowArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OpenOrClose"]];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"LowEstateCell" bundle:nil] forCellReuseIdentifier:Identifier];
//    LowEstate
    self.baseArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"LowEstate"]];
    self.dropDownArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"MaterialScience"]];
    _calendarView=[[[NSBundle mainBundle]loadNibNamed:@"CalendarView" owner:self options:nil]lastObject];
    [self.calendarView reloadWithDate: 3];
    _selectFormPickerView=[[[NSBundle mainBundle]loadNibNamed:@"SelectFormPickerView" owner:self options:nil]lastObject];
    [_selectFormPickerView _init:nil];
    
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

    [self registerForKeyboardNotifications];
//    [self netSysData:1];
    [self netFormData];
}

-(void)registerHeat{
    [self registerHeat:@"FormInPutView" Mark:Identifier1];
    [self registerHeat:@"LowSelectDateView" Mark:Identifier2];
    [self registerHeat:@"LowPropertyNameView" Mark:Identifier3];
    [self registerHeat:@"OfficeEstateAddressView" Mark:Identifier4];
    [self registerHeat:@"LowPackView" Mark:Identifier5];
    [self registerHeat:@"LowFootView" Mark:Identifier7];
    [self registerHeat:@"PhotoView" Mark:Identifier20];
    [self registerHeat:@"LowHouseSwitchView" Mark:Identifier21];
//    [self registerHeat:@"HouseSelectView" Mark:Identifier6];
//    [self.baseTableView registerClass:[HouseSelectView class] forHeaderFooterViewReuseIdentifier:Identifier6];
}


//获取系统楼盘编号和系统楼盘名称
-(void)netSysData:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"houseXiaoqu",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":name}];
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
                    formSelectTableView.formSelectArray=Arrayvalues;
                    formSelectTableView.formSelectArray=Arraykeys;
                //                        formSelectTableView.formSelectArray=keys;
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

-(void)Init_O{
    lowEstateListModel=[[LowEstateListModel alloc]init];
                lowEstateMovementModel=[[LowEstateMovementModel alloc]init];
                lowEstateBusinessModel=[[LowEstateBusinessModel alloc]init];
                lowEstateLandscapeModel=[[LowEstateLandscapeModel alloc]init];
                lowEstateStandardPhModel1=[[LowEstateStandardPhModel alloc]init];
                lowEstateStandardPhModel2=[[LowEstateStandardPhModel alloc]init];
                lowEstateStandardPhModel3=[[LowEstateStandardPhModel alloc]init];
                lowEstateStandardPhModel4=[[LowEstateStandardPhModel alloc]init];
                addressArray1=[[NSMutableArray alloc]init];
                addressArray2=[[NSMutableArray alloc]init];
}

//获取表单数据
-(void)netFormData{
    NSLog(@"%@",self.selectSee);
   
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"houseXiaoqu"}];
    NSLog(@"%@",self.estateID);
    if (self.estateID) {
        if ([kUserDefaults objectForKey:@"lowDensityId" ]!=NULL) {
            [dic setObject:self.estateID forKey:@"taskId"];
//            if (self.selectIndex==0) {
                [dic setObject:[super replaceString:[kUserDefaults objectForKey:@"lowDensityId" ]] forKey:@"ID"];
//            }else{
//                [dic setObject:@"0" forKey:@"ID"];
//            }
            [self Init_O];
            [self netWork:dic];
        }else{
            [self Init_O];
        }
        

    }else{
        if ([kUserDefaults objectForKey:@"lowDensityId" ]!=NULL) {
//            if (self.selectIndex==0) {
                [dic setObject:[super replaceString:[kUserDefaults objectForKey:@"lowDensityId" ]] forKey:@"ID"];
//            }else{
//                [dic setObject:@"0" forKey:@"ID"];
//            }
            [self Init_O];
            [self netWork:dic];
        }else{
            [self Init_O];
        }
    }
}
-(void)netWork:(NSDictionary *)dic{
     typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressOneHUD:self.view Title:@"获取中..."];
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        LowEstateModel *lowEstateModel= [[LowEstateModel alloc]initWithDictionary:responseObject error:nil];
        if (lowEstateModel) {
            if ([lowEstateModel.status isEqualToString:@"1"]) {
                if (lowEstateModel.list.count>0) {
                    lowEstateListModel=[lowEstateModel.list objectAtIndex:0];
                    lowEstateMovementModel=[[LowEstateMovementModel alloc]initWithDictionary:[NetworkManager stringDictionary:lowEstateListModel.运动设施] error:nil];
                    lowEstateBusinessModel=[[LowEstateBusinessModel alloc]initWithDictionary:[NetworkManager stringDictionary:lowEstateListModel.商业配套] error:nil];
                    NSString *str=[NetworkManager repl:@"、" Str:lowEstateListModel.景观设施];
                    NSLog(@"%@",str);
                    NSString *str1=[NetworkManager repl:@"，" Str:str];
                    NSLog(@"%@",str1);
                    lowEstateLandscapeModel=[[LowEstateLandscapeModel alloc]initWithDictionary:[NetworkManager stringDictionary:str1] error:nil];
                    lowEstateStandardPhModel1=[[LowEstateStandardPhModel alloc]initWithDictionary:[NetworkManager stringDictionaryImge:lowEstateListModel.楼盘效果图] error:nil];
                    lowEstateStandardPhModel2=[[LowEstateStandardPhModel alloc]initWithDictionary:[NetworkManager stringDictionaryImge:lowEstateListModel.楼盘平面图] error:nil];
                    lowEstateStandardPhModel3=[[LowEstateStandardPhModel alloc]initWithDictionary:[NetworkManager stringDictionaryImge:lowEstateListModel.配套设施图] error:nil];
                    lowEstateStandardPhModel4=[[LowEstateStandardPhModel alloc]initWithDictionary:[NetworkManager stringDictionaryImge:lowEstateListModel.内外部景观图] error:nil];
                    //                            把字符串转成数组
                    addressArray1=[[NSMutableArray alloc]initWithArray:[NetworkManager address:lowEstateListModel.详细地址1]];
                    //                    把字符串转成数组
                    addressArray2=[[NSMutableArray alloc]initWithArray:[NetworkManager address:lowEstateListModel.详细地址2]];
                    [self re];
                    [SelfWeek repleStr:lowEstateListModel];
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
    
    if([self panduan:lowEstateListModel.海滨别墅 Baohan:@"是"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:38 withObject:@"YES"];
    }
    if ([self panduan: lowEstateListModel.河流湖泊别墅 Baohan:@"是"]) {
        [_lowArray replaceObjectAtIndex:39 withObject:@"YES"];
    }if ([self panduan: lowEstateListModel.山景别墅 Baohan:@"是"]) {
        [_lowArray replaceObjectAtIndex:40 withObject:@"YES"];
    }if ([self panduan: lowEstateListModel.城市核心区别墅 Baohan:@"是"]) {
        [_lowArray replaceObjectAtIndex:41 withObject:@"YES"];
    }if ([self panduan: lowEstateListModel.公园别墅 Baohan:@"是"]) {
        [_lowArray replaceObjectAtIndex:42 withObject:@"YES"];
    }if ([self panduan: lowEstateListModel.高尔夫别墅 Baohan:@"是"]) {
        [_lowArray replaceObjectAtIndex:43 withObject:@"YES"];
    }if ([self panduan: lowEstateListModel.园林别墅 Baohan:@"是"]) {
        [_lowArray replaceObjectAtIndex:44 withObject:@"YES"];
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
    cell.cellTextField.delegate=self;
    cell.cellTextField.tag=10000+indexPath.row+indexPath.section;
    [cell _cellInit:[value objectAtIndex:indexPath.row] Weather:@"选填"];
    cell.cellTextField.text=@"";

    if (indexPath.section==38&&lowEstateListModel.海滨名称) {
        cell.cellTextField.text=lowEstateListModel.海滨名称;
    }else if(indexPath.section==39&&lowEstateListModel.河流湖泊名称) {
        cell.cellTextField.text=lowEstateListModel.河流湖泊名称;
    }else if(indexPath.section==40&&lowEstateListModel.山景名称) {
        cell.cellTextField.text=lowEstateListModel.山景名称;
    }else if(indexPath.section==41&&lowEstateListModel.城市核心区名称) {
        cell.cellTextField.text=lowEstateListModel.城市核心区名称;
    }else if(indexPath.section==42&&lowEstateListModel.公园名称) {
        cell.cellTextField.text=lowEstateListModel.公园名称;
    }else if(indexPath.section==43&&lowEstateListModel.高尔夫名称) {
        cell.cellTextField.text=lowEstateListModel.高尔夫名称;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==4) {
        return 0;
    }else if (section==19||section==29||section==23||section==34||section==38){
        return 65;
    }
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    __weak typeof(self)selfWeek=self;
    NSDictionary *dic=[self.baseArray objectAtIndex:section];
    NSArray *key=[dic allKeys];
    if (section==3||section==13||section==16||section==26) {
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier1 ];
        formInPutView.formTextField.keyboardType=UIKeyboardTypeDefault;
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"必填"];
        formInPutView.formTextField.text=@"";
        if (section==3&&lowEstateListModel.实际楼盘名称){
            formInPutView.formTextField.text=lowEstateListModel.实际楼盘名称;
        }else if (section==13&&lowEstateListModel.物管公司){
            formInPutView.formTextField.text=lowEstateListModel.物管公司;
        }else if (section==16) {
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (lowEstateListModel.容积率) {
                formInPutView.formTextField.text=lowEstateListModel.容积率;
            }
            
        }else if (section==26) {
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (lowEstateListModel.公共车位) {
                formInPutView.formTextField.text=lowEstateListModel.公共车位;
            }
            
        }
        return formInPutView;
    }else if (section==1||section==6){
        LowSelectDateView *lowSelectDateView=(LowSelectDateView *)[self C_init:Identifier2 ];
        lowSelectDateView.titleTextField.tag=section+1000;
        lowSelectDateView.titleTextField.delegate=self;
        [lowSelectDateView _init:[key objectAtIndex:0]InPutView:_calendarView];
        _calendarView.ClockDate=^(NSString * dateStr){
            lowSelectDateView.titleTextField=[selfWeek.view viewWithTag:Indext];
            lowSelectDateView.titleTextField.text=[NetworkManager str:dateStr];
            
        };
        if (section==1) {
            if (!lowEstateListModel.调查时间) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"yyyy.MM.dd"];
                lowEstateListModel.调查时间=[formatter stringFromDate:[NSDate date]];
            }
            lowSelectDateView.titleTextField.text=lowEstateListModel.调查时间;
        }else if(section==6){
//            if (!lowEstateListModel.竣工年代) {
//                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//                [formatter setDateFormat:@"yyyy.MM.dd"];
//                lowEstateListModel.竣工年代=[formatter stringFromDate:[NSDate date]];
//            }
            lowSelectDateView.titleTextField.text=lowEstateListModel.竣工年代;
        }

        return lowSelectDateView;
    
    }else if (section==2||section==4){
        LowPropertyNameView *lowPropertyNameView=(LowPropertyNameView *)[self C_init:Identifier3 ];
        lowPropertyNameView.tag=1000+section;
        lowPropertyNameView.ClockLow=^(NSInteger Tag){
            if (Tag) {
        
                formSelectTableView.formSelectArray=nil;
                [formSelectTableView.mj_header beginRefreshing];
//                if (Tag==1004) {
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
            
            lowEstateListModel.系统楼盘名称=[NetworkManager interceptStrTo:selectStr PleStr:@" "];
            lowEstateListModel.系统楼盘编号=[Arrayvalues objectAtIndex:Index];
           
            [self.baseTableView reloadData];
        };
        [lowPropertyNameView _init:[key objectAtIndex:0] Weather:@"自动设置"];
        if (section==2) {
            lowPropertyNameView.selectButton.hidden=NO;
        }else{
            lowPropertyNameView.selectButton.hidden=YES;
        }
        if (section==2&&lowEstateListModel.系统楼盘名称){
            lowPropertyNameView.titleTextField.text=lowEstateListModel.系统楼盘名称;
        }else if (section==4&&lowEstateListModel.系统楼盘编号){
            lowPropertyNameView.titleTextField.text=lowEstateListModel.系统楼盘编号;
        }

        return lowPropertyNameView;
    }else if(section==7||section==8)
    {
        OfficeEstateAddressView *officeEstateAddressView=[tableView dequeueReusableHeaderFooterViewWithIdentifier:Identifier4];//(OfficeEstateAddressView *)[self C_init:@"OfficeEstateAddressView"];
        officeEstateAddressView.addressTextField.tag=section+1000;
        officeEstateAddressView.addressTextField.delegate=self;
        officeEstateAddressView.areaTextField.tag=section+100;
        officeEstateAddressView.areaTextField.delegate=self;
        officeEstateAddressView.roundTextField.tag=section+10;
        officeEstateAddressView.roundTextField.delegate=self;
        officeEstateAddressView.addressTextField.text=@"";
        officeEstateAddressView.areaTextField.text=@"";
        officeEstateAddressView.roundTextField.text=@"";
        officeEstateAddressView.roundTextField.keyboardType=UIKeyboardTypeDefault;
        if (section==7) {
            officeEstateAddressView.addressTextField.inputView=_citypick;
            officeEstateAddressView.roundTextField.keyboardType=UIKeyboardTypeNumberPad;
            [officeEstateAddressView _init:[key objectAtIndex:0] WeatherMarkAddress:@"选填" AreaTitle:@"区" WeatherMarkArea:@"选填" RoundTitle:@"街道(路)" WeatherMarkRound:@"选填" EndTiele:@"号"];
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
                if (addressArray2.count>2){
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
    }else if (section==10||section==11){
        LowPackView *lowPackView=(LowPackView *)[self C_init:Identifier5];
        lowPackView.titleTextField.delegate=self;
        lowPackView.titleTextField.tag=1000+section;
        [lowPackView _init:[key objectAtIndex:0] Weather:@"必填" InPutView:_selectFormPickerView];
        _selectFormPickerView.Clock=^(NSString *str){
            lowPackView.titleTextField=[selfWeek.view viewWithTag:Indext];
            lowPackView.titleTextField.text=str;
        };
        if (section==10) {
            if (!lowEstateListModel.楼盘类型) {
                lowEstateListModel.楼盘类型=@"纯别墅";
            }
            lowPackView.titleTextField.text=lowEstateListModel.楼盘类型;
        }else if (section==11){
            if (!lowEstateListModel.建筑风格) {
                lowEstateListModel.建筑风格=@"欧式别墅";
            }
            lowPackView.titleTextField.text=lowEstateListModel.建筑风格;
        }
        return lowPackView;
    }else if ((section>=19&&section<=25)||(section>=29&&section<=32)){
        LowHouseSwitchView *lowSelectDateView=(LowHouseSwitchView *)[self C_init:Identifier21 ];
        lowSelectDateView.tag=section+1000;
        NSString *keyStr=[key objectAtIndex:0];
        [lowSelectDateView _init:[NetworkManager interceptStrTo:keyStr PleStr:@"+"] Title1:[NetworkManager interceptStrFrom:keyStr PleStr:@"+"] TitleSwitch:NO TitleSwitch1:NO];
        lowSelectDateView.Clock=^(NSInteger indexSwitch,BOOL open){
            NSLog(@"%d",indexSwitch);
            if (open) {
                if (indexSwitch==1020) {
                    lowEstateLandscapeModel.带大面积中心花园=@"带大面积中心花园";
                }else if (indexSwitch==1119){
                    lowEstateLandscapeModel.带大面积中心广场=@"带大面积中心广场";
                }else if (indexSwitch==1021){
                    lowEstateLandscapeModel.带大面积中心湖泊=@"带大面积中心湖泊";
                }else if (indexSwitch==1120){
                    lowEstateLandscapeModel.大面积其他水体如溪流瀑布=@"大面积其他水体,如流溪、瀑布";
                }else if (indexSwitch==1022){
                    lowEstateLandscapeModel.成规模种树=@"成规模种树";
                }else if (indexSwitch==1121){
                    lowEstateLandscapeModel.大面积草坪=@"大面积草坪";
                }else if (indexSwitch==1023){
                    lowEstateLandscapeModel.大面积园=@"大面积园";
                }else if (indexSwitch==1024){
                    lowEstateBusinessModel.大型商场=@"大型商场";
                }else if (indexSwitch==1123){
                    lowEstateBusinessModel.知名超市=@"知名超市";
                }else if (indexSwitch==1025){
                    lowEstateBusinessModel.商业街=@"商业街";
                }else if (indexSwitch==1124){
                    lowEstateBusinessModel.高级会所=@"高级会所";
                }else if (indexSwitch==1026){
                    lowEstateBusinessModel.很少商业配套=@"很少商业配套";
                }else if (indexSwitch==1030){
                    lowEstateMovementModel.网球场=@"网球场";
                }else if (indexSwitch==1129){
                    lowEstateMovementModel.高尔夫球场=@"高尔夫球场";
                }else if (indexSwitch==1031){
                    lowEstateMovementModel.篮球场=@"篮球场";
                }else if (indexSwitch==1130){
                    lowEstateMovementModel.室内泳池=@"室内泳池";
                }else if (indexSwitch==1032){
                    lowEstateMovementModel.室外泳池=@"室外泳池";
                }else if (indexSwitch==1131){
                    lowEstateMovementModel.健身会所=@"健身会所";
                }else if (indexSwitch==1033){
                    lowEstateMovementModel.登山私=@"登山私";
                }
            }else{
                if (indexSwitch==1020) {
                    
                    lowEstateLandscapeModel.带大面积中心花园=@"";
                }else if (indexSwitch==1119){
                    lowEstateLandscapeModel.带大面积中心广场=@"";
                }else if (indexSwitch==1021){
                    lowEstateLandscapeModel.带大面积中心湖泊=@"";
                }else if (indexSwitch==1120){
                    lowEstateLandscapeModel.大面积其他水体如溪流瀑布=@"";
                }else if (indexSwitch==1022){
                    lowEstateLandscapeModel.成规模种树=@"";
                }else if (indexSwitch==1121){
                    lowEstateLandscapeModel.大面积草坪=@"";
                }else if (indexSwitch==1023){
                    lowEstateLandscapeModel.大面积园=@"";
                }else if (indexSwitch==1024){
                    lowEstateBusinessModel.大型商场=@"";
                }else if (indexSwitch==1123){
                    lowEstateBusinessModel.知名超市=@"";
                }else if (indexSwitch==1025){
                    lowEstateBusinessModel.商业街=@"";
                }else if (indexSwitch==1124){
                    lowEstateBusinessModel.高级会所=@"";
                }else if (indexSwitch==1026){
                    lowEstateBusinessModel.很少商业配套=@"";
                }else if (indexSwitch==1030){
                    lowEstateMovementModel.网球场=@"";
                }else if (indexSwitch==1129){
                    lowEstateMovementModel.高尔夫球场=@"";
                }else if (indexSwitch==1031){
                    lowEstateMovementModel.篮球场=@"";
                }else if (indexSwitch==1130){
                    lowEstateMovementModel.室内泳池=@"";
                }else if (indexSwitch==1032){
                    lowEstateMovementModel.室外泳池=@"";
                }else if (indexSwitch==1131){
                    lowEstateMovementModel.健身会所=@"";
                }else if (indexSwitch==1033){
                    lowEstateMovementModel.登山私=@"";
                }
            }
        };
        lowSelectDateView.titleSwitch.on=NO;
        lowSelectDateView.titleSwitch1.on=NO;
        lowSelectDateView.cellTitleLable.text=nil;
        if (section==19){
            lowSelectDateView.cellTitleLable.text=@"景观设施";
            if ([lowEstateLandscapeModel.带大面积中心花园 isEqualToString:@"带大面积中心花园"]) {
                lowSelectDateView.titleSwitch.on=YES;
            } if ([lowEstateLandscapeModel.带大面积中心广场 isEqualToString:@"带大面积中心广场"]){
                lowSelectDateView.titleSwitch1.on=YES;
            }
            
        }else if (section==20){
            if ([lowEstateLandscapeModel.带大面积中心湖泊 isEqualToString:@"带大面积中心湖泊"]) {
                lowSelectDateView.titleSwitch.on=YES;
            } if ([lowEstateLandscapeModel.大面积其他水体如溪流瀑布 isEqualToString:@"大面积其他水体如溪流瀑布"]||[lowEstateLandscapeModel.大面积其他水体如溪流瀑布 isEqualToString:@"大面积其他水体,如流溪、瀑布"]){
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==21){
            if ([lowEstateLandscapeModel.成规模种树 isEqualToString:@"成规模种树"]) {
                lowSelectDateView.titleSwitch.on=YES;
            } if ([lowEstateLandscapeModel.大面积草坪 isEqualToString:@"大面积草坪"]){
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==22){
            if ([lowEstateLandscapeModel.大面积园 isEqualToString:@"大面积园"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
        }else if (section==23){
            lowSelectDateView.cellTitleLable.text=@"商业配套";
            if ([lowEstateBusinessModel.大型商场 isEqualToString:@"大型商场"]) {
                lowSelectDateView.titleSwitch.on=YES;
            } if ([lowEstateBusinessModel.知名超市 isEqualToString:@"知名超市"]){
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==24){
            if ([lowEstateBusinessModel.商业街 isEqualToString:@"商业街"]) {
                lowSelectDateView.titleSwitch.on=YES;
            } if ([lowEstateBusinessModel.高级会所 isEqualToString:@"高级会所"]){
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==25){
            if ([lowEstateBusinessModel.很少商业配套 isEqualToString:@"很少商业配套"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
        }else if (section==29){
            lowSelectDateView.cellTitleLable.text=@"运动设施";
            if ([lowEstateMovementModel.网球场 isEqualToString:@"网球场"]) {
                lowSelectDateView.titleSwitch.on=YES;
            } if ([lowEstateMovementModel.高尔夫球场 isEqualToString:@"高尔夫球场"]){
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==30){
            if ([lowEstateMovementModel.篮球场 isEqualToString:@"篮球场"]) {
                lowSelectDateView.titleSwitch.on=YES;
            } if ([lowEstateMovementModel.室内泳池 isEqualToString:@"室内泳池"]){
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==31){
            if ([lowEstateMovementModel.室外泳池 isEqualToString:@"室外泳池"]) {
                lowSelectDateView.titleSwitch.on=YES;
            } if ([lowEstateMovementModel.健身会所 isEqualToString:@"健身会所"]){
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==32){
            if ([lowEstateMovementModel.登山私 isEqualToString:@"登山私"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
        }
        return lowSelectDateView;

    } else if(section==12){
        
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier6];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier6 DataArray:array];
        } houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            lowEstateListModel.立面材质=[array objectAtIndex:selectIndex];
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
            if([lowEstateListModel.立面材质 isEqualToString:@"面砖"]){
                houseSelectView.dVSwitch.selectedIndex=1;
            }else if([lowEstateListModel.立面材质 isEqualToString:@"石材"]){
                houseSelectView.dVSwitch.selectedIndex=2;
            }else if([lowEstateListModel.立面材质 isEqualToString:@"其它"]){
                houseSelectView.dVSwitch.selectedIndex=3;
            } else{
                houseSelectView.dVSwitch.selectedIndex=0;
                lowEstateListModel.立面材质=@"涂料";
            }
            

       
//        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:_SwitchIndex];
        return houseSelectView;
    }else if (section>=34&&section<=37){
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier22];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier22 DataArray:array];
        }
        houseSelectView.tag=section+1000;
//        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:_SwitchIndex];
        houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            NSLog(@"%ld",Tag);
            if (Tag==1034) {
                lowEstateListModel.托儿所=[array objectAtIndex:selectIndex];
            }else if (Tag==1035){
                lowEstateListModel.幼儿园=[array objectAtIndex:selectIndex];
            }else if (Tag==1036){
                lowEstateListModel.小学学位=[array objectAtIndex:selectIndex];
            }else if (Tag==1037){
                lowEstateListModel.中学学位=[array objectAtIndex:selectIndex];
            }
            
        };
        houseSelectView.cellLable.text=nil;
        if (section==34) {
            houseSelectView.cellLable.text=@"教育配套";
        }
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
        if (section==34) {
           
            [self select_init:lowEstateListModel.托儿所 SelectView:houseSelectView];
        }else if (section==35){
            
            [self select_init:lowEstateListModel.幼儿园 SelectView:houseSelectView];
        }else if (section==36){
            
            [self select_init:lowEstateListModel.小学学位 SelectView:houseSelectView];
        }else if (section==37){
            
            [self select_init:lowEstateListModel.中学学位 SelectView:houseSelectView];
        }

        return houseSelectView;
    }else if (section>=38&&section<=44){
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier8];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier8 DataArray:array];
        }
        houseSelectView.tag=section+1000;
        houseSelectView.cellLable.text=nil;
        if (section==38) {
            houseSelectView.cellLable.text=@"稀缺资源";
        }
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
        houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            if (selectIndex==0) {
                [self.lowArray replaceObjectAtIndex:section withObject:@"NO"];
            }else{
                [self.lowArray replaceObjectAtIndex:section withObject:@"YES"];
            }
            NSLog(@"%ld",Tag);
            if (Tag==1038) {
                lowEstateListModel.海滨别墅=[array objectAtIndex:selectIndex];
                NSLog(@"%@",[array objectAtIndex:selectIndex]);
                NSLog(@"%@",lowEstateListModel.海滨别墅);
            }else if (Tag==1039){
                lowEstateListModel.河流湖泊别墅=[array objectAtIndex:selectIndex];
            }else if (Tag==1040){
                lowEstateListModel.山景别墅=[array objectAtIndex:selectIndex];
            }else if (Tag==1041){
                lowEstateListModel.城市核心区别墅=[array objectAtIndex:selectIndex];
            }else if (Tag==1042){
                lowEstateListModel.公园别墅=[array objectAtIndex:selectIndex];
            }else if (Tag==1043){
                lowEstateListModel.高尔夫别墅=[array objectAtIndex:selectIndex];
            }else if (Tag==1044){
                lowEstateListModel.园林别墅=[array objectAtIndex:selectIndex];
            }
            [self Refresh:section];
        };
        if (section==38) {
        
            [self Cselect_init:lowEstateListModel.海滨别墅 SelectView:houseSelectView];
        }else if (section==39){
            [self Cselect_init:lowEstateListModel.河流湖泊别墅 SelectView:houseSelectView];
        }else if (section==40){
            [self Cselect_init:lowEstateListModel.山景别墅 SelectView:houseSelectView];
        }else if (section==41){
            [self Cselect_init:lowEstateListModel.城市核心区别墅 SelectView:houseSelectView];
        }else if (section==42){
            [self Cselect_init:lowEstateListModel.公园别墅 SelectView:houseSelectView];
        }else if (section==43){
            [self Cselect_init:lowEstateListModel.高尔夫别墅 SelectView:houseSelectView];
        }else if (section==44){
            [self Cselect_init:lowEstateListModel.园林别墅 SelectView:houseSelectView];
        }
        
        return houseSelectView;
    }else if (section>=46&&section<=49){
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
        if (section==46&&lowEstateListModel.楼盘效果图) {
            [NetworkManager _initSdImage:[NetworkManager jiequStr:lowEstateListModel.楼盘效果图 rep:@","] ImageView:lowSelectDateView.phImageView];
        }else if (section==47&&lowEstateListModel.楼盘平面图){
            [NetworkManager _initSdImage:[NetworkManager jiequStr:lowEstateListModel.楼盘平面图 rep:@","] ImageView:lowSelectDateView.phImageView];
        }else if (section==48&&lowEstateListModel.配套设施图){
            [NetworkManager _initSdImage:[NetworkManager jiequStr:lowEstateListModel.配套设施图 rep:@","] ImageView:lowSelectDateView.phImageView];
        }else if (section==49&&lowEstateListModel.内外部景观图){
            [NetworkManager _initSdImage:[NetworkManager jiequStr:lowEstateListModel.内外部景观图 rep:@","] ImageView:lowSelectDateView.phImageView];
        }
        lowSelectDateView.Clock=^(NSInteger ClockTag){
//            NSArray *array=[_dropDownArray objectAtIndex:ClockTag-1000];
            NSLog(@"%ld",ClockTag);
            NSString *str=[NetworkManager Datastrings:[[self.baseArray objectAtIndex:ClockTag-1000] allKeys]];
            NSLog(@"%@",str);
            POHViewController *pOHViewController=[[POHViewController alloc]initWithNibName:@"POHViewController" bundle:nil];
            if (ClockTag==1046) {
                NSMutableArray *PHarray=[NetworkManager address:lowEstateListModel.楼盘效果图];
                if (PHarray.count==0) {
                    PHarray = [NSMutableArray arrayWithCapacity:1];
                }
                pOHViewController.PHOarray=PHarray;
                pOHViewController.successfulIndex = PHarray.count;
            }else if (ClockTag==1047) {
                NSMutableArray *PHarray=[NetworkManager address:lowEstateListModel.楼盘平面图];
                if (PHarray.count==0) {
                    PHarray = [NSMutableArray arrayWithCapacity:1];
                }
                pOHViewController.PHOarray=PHarray;
                pOHViewController.successfulIndex = PHarray.count;
            }else if (ClockTag==1048) {
                NSMutableArray *PHarray=[NetworkManager address:lowEstateListModel.配套设施图];
                if (PHarray.count==0) {
                    PHarray = [NSMutableArray arrayWithCapacity:1];
                }
                pOHViewController.PHOarray=PHarray;
                pOHViewController.successfulIndex = PHarray.count;
            }else if (ClockTag==1049) {
                NSMutableArray *PHarray=[NetworkManager address:lowEstateListModel.内外部景观图];
                if (PHarray.count==0) {
                    PHarray = [NSMutableArray arrayWithCapacity:1];
                }
                pOHViewController.PHOarray=PHarray;
                pOHViewController.successfulIndex = PHarray.count;
            }

            
            [self.navigationController pushViewController:pOHViewController animated:YES];
            pOHViewController.ClockSave=^(NSArray *ArrayID,NSString *ImageUrl){
                if (ClockTag==1046) {
                    lowEstateListModel.楼盘效果图=ImageUrl;
                    [IDs addObject:ArrayID];
                }else if (ClockTag==1047) {
                    lowEstateListModel.楼盘平面图=ImageUrl;
                    [IDs addObject:ArrayID];
                }else if (ClockTag==1048) {
                    lowEstateListModel.配套设施图=ImageUrl;
                    [IDs addObject:ArrayID];
                }else if (ClockTag==1049) {
                    lowEstateListModel.内外部景观图=ImageUrl;
                    [IDs addObject:ArrayID];
                }
                [tableView reloadData];
            };
            pOHViewController.imageType=str;
            pOHViewController.orderType=@"houseXiaoqu";
            pOHViewController.ID=lowEstateListModel.ID;
            pOHViewController.stakID=self.estateID;
            pOHViewController.selectMax=5;
//            PhotoPickerViewController *photoPickerViewController=[[PhotoPickerViewController alloc]init];
//            if (array.count!=0) {
//                photoPickerViewController.LQPhotoPicker_selectedAssetArray=[NSMutableArray arrayWithArray:[array objectAtIndex:0]];
//                photoPickerViewController.LQPhotoPicker_smallImageArray=[NSMutableArray arrayWithArray:[array objectAtIndex:3]];
//                photoPickerViewController.LQPhotoPicker_bigImageArray=[NSMutableArray arrayWithArray:[array objectAtIndex:1]];
//            }
//            
//            photoPickerViewController.ClockPhon=^(NSArray *phionImgeArray){
//                [_dropDownArray replaceObjectAtIndex:ClockTag-1000 withObject:phionImgeArray];
//                [self Refresh:ClockTag-1000];
//            };
//            
//            if (ClockTag==1046) {
//                NSArray *aray=[NetworkManager address: lowEstateListModel.楼盘效果图];
//                photoPickerViewController.LQPhotoPicker_smallImageArray=[NSMutableArray arrayWithArray:aray];
//                photoPickerViewController.Arraycount=aray.count;
//            }else if (ClockTag==1047) {
//                NSArray *aray=[NetworkManager address:lowEstateListModel.楼盘平面图];
//                photoPickerViewController.LQPhotoPicker_smallImageArray=[NSMutableArray arrayWithArray:aray];
//                photoPickerViewController.Arraycount=aray.count;
//            }else if (ClockTag==1048) {
//                NSArray *aray=[NetworkManager address:lowEstateListModel.配套设施图];
//                photoPickerViewController.LQPhotoPicker_smallImageArray=[NSMutableArray arrayWithArray:aray];
//                photoPickerViewController.Arraycount=aray.count;
//            }else if (ClockTag==1049) {
//                NSArray *aray=[NetworkManager address:lowEstateListModel.内外部景观图];
//                photoPickerViewController.LQPhotoPicker_smallImageArray=[NSMutableArray arrayWithArray:aray];
//                photoPickerViewController.Arraycount=aray.count;
//            }
//            
//            photoPickerViewController.ClockSave=^(NSArray *ArrayID,NSString *ImageUrl){
//                if (ClockTag==1046) {
//                    lowEstateListModel.楼盘效果图=ImageUrl;
//                    [IDs addObject:ArrayID];
//                }else if (ClockTag==1047) {
//                    lowEstateListModel.楼盘平面图=ImageUrl;
//                    [IDs addObject:ArrayID];
//                }else if (ClockTag==1048) {
//                    lowEstateListModel.配套设施图=ImageUrl;
//                    [IDs addObject:ArrayID];
//                }else if (ClockTag==1049) {
//                    lowEstateListModel.内外部景观图=ImageUrl;
//                    [IDs addObject:ArrayID];
//                }
//            };
//            photoPickerViewController.type=self.selectSee;
//            NSString *str=[NetworkManager Datastrings:[[self.baseArray objectAtIndex:ClockTag-1000] allKeys]];
//            photoPickerViewController.imageType=str;
//            photoPickerViewController.orderType=@"houseXiaoqu";
//            photoPickerViewController.ID=lowEstateListModel.ID;
//            photoPickerViewController.stakID=self.estateID;
//            //            photoPickerViewController.LQPhotoPicker_selectedAssetArray=array;
//            [self.navigationController pushViewController:photoPickerViewController animated:YES];
        };
        return lowSelectDateView;
    } else //if (section==15||section==16||section==17||section==18||section==21||section==23||section==25)
    {
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier1 ];
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        formInPutView.formTextField.keyboardType=UIKeyboardTypeDefault;
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"选填"];
        NSLog(@"%d",section);
        formInPutView.formTextField.text=@"";
        if (section==0) {
            if (!lowEstateListModel.调查人) {
                lowEstateListModel.调查人=[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
            }
            formInPutView.formTextField.text=lowEstateListModel.调查人;
        }else if (section==5&&lowEstateListModel.楼盘别名){
            formInPutView.formTextField.text=lowEstateListModel.楼盘别名;
        }else if (section==9&&lowEstateListModel.开发商){
            formInPutView.formTextField.text=lowEstateListModel.开发商;
        }else if (section==14){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (lowEstateListModel.物业管理费) {
                formInPutView.formTextField.text=lowEstateListModel.物业管理费;
            }
            
        }else  if (section==15&&lowEstateListModel.物管费备注) {
            formInPutView.formTextField.text=lowEstateListModel.物管费备注;
        }else if (section==17) {
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (lowEstateListModel.建筑密度) {
                formInPutView.formTextField.text=lowEstateListModel.建筑密度;
            }
            
        }else if (section==18) {
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (lowEstateListModel.绿地率) {
                formInPutView.formTextField.text=lowEstateListModel.绿地率;
            }
            
        }else if (section==27) {
             formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (lowEstateListModel.室内车位) {
                 formInPutView.formTextField.text=lowEstateListModel.室内车位;
            }
           
        }else if (section==28) {
             formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (lowEstateListModel.露天车位) {
                formInPutView.formTextField.text=lowEstateListModel.露天车位;
            }
            
        }else if (section==33&&lowEstateListModel.其它特色配套) {
            formInPutView.formTextField.text=lowEstateListModel.其它特色配套;
        }else if (section==45&&lowEstateListModel.其它资源) {
            formInPutView.formTextField.text=lowEstateListModel.其它资源;
        }else if (section==50&&lowEstateListModel.不利因素) {
            formInPutView.formTextField.text=lowEstateListModel.不利因素;
        }else if (section==51&&lowEstateListModel.楼盘特色) {
            formInPutView.formTextField.text=lowEstateListModel.楼盘特色;
        }
        return formInPutView;
    }
    
}

-(void)select_init:(NSString *)title SelectView:(HouseSelectView *)selectView{
    if (!title) {
        title=@"无";
    }
        if([title isEqualToString:@"有"]){
            selectView.dVSwitch.selectedIndex=1;
        }else {
            selectView.dVSwitch.selectedIndex=0;
            
        }
        
}

-(void)Cselect_init:(NSString *)title SelectView:(HouseSelectView *)selectView{
    NSLog(@"%@",title);
    if (!title) {
        title=@"否";
    }

        if ([title isEqualToString:@"否"]) {
            selectView.dVSwitch.selectedIndex=0;
        }else if([title isEqualToString:@"是"]){
            selectView.dVSwitch.selectedIndex=1;
        }
        
}


-(void)repleStr:(LowEstateListModel *)RepleoEstateListModel{
    if ([RepleoEstateListModel.海滨别墅 isEqualToString:@"是"]) {
        [self reple:38];
    }else if ([RepleoEstateListModel.河流湖泊别墅 isEqualToString:@"是"]){
        [self reple:39];
    }else if ([RepleoEstateListModel.山景别墅 isEqualToString:@"是"]){
        [self reple:40];
    }else if ([RepleoEstateListModel.城市核心区别墅 isEqualToString:@"是"]){
        [self reple:41];
    }else if ([RepleoEstateListModel.公园别墅 isEqualToString:@"是"]){
        [self reple:42];
    }else if ([RepleoEstateListModel.高尔夫别墅 isEqualToString:@"是"]){
        [self reple:43];
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
        if (section==51) {
            return 44;
        }
    }
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (![self.selectSee isEqualToString:@"查看"]) {
        if (section==51) {
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
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    [self.baseTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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
        lowEstateListModel.调查人=textField.text;
    }else if (textField.tag==1003){
        lowEstateListModel.实际楼盘名称=textField.text;
    }else if (textField.tag==1005){
        lowEstateListModel.楼盘别名=textField.text;
    }else if (textField.tag==1006){
        lowEstateListModel.竣工年代=textField.text;
    }else if (textField.tag==1007){
        [self repn:textField.text Index:0 Datas:addressArray1];
    }else if (textField.tag==107){
        [self repn:textField.text Index:1 Datas:addressArray1];
    }else if (textField.tag==17){
        [self repn:textField.text Index:2 Datas:addressArray1];
    }else if (textField.tag==1008){
        [self repn:textField.text Index:0 Datas:addressArray2];
    }else if (textField.tag==108){
        [self repn:textField.text Index:1 Datas:addressArray2];
    }else if (textField.tag==18){
        [self repn:textField.text Index:2 Datas:addressArray2];
    }else if (textField.tag==1009){
        lowEstateListModel.开发商=textField.text;
    }else if (textField.tag==1010){
        lowEstateListModel.楼盘类型=textField.text;
    }else if (textField.tag==1013){
        lowEstateListModel.物管公司=textField.text;
    }else if (textField.tag==1014){
        lowEstateListModel.物业管理费=textField.text;
    }else if (textField.tag==1015){
        lowEstateListModel.物管费备注=textField.text;
    }else if (textField.tag==1016){
        lowEstateListModel.容积率=textField.text;
    }else if (textField.tag==1017){
        lowEstateListModel.建筑密度=textField.text;
    }else if (textField.tag==1018){
        lowEstateListModel.绿地率=textField.text;
    }else if (textField.tag==1026){
        lowEstateListModel.公共车位=textField.text;
    }else if (textField.tag==1027){
        lowEstateListModel.室内车位=textField.text;
    }else if (textField.tag==1028){
        lowEstateListModel.露天车位=textField.text;
    }else if (textField.tag==1033){
        lowEstateListModel.其它特色配套=textField.text;
    }else if (textField.tag==1045){
        lowEstateListModel.其它资源=textField.text;
    }else if (textField.tag==1050){
        lowEstateListModel.不利因素=textField.text;
    }else if (textField.tag==1051){
        lowEstateListModel.楼盘特色=textField.text;
    }else if (textField.tag==10038){
        lowEstateListModel.海滨名称=textField.text;
    }else if (textField.tag==10039){
        lowEstateListModel.河流湖泊名称=textField.text;
    }else if (textField.tag==10040){
        lowEstateListModel.山景名称=textField.text;
    }else if (textField.tag==10041){
        lowEstateListModel.城市核心区名称=textField.text;
    }else if (textField.tag==10042){
        lowEstateListModel.公园名称=textField.text;
    }else if (textField.tag==10043){
        lowEstateListModel.高尔夫名称=textField.text;
    }
    fistTextField = nil;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"%d",textField.tag);
    Indext=textField.tag;
    if (textField.tag==1010||textField.tag==1011||textField.tag==1019||textField.tag==1020||textField.tag==1024) {
        _selectFormPickerView.trafficArray=[self.dropDownArray objectAtIndex:textField.tag-1000];
    }else if (textField.tag==1008||textField.tag==1007){
        _citypick.trafficArray=[NetworkManager _readInit:@"city"];
    }
//
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
    
    NSMutableDictionary *dictSave=[[NSMutableDictionary alloc]initWithDictionary:lowEstateListModel.toDictionary];
    if (self.estateID) {
        [dictSave setObject:self.estateID forKey:@"taskId"];
    }
    [dictSave setObject:@"houseXiaoqu" forKey:@"makeType"];
    
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
                lowEstateListModel.ID = saveModel.ID;
                [BaseView _init:saveModel.message View:SelfWeek.view];
                if (![self.selectSee isEqualToString:@"编辑"]) {
                    [SelfWeek postValues:@{@"ID":saveModel.ID,@"NAME":lowEstateListModel.实际楼盘名称}];
                    
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
    NSNotification *notification =[NSNotification notificationWithName:@"lowloupan" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

//判断必填项
-(void)required{
    __block int count1 = 0;
    __block int count2 = 0;
    lowEstateListModel.运动设施=[NetworkManager Datastrings:[lowEstateMovementModel.toDictionary allValues]];
    lowEstateListModel.商业配套=[NetworkManager Datastrings:[lowEstateBusinessModel.toDictionary allValues]];
    lowEstateListModel.景观设施=[NetworkManager Datastrings:[lowEstateLandscapeModel.toDictionary allValues]];
    //    把位置信息转成字符串付给对象属性
    lowEstateListModel.详细地址1=[NetworkManager Datastrings:addressArray1];
    lowEstateListModel.详细地址2=[NetworkManager Datastrings:addressArray2];
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

    if(!lowEstateListModel.实际楼盘名称){
        [BaseView _init:@"请输入实际楼盘名称" View:self.view];
    }else if(count1!=3&&count2!=3){
        [BaseView _init:@"请输入任意一个完整的地理位置信息" View:self.view];
    }else if(!lowEstateListModel.物管公司){
        [BaseView _init:@"请输入物管公司" View:self.view];
    }else if(!lowEstateListModel.容积率){
        [BaseView _init:@"请输入容积率" View:self.view];
    }else if(!lowEstateListModel.景观设施){
        [BaseView _init:@"请选择景观设施" View:self.view];
    }else if(!lowEstateListModel.商业配套){
        [BaseView _init:@"请选择商业配套" View:self.view];
    }else if(!lowEstateListModel.公共车位){
        [BaseView _init:@"请输入公共车位" View:self.view];
    }else if(!lowEstateListModel.运动设施){
        [BaseView _init:@"请选择运动设施" View:self.view];
    }else if([lowEstateListModel.海滨别墅 isEqualToString:@"有"]&&!lowEstateListModel.海滨名称){
        [BaseView _init:@"请输入海滨名称" View:self.view];
    }else if([lowEstateListModel.河流湖泊别墅 isEqualToString:@"有"]&&!lowEstateListModel.河流湖泊名称){
        [BaseView _init:@"请输入河流湖泊名称" View:self.view];
    }else if([lowEstateListModel.山景别墅 isEqualToString:@"有"]&&!lowEstateListModel.山景名称){
        [BaseView _init:@"请输入山景名称" View:self.view];
    }else if([lowEstateListModel.城市核心区别墅 isEqualToString:@"有"]&&!lowEstateListModel.城市核心区名称){
        [BaseView _init:@"请输入城市核心区名称" View:self.view];
    }else if([lowEstateListModel.公园别墅 isEqualToString:@"有"]&&!lowEstateListModel.公园名称){
        [BaseView _init:@"请输入公园名称" View:self.view];
    }else if([lowEstateListModel.高尔夫别墅 isEqualToString:@"有"]&&!lowEstateListModel.高尔夫名称){
        [BaseView _init:@"请输入高尔夫名称" View:self.view];
    }else if(!lowEstateListModel.楼盘效果图){
        [BaseView _init:@"请选择楼盘效果图" View:self.view];
    }else if ([NetworkManager address:lowEstateListModel.楼盘效果图].count>1){
        [BaseView _init:@"楼盘效果图1张" View:self.view];
    }else if(!lowEstateListModel.楼盘平面图){
        [BaseView _init:@"请选择楼盘平面图" View:self.view];
    }else if ([NetworkManager address:lowEstateListModel.楼盘平面图].count>1){
        [BaseView _init:@"楼盘平面图1张" View:self.view];
    }else if(!lowEstateListModel.配套设施图){
        [BaseView _init:@"请选择配套设施图" View:self.view];
    }else if ([NetworkManager address:lowEstateListModel.配套设施图].count<2||[NetworkManager address:lowEstateListModel.配套设施图].count>6){
        [BaseView _init:@"配套设施图2-5张" View:self.view];
    }else if(!lowEstateListModel.内外部景观图){
        [BaseView _init:@"请选择内外部景观图" View:self.view];
    }else if ([NetworkManager address:lowEstateListModel.内外部景观图].count<2||[NetworkManager address:lowEstateListModel.内外部景观图].count>6){
        [BaseView _init:@"内外部景观图2-5张" View:self.view];
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
