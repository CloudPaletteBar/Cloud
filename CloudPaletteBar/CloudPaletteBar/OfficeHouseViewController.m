//
//  OfficeHouseViewController.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "OfficeHouseViewController.h"
#import "CloudPaletteBar.h"
#import "LowEstateCell.h"
#import "NetworkManager.h"
#import "LowPropertyNameView.h"
#import "FormInPutView.h"
#import "LowPackView.h"
#import "HouseSelectView.h"
#import "LowHouseSwitchView.h"
#import "LowSelectDateView.h"
#import "LowFootView.h"
#import "PhotoView.h"
#import "PhotoPickerViewController.h"
#import "CalendarView.h"
#import "SelectFormPickerView.h"
#import "FormSelectTableView.h"
#import "SystemModel.h"
#import "MJRefresh.h"
#import "OfficeHouseModel.h"
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
static NSString *Identifier13=@"Identifier13";
static NSString *Identifier20=@"Identifier20";

@interface OfficeHouseViewController ()<UITextFieldDelegate,UISearchBarDelegate>{
    UITextField *fistTextField;
    FormSelectTableView *formSelectTableView;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    OfficeHouseModel *officeHouseModel;
    OfficeHouseListModel *officeHouseListModel;
//    朝向
    OfficeHouseOrientationModel *officeHouseOrientationModel;
//    房屋照片
    OfficeHousePhModel *officeHousePhModel;
//    出入门牌号照片
    OfficeHousePhModel *officeHousePhModel1;
    NSInteger indexIn;
    NSMutableArray  *IDs;
    NSInteger ViewTag;
    NSMutableArray *arrayData;
    NSString *bangongLouPan;
    NSString *secarchName;
    UIView *formSelectView;
}
@property(nonatomic,strong)CalendarView *calendarView;
@property(nonatomic,strong)NSMutableArray *lowArray;
@property(nonatomic,strong)NSMutableArray *dropDownArray;
@property(nonatomic,strong)SelectFormPickerView *selectFormPickerView;
@property (nonatomic ,strong)UISearchBar *searchBar;
@end

@implementation OfficeHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    IDs=[[NSMutableArray alloc]init];
    self.baseTableView.frame=CGRectMake(0, 0, screen_width, screen_height-50-64);
    [self registerHeat];
    self.lowArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OpenOrClose"]];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"LowEstateCell" bundle:nil] forCellReuseIdentifier:Identifier];
    //    LowEstate
    self.baseArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OfficeHouse"]];
    self.dropDownArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"House"]];
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
        if (ViewTag==1001) {
            [SelfWeak netSysData2:Page andName:[super replaceString:secarchName]];
        }else
        [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
    } Down:^(int Page) {
        if (ViewTag==1001) {
            [SelfWeak netSysData2:Page andName:[super replaceString:secarchName]];
        }else
            [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
    }];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(officeloudong:) name:@"officeloudong" object:nil];
}


-(void)officeloudong:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"ID"]);
    NSLog(@"%@",text.userInfo[@"NAME"]);
    officeHouseListModel.楼栋编号=text.userInfo[@"ID"];
    officeHouseListModel.楼栋名称=text.userInfo[@"NAME"];
    bangongLouPan = text.userInfo[@"楼盘名称"];
    [self.baseTableView reloadData];
}


-(void)registerHeat{
    [self registerHeat:@"LowPropertyNameView" Mark:Identifier1];
    [self registerHeat:@"FormInPutView" Mark:Identifier2];
    [self registerHeat:@"LowPackView" Mark:Identifier3];
    [self registerHeat:@"LowHouseSwitchView" Mark:Identifier4];
    [self registerHeat:@"LowSelectDateView" Mark:Identifier5];
    [self registerHeat:@"LowFootView" Mark:Identifier7];
    [self registerHeat:@"PhotoView" Mark:Identifier20];
    
    //    [self registerHeat:@"HouseSelectView" Mark:Identifier6];
    //    [self.baseTableView registerClass:[HouseSelectView class] forHeaderFooterViewReuseIdentifier:Identifier6];
}

//选择楼栋编号和选择楼栋名称
-(void)netSysData2:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"officeBuding",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":[super replaceString:bangongLouPan],@"budingName":name}];
    if (self.estateID) {
        [dic setObject:self.estateID forKey:@"taskId"];
    }
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appSelect!getBuding.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        Arraykeys=[[NSMutableArray alloc]init];
        Arrayvalues=[[NSMutableArray alloc]init];
        [SelfWeek tableviewEnd];
        SystemModel *systemModel = [[SystemModel alloc]initWithDictionary:responseObject error:nil];
        if (systemModel) {
            if ([systemModel.status isEqualToString:@"1"]) {
                for (SystemListModel *systemListModel in systemModel.list) {
                    [ Arraykeys addObject:systemListModel.楼栋编号];
                    [ Arrayvalues addObject:systemListModel.实际楼栋名称];
                }
                formSelectTableView.formSelectArray=Arrayvalues;
            }
        }
        
    } failure:^(NSError *error) {
        [SelfWeek tableviewEnd];
    }];
}
//获取系统房号和系统楼层系统建筑面积系统房屋用途
-(void)netSysData:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"budingNo":officeHouseListModel.楼栋编号,@"makeType":@"officeFangwu",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"fwNo":name}];
    if (self.estateID) {
        [dic setObject:self.estateID forKey:@"taskId"];
    }
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appSelect!getFangwu.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        Arraykeys=[[NSMutableArray alloc]init];
        Arrayvalues=[[NSMutableArray alloc]init];
        arrayData=[[NSMutableArray alloc]init];
        [SelfWeek tableviewEnd];
        SystemModel *systemModel = [[SystemModel alloc]initWithDictionary:responseObject error:nil];
        if (systemModel) {
            if ([systemModel.status isEqualToString:@"1"]) {
                for (SystemListModel *systemListModel in systemModel.list) {
                    [ Arraykeys addObject:systemListModel.房号];
//                    [ Arrayvalues addObject:systemListModel.楼层];
                    
                }
                [arrayData addObjectsFromArray:systemModel.list];
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
    if (ViewTag==1001) {
        [self netSysData2:1 andName:secarchName];
    }else{
        [self netSysData:1 andName:secarchName];
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
    if (ViewTag==1001) {
        [self netSysData2:1 andName:secarchName];
    }else{
        [self netSysData:1 andName:secarchName];
    }
}

-(void)tableviewEnd{
    [formSelectTableView.mj_header endRefreshing];
    [formSelectTableView.mj_footer endRefreshing];
}


-(void)netWork:(NSDictionary *)dic{
    typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressOneHUD:self.view Title:@"获取中..."];
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        officeHouseModel = [[OfficeHouseModel alloc]initWithDictionary:responseObject error:nil];
        if (officeHouseModel) {
            if ([officeHouseModel.status isEqualToString:@"1"]) {
                if (officeHouseModel.list.count>0) {
                    officeHouseListModel=[officeHouseModel.list objectAtIndex:0];
                    officeHouseOrientationModel=[[OfficeHouseOrientationModel alloc]initWithDictionary:[NetworkManager stringDictionary:officeHouseListModel.朝向] error:nil];
                    officeHousePhModel=[[OfficeHousePhModel alloc]initWithDictionary:[NetworkManager stringDictionaryImge:officeHouseListModel.房屋照片] error:nil];
                    officeHousePhModel1=[[OfficeHousePhModel alloc]initWithDictionary:[NetworkManager stringDictionaryImge:officeHouseListModel.出入口门牌号照片] error:nil];
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

-(void)Init_o{
    officeHouseListModel=[[OfficeHouseListModel alloc]init];
    officeHouseOrientationModel=[[OfficeHouseOrientationModel alloc]init];
    officeHousePhModel=[[OfficeHousePhModel alloc]init];

   
}
//获取表单数据

-(void)netFormData{
   
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"officeFangwu"}];
    if (self.estateID) {
        [dic setObject:self.estateID forKey:@"taskId"];
        if ([kUserDefaults objectForKey:@"officeId" ]!=NULL) {
//            if (self.selectIndex==1) {
               [dic setObject:[super replaceString:[kUserDefaults objectForKey:@"officeId" ]] forKey:@"ID"];
//            }else{
//            [dic setObject:@"0" forKey:@"ID"];
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


-(void)registerHeat:(NSString *)xibName Mark:(NSString *)mark{
    
    [self.baseTableView registerNib:[UINib nibWithNibName:xibName bundle:nil] forHeaderFooterViewReuseIdentifier:mark];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.baseArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[self.lowArray objectAtIndex:section]isEqualToString:@"yes"]) {
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
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==13) {
        return 65;
    }
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    __weak typeof(self)selfWeek=self;
    NSDictionary *dic=[self.baseArray objectAtIndex:section];
    NSArray *key=[dic allKeys];
    if (section>=0&&section<=5) {
        LowPropertyNameView *lowPropertyNameView=(LowPropertyNameView *)[self C_init:Identifier1 ];
        [lowPropertyNameView _init:[key objectAtIndex:0] Weather:@"自动设置"];
        lowPropertyNameView.tag=1000+section;
        lowPropertyNameView.ClockLow=^(NSInteger Tag){
            if (Tag) {
                ViewTag=Tag;
                formSelectTableView.formSelectArray=nil;
                
                if (Tag==1002) {
                    if (!officeHouseListModel.楼栋编号) {
                        [BaseView _init:@"请选择楼栋名称和编号" View:self.view];
                        return;
                    }
                }
                
                [formSelectTableView.mj_header beginRefreshing];
//                    formSelectTableView.formSelectArray=Arrayvalues;
//                    formSelectTableView.formSelectArray=Arraykeys;
                formSelectTableView.TagT=Tag;
                [[BaseView baseShar]_initPop:formSelectView Type:1];
            }
        };
        formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
            _searchBar.text = @"";
            secarchName = @"";
            _searchBar.showsCancelButton = NO;
            [_searchBar resignFirstResponder];
            if (formSelectTableView.TagT==1001) {
                
                officeHouseListModel.楼栋编号=[Arraykeys objectAtIndex:Index];
                officeHouseListModel.楼栋名称=selectStr;
            }else{
                SystemListModel *systemListModel=[arrayData objectAtIndex:Index];
                officeHouseListModel.系统房号=systemListModel.房号;
                officeHouseListModel.系统楼层=systemListModel.系统楼层;
                officeHouseListModel.系统建筑面积=systemListModel.系统房屋面积;
                officeHouseListModel.系统房屋用途=systemListModel.系统房屋用途;
            }
            [self.baseTableView reloadData];
        };
        lowPropertyNameView.titleTextField.text=@"";
        
        if (section==0||(section>=3&&section<=5)) {
            lowPropertyNameView.selectButton.hidden=YES;
        }else
            lowPropertyNameView.selectButton.hidden=NO;
        
        if (section==0&&officeHouseListModel.楼栋编号){
            lowPropertyNameView.titleTextField.text=officeHouseListModel.楼栋编号;
        }else if (section==1&&officeHouseListModel.楼栋名称){
            lowPropertyNameView.titleTextField.text=officeHouseListModel.楼栋名称;
        }else if (section==2&&officeHouseListModel.系统房号){
            lowPropertyNameView.titleTextField.text=officeHouseListModel.系统房号;
        }else if (section==3&&officeHouseListModel.系统楼层){
            lowPropertyNameView.titleTextField.text=officeHouseListModel.系统楼层;
        }else if (section==4&&officeHouseListModel.系统建筑面积){
            lowPropertyNameView.titleTextField.text=officeHouseListModel.系统建筑面积;
        }else if (section==5&&officeHouseListModel.系统房屋用途){
            lowPropertyNameView.titleTextField.text=officeHouseListModel.系统房屋用途;
        }

        return lowPropertyNameView;
    }else if (section==7||section==8||section==11||section==21){
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier2 ];
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        formInPutView.formTextField.keyboardType=UIKeyboardTypeDefault;
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"必填"];
        formInPutView.formTextField.text=@"";
        
        if (section==2&&officeHouseListModel.系统房号) {
            formInPutView.formTextField.text=officeHouseListModel.系统房号;
        }else if (section==3&&officeHouseListModel.系统楼层){
            formInPutView.formTextField.text=officeHouseListModel.系统楼层;
        }else if (section==4&&officeHouseListModel.系统建筑面积){
            formInPutView.formTextField.text=officeHouseListModel.系统建筑面积;
        }else if (section==5&&officeHouseListModel.系统房屋用途){
            formInPutView.formTextField.text=officeHouseListModel.系统房屋用途;
        }else if (section==7){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (officeHouseListModel.所在楼层) {
                formInPutView.formTextField.text=officeHouseListModel.所在楼层;
            }
            
        }else if (section==8){
            if (officeHouseListModel.实际房号) {
                formInPutView.formTextField.text=officeHouseListModel.实际房号;
            }
            
        }else if (section==11){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (officeHouseListModel.实用面积) {
                formInPutView.formTextField.text=officeHouseListModel.实用面积;
            }
            
        }else if (section==21&&officeHouseListModel.当前租户){
            formInPutView.formTextField.text=officeHouseListModel.当前租户;
        }
        return formInPutView;
        
    }else if (section==6||(section>=22&&section<=24)){
        LowPackView *lowPackView=(LowPackView *)[self C_init:Identifier3];
        lowPackView.titleTextField.delegate=self;
        lowPackView.titleTextField.tag=100+section;
        [lowPackView _init:[key objectAtIndex:0] Weather:@"必填" InPutView:_selectFormPickerView];
        _selectFormPickerView.Clock=^(NSString *str){
            UITextField *filed=[selfWeek.view viewWithTag:indexIn];
            if (indexIn==106) {
                filed.text=str;
            }else if(indexIn==122){
            filed.text=str;
            }else if(indexIn==123){
                filed.text=str;
            }else if(indexIn==124){
                filed.text=str;
            } else
                filed.text=str;
//            [selfWeek.baseTableView reloadData];
        };
        lowPackView.titleTextField.text=@"";
        if (section==6) {
//            if (!officeHouseListModel.系统对应情况) {
//                officeHouseListModel.系统对应情况=@"与系统完全对应一直";
//            }
            lowPackView.titleTextField.text=officeHouseListModel.系统对应情况;
        }else if (section==22){
            if (!officeHouseListModel.当前使用情况) {
                officeHouseListModel.当前使用情况=@"开发商自用";
            }
            lowPackView.titleTextField.text=officeHouseListModel.当前使用情况;
            
        }else if (section==23){
            if (!officeHouseListModel.租户行业类别) {
                officeHouseListModel.租户行业类别=@"IT/通讯";
            }
            lowPackView.titleTextField.text=officeHouseListModel.租户行业类别;
        }else if (section==24){
            if (!officeHouseListModel.租户性质) {
                officeHouseListModel.租户性质=@"外商独资企业";
            }
            lowPackView.titleTextField.text=officeHouseListModel.租户性质;
        }

        return lowPackView;
        
    }else if (section==12||section==20||section==25||section==30||section==32) {
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier2 ];
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        formInPutView.formTextField.keyboardType=UIKeyboardTypeDefault;
        formInPutView.formTextField.text=@"";
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"选填"];
        if (section==12){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (officeHouseListModel.赠送面积) {
                formInPutView.formTextField.text=officeHouseListModel.赠送面积;
            }
            
        }else if (section==20&&officeHouseListModel.基本信息备注) {
            formInPutView.formTextField.text=officeHouseListModel.基本信息备注;
        }else if (section==25){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (officeHouseListModel.租金) {
                formInPutView.formTextField.text=officeHouseListModel.租金;
            }
            
        }else if (section==30){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (officeHouseListModel.售价) {
                formInPutView.formTextField.text=officeHouseListModel.售价;
            }
            
        }else if (section==32&&officeHouseListModel.租售情况备注){
            formInPutView.formTextField.text=officeHouseListModel.租售情况备注;
        }
        return formInPutView;
    }else if(section==9)
    {
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier6];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier6 DataArray:array];
        } houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            officeHouseListModel.是否临近电梯口=[array objectAtIndex:selectIndex];
        };
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
        if ([officeHouseListModel.是否临近电梯口 isEqualToString:@"一般位置"]){
            houseSelectView.dVSwitch.selectedIndex=1;
        }else if ([officeHouseListModel.是否临近电梯口 isEqualToString:@"偏远位置"]){
            houseSelectView.dVSwitch.selectedIndex=2;
        }else {
            houseSelectView.dVSwitch.selectedIndex=0;
            officeHouseListModel.是否临近电梯口=@"优势位置";
        }
        
        return houseSelectView;
    }else if(section==10)
    {
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier8];
         NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
           
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier8 DataArray:array];
        } houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            officeHouseListModel.装修情况=[array objectAtIndex:selectIndex];
        };
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
        if ([officeHouseListModel.装修情况 isEqualToString:@"简装"]){
            houseSelectView.dVSwitch.selectedIndex=1;
        }else if ([officeHouseListModel.装修情况 isEqualToString:@"毛坯"]){
            houseSelectView.dVSwitch.selectedIndex=2;
        }else {
            houseSelectView.dVSwitch.selectedIndex=0;
            officeHouseListModel.装修情况=@"精装";
        }
        
        return houseSelectView;
    }else if(section==17)
    {
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier10];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier10 DataArray:array];
        } houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            officeHouseListModel.采光面=[array objectAtIndex:selectIndex];
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
        if ([officeHouseListModel.采光面 isEqualToString:@"双面"]){
            houseSelectView.dVSwitch.selectedIndex=1;
        }else if ([officeHouseListModel.采光面 isEqualToString:@"以上情况不适用"]){
            houseSelectView.dVSwitch.selectedIndex=2;
        }else{
            houseSelectView.dVSwitch.selectedIndex=0;
            officeHouseListModel.采光面 =@"单面";
        }
        return houseSelectView;
    }else if(section==18)
    {
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier9];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier9 DataArray:array];
        } houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            officeHouseListModel.采光评价=[array objectAtIndex:selectIndex];
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
       if ([officeHouseListModel.采光评价 isEqualToString:@"较好"]){
            houseSelectView.dVSwitch.selectedIndex=1;
        }else if ([officeHouseListModel.采光评价 isEqualToString:@"一般"]){
            houseSelectView.dVSwitch.selectedIndex=2;
        }else if ([officeHouseListModel.采光评价 isEqualToString:@"较差"]){
            houseSelectView.dVSwitch.selectedIndex=3;
        }else if ([officeHouseListModel.采光评价 isEqualToString:@"差"]){
            houseSelectView.dVSwitch.selectedIndex=4;
        } else  {
            houseSelectView.dVSwitch.selectedIndex=0;
            officeHouseListModel.采光评价=@"好";
        }
        return houseSelectView;
    }else if(section==19)
    {
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier11];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier11 DataArray:array];
        } houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            officeHouseListModel.特殊景观=[array objectAtIndex:selectIndex];
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:1];
         if ([officeHouseListModel.特殊景观 isEqualToString:@"有"]){
            houseSelectView.dVSwitch.selectedIndex=0;
         }else {
             houseSelectView.dVSwitch.selectedIndex=1;
             officeHouseListModel.特殊景观=@"无";
         }
        return houseSelectView;
    }else if(section==26)
    {
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier12];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier12 DataArray:array];
        } houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
             officeHouseListModel.包含物业管理费=[array objectAtIndex:selectIndex];
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:1];
        if ([officeHouseListModel.包含物业管理费 isEqualToString:@"是"]){
            houseSelectView.dVSwitch.selectedIndex=0;
        }else {
            houseSelectView.dVSwitch.selectedIndex=1;
            officeHouseListModel.包含物业管理费=@"否";
        }

        return houseSelectView;
    }else if (section>=13&&section<=16){
        LowHouseSwitchView *lowSelectDateView=(LowHouseSwitchView *)[self C_init:Identifier4 ];
        lowSelectDateView.tag=section+1000;
        NSString *keyStr=[key objectAtIndex:0];
        [lowSelectDateView _init:[NetworkManager interceptStrTo:keyStr PleStr:@"+"] Title1:[NetworkManager interceptStrFrom:keyStr PleStr:@"+"] TitleSwitch:NO TitleSwitch1:NO];
        lowSelectDateView.Clock=^(NSInteger indexSwitch,BOOL open){
            NSLog(@"%d",indexSwitch);
            if (open) {
                if (indexSwitch==1014) {
                    officeHouseOrientationModel.南=@"南";
                }else if (indexSwitch==1113){
                    officeHouseOrientationModel.东=@"东";
                }else if (indexSwitch==1015){
                    officeHouseOrientationModel.西=@"西";
                }else if (indexSwitch==1114){
                    officeHouseOrientationModel.北=@"北";
                }else if (indexSwitch==1016){
                    officeHouseOrientationModel.东南=@"东南";
                }else if (indexSwitch==1115){
                    officeHouseOrientationModel.东北=@"东北";
                }else if (indexSwitch==1017){
                    officeHouseOrientationModel.西南=@"西南";
                }else if (indexSwitch==1116){
                    officeHouseOrientationModel.西北=@"西北";
                }
            }else{
                if (indexSwitch==1014) {
                    officeHouseOrientationModel.南=@"";
                }else if (indexSwitch==1113){
                    officeHouseOrientationModel.东=@"";
                }else if (indexSwitch==1015){
                    officeHouseOrientationModel.西=@"";
                }else if (indexSwitch==1114){
                    officeHouseOrientationModel.北=@"";
                }else if (indexSwitch==1016){
                    officeHouseOrientationModel.东南=@"";
                }else if (indexSwitch==1115){
                    officeHouseOrientationModel.东北=@"";
                }else if (indexSwitch==1017){
                    officeHouseOrientationModel.西南=@"";
                }else if (indexSwitch==1116){
                    officeHouseOrientationModel.西北=@"";
                }
            }
        };
        if (section==13) {
            lowSelectDateView.titleSwitch.on=NO;
            lowSelectDateView.cellTitleLable.text=@"朝向";
            if ([officeHouseOrientationModel.南 isEqualToString:@"南"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            lowSelectDateView.titleSwitch1.on=NO;
            if ([officeHouseOrientationModel.东 isEqualToString:@"东"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==14) {
            lowSelectDateView.titleSwitch.on=NO;
            if ([officeHouseOrientationModel.西 isEqualToString:@"西"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            lowSelectDateView.titleSwitch1.on=NO;
            if ([officeHouseOrientationModel.北 isEqualToString:@"北"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==15) {
            lowSelectDateView.titleSwitch.on=NO;
            if ([officeHouseOrientationModel.东南 isEqualToString:@"东南"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            lowSelectDateView.titleSwitch1.on=NO;
            if ([officeHouseOrientationModel.东北 isEqualToString:@"东北"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==16) {
            lowSelectDateView.titleSwitch.on=NO;
            if ([officeHouseOrientationModel.西南 isEqualToString:@"西南"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            lowSelectDateView.titleSwitch1.on=NO;
            if ([officeHouseOrientationModel.西北 isEqualToString:@"西北"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }
        return lowSelectDateView;
    }else if (section==27||section==28){
        LowSelectDateView *lowSelectDateView=(LowSelectDateView *)[self C_init:Identifier5 ];
        lowSelectDateView.titleTextField.tag=section+1000;
        lowSelectDateView.titleTextField.delegate=self;
        [lowSelectDateView _init:[key objectAtIndex:0]InPutView:_calendarView];
        _calendarView.ClockDate=^(NSString * dateStr){
                lowSelectDateView.titleTextField=[selfWeek.view viewWithTag:indexIn];
                lowSelectDateView.titleTextField.text=[NetworkManager str:dateStr];
           
        };
//        lowSelectDateView.titleTextField.text=@"";
        if (section==27) {
//            if (!officeHouseListModel.审核时间) {
//                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//                [formatter setDateFormat:@"yyyy.MM.dd"];
//                officeHouseListModel.审核时间=[formatter stringFromDate:[NSDate date]];
//                
//            }interceptStrFrom
            if (officeHouseListModel.租约){
                lowSelectDateView.titleTextField.text=[NetworkManager interceptStrTo:officeHouseListModel.租约 PleStr:@","];
            }
            
        }else if(section==28){
//            if (!officeHouseListModel.调查时间) {
//                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//                [formatter setDateFormat:@"yyyy.MM.dd"];
//                officeHouseListModel.调查时间=[formatter stringFromDate:[NSDate date]];
//            }
            if (officeHouseListModel.租约){
                lowSelectDateView.titleTextField.text=[NetworkManager interceptStrTo:officeHouseListModel.租约 PleStr:@","];
            }
        }

        return lowSelectDateView;
        
    }else if(section==29||section==31)
    {
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier13];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier13 DataArray:array];
        } houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            NSLog(@"%d",Tag);
            officeHouseListModel.租约信息来源=[array objectAtIndex:selectIndex];
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
        if (section==29) {
            if ([officeHouseListModel.租约信息来源 isEqualToString:@"中介"]){
                houseSelectView.dVSwitch.selectedIndex=1;
            }else if ([officeHouseListModel.租约信息来源 isEqualToString:@"估计"]){
                houseSelectView.dVSwitch.selectedIndex=2;
            }else if ([officeHouseListModel.租约信息来源 isEqualToString:@"其他"]){
                houseSelectView.dVSwitch.selectedIndex=3;
            }else{
                houseSelectView.dVSwitch.selectedIndex=0;
                officeHouseListModel.租约信息来源=@"业主";
            }

        }else{
            if ([officeHouseListModel.租约信息来源 isEqualToString:@"中介"]){
                houseSelectView.dVSwitch.selectedIndex=1;
            }else if ([officeHouseListModel.租约信息来源 isEqualToString:@"估计"]){
                houseSelectView.dVSwitch.selectedIndex=2;
            }else if ([officeHouseListModel.租约信息来源 isEqualToString:@"其他"]){
                houseSelectView.dVSwitch.selectedIndex=3;
            }else {
                houseSelectView.dVSwitch.selectedIndex=0;
                officeHouseListModel.租约信息来源=@"业主";
            }

        }
                return houseSelectView;
    }else{
       
        //        图片
        PhotoView *lowSelectDateView=(PhotoView *)[self C_init:Identifier20 ];
        lowSelectDateView.tag=section+1000;
//        lowSelectDateView.phImageView
        NSArray *array=[_dropDownArray objectAtIndex:section];
        [lowSelectDateView _init:[key objectAtIndex:0]PhImage:nil];
//        if (array.count!=0) {
//            if ([[array objectAtIndex:3] count]!=0) {
//                [lowSelectDateView _init:[key objectAtIndex:0]PhImage:[[array objectAtIndex:3] objectAtIndex:0]];
//            }
//            
//        }
        if (section==33&&officeHouseListModel.出入口门牌号照片) {
            [NetworkManager _initSdImage:[NetworkManager jiequStr:officeHouseListModel.出入口门牌号照片 rep:@","] ImageView:lowSelectDateView.phImageView];
        }else if (section==34&&officeHouseListModel.房屋照片){
            [NetworkManager _initSdImage:[NetworkManager jiequStr:officeHouseListModel.房屋照片 rep:@","] ImageView:lowSelectDateView.phImageView];
        }
        
        lowSelectDateView.Clock=^(NSInteger ClockTag){
            NSArray *array=[_dropDownArray objectAtIndex:ClockTag-1000];
            NSLog(@"%ld",ClockTag);
            POHViewController *pOHViewController=[[POHViewController alloc]initWithNibName:@"POHViewController" bundle:nil];
            if (ClockTag==1033) {
                NSMutableArray *PHarray=[NetworkManager address:officeHouseListModel.出入口门牌号照片];
                if (PHarray.count==0) {
                    PHarray = [NSMutableArray arrayWithCapacity:1];
                }
                pOHViewController.PHOarray=PHarray;
                pOHViewController.successfulIndex = PHarray.count;
            }else{
                NSMutableArray *PHarray=[NetworkManager address:officeHouseListModel.房屋照片];
                if (PHarray.count==0) {
                    PHarray = [NSMutableArray arrayWithCapacity:1];
                }
                pOHViewController.PHOarray=PHarray;
                pOHViewController.successfulIndex = PHarray.count;
            }
            
            [self.navigationController pushViewController:pOHViewController animated:YES];
            pOHViewController.ClockSave=^(NSArray *ArrayID,NSString *ImageUrl){
                if (ClockTag==1033) {
                    officeHouseListModel.出入口门牌号照片=ImageUrl;
                    NSLog(@"%@",ImageUrl);
                    NSLog(@"%@",officeHouseListModel.出入口门牌号照片);
                    [IDs addObject:ArrayID];
                }else if (ClockTag==1034) {
                    officeHouseListModel.房屋照片=ImageUrl;
                    [IDs addObject:ArrayID];
                }
                [tableView reloadData];
                NSLog(@"%@",[NetworkManager jiequStr:ImageUrl rep:@","]);
            };
            NSString *str=[NetworkManager Datastrings:[[self.baseArray objectAtIndex:ClockTag-1000] allKeys]];
                pOHViewController.orderType=@"officeFangwu";
                pOHViewController.imageType=str;
                pOHViewController.ID=officeHouseListModel.ID;
                pOHViewController.stakID=self.estateID;
                pOHViewController.selectMax=5;
        };
        return lowSelectDateView;
    }
}



-(UITableViewHeaderFooterView *)C_init:(NSString *)mark{
    return [self.baseTableView dequeueReusableHeaderFooterViewWithIdentifier:mark];
    //    return [[[NSBundle mainBundle]loadNibNamed:xibName owner:self options:nil]lastObject];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==34) {
        return 44;
    }
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==34) {
        LowFootView *lowFootView=(LowFootView *)[self C_init:Identifier7];
        lowFootView.SaveClock=^(){
            [self required];
        };
        return lowFootView;
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


// Called when the UIKeyboardWillHideNotification is sent†
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
    
    if (textField.tag==1002) {
        officeHouseListModel.系统房号=textField.text;
    }else if (textField.tag==1003){
        officeHouseListModel.系统楼层=textField.text;
    }else if (textField.tag==1004){
        officeHouseListModel.系统建筑面积=textField.text;
    }else if (textField.tag==1005){
        officeHouseListModel.系统房屋用途=textField.text;
    }else if (textField.tag==106){
        officeHouseListModel.系统对应情况=textField.text;
    }else if (textField.tag==1007){
        officeHouseListModel.所在楼层=textField.text;
    }else if (textField.tag==1008){
        officeHouseListModel.实际房号=textField.text;
    }else if (textField.tag==1011){
        officeHouseListModel.实用面积=textField.text;
    }else if (textField.tag==1012){
        officeHouseListModel.赠送面积=textField.text;
    }else if (textField.tag==1020){
        officeHouseListModel.基本信息备注=textField.text;
    }else if (textField.tag==1021){
        officeHouseListModel.当前租户=textField.text;
    }else if (textField.tag==122){
        officeHouseListModel.当前使用情况=textField.text;
    }else if (textField.tag==123){
        officeHouseListModel.租户行业类别=textField.text;
    }else if (textField.tag==124){
        officeHouseListModel.租户性质=textField.text;
    }else if (textField.tag==1025){
        officeHouseListModel.租金=textField.text;
    }else if (textField.tag==1027){
        
        officeHouseListModel.租约=[NSString stringWithFormat:@"%@,%@",textField.text,officeHouseListModel.租约];
    }else if (textField.tag==1028){
        officeHouseListModel.租约=[NSString stringWithFormat:@"%@,%@",officeHouseListModel.租约,textField.text];
    }else if (textField.tag==1030){
        officeHouseListModel.售价=textField.text;
    }else if (textField.tag==1032){
        officeHouseListModel.租售情况备注=textField.text;
    }
    fistTextField = nil;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"%d",textField.tag);
    
    indexIn=textField.tag;
    if (textField.tag==106||textField.tag==122||textField.tag==123||textField.tag==124) {
         _selectFormPickerView.trafficArray=[self.dropDownArray objectAtIndex:textField.tag-100];
    }
//
    return YES;
}



-(void)netSaveFormData{
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"保存中..."];
    typeof(self)SelfWeek=self;
    
    NSMutableDictionary *dictSave=[[NSMutableDictionary alloc]initWithDictionary:officeHouseListModel.toDictionary];
    if (self.estateID) {
        [dictSave setObject:self.estateID forKey:@"taskId"];
    }
    [dictSave setObject:@"officeFangwu" forKey:@"makeType"];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dictSave relativePath:@"appAction!saveMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        SaveModel *saveModel=[[SaveModel alloc]initWithDictionary:responseObject error:nil];
        if (saveModel) {
            if ([saveModel.status isEqualToString:@"1"]) {
                officeHouseListModel.ID=saveModel.ID;
                for (NSArray *numbers in IDs) {
                    for (NSNumber *number in numbers) {
                        [[NetworkManager shar]updata:[number longLongValue] FormID:saveModel.ID TackId:[super replaceString:self.estateID]];
                    }
                    
                }
                officeHouseListModel.ID = saveModel.ID;
                [BaseView _init:saveModel.message View:SelfWeek.view];
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

//判断必填项
-(void)required{
    officeHouseListModel.朝向=[NetworkManager Datastrings:[officeHouseOrientationModel.toDictionary allValues]];
    if (!officeHouseListModel.楼栋编号) {
        [BaseView _init:@"请选择楼栋名称" View:self.view];
    }else if (!officeHouseListModel.系统房号){
        [BaseView _init:@"请选择系统房号" View:self.view];
    }else if (!officeHouseListModel.系统对应情况){
        [BaseView _init:@"请选择系统对应情况" View:self.view];
    }else if (!officeHouseListModel.所在楼层){
        [BaseView _init:@"请输入所在楼层" View:self.view];
    }else if (!officeHouseListModel.实际房号){
        [BaseView _init:@"请输入实际房号" View:self.view];
    }else if (!officeHouseListModel.实用面积){
        [BaseView _init:@"请输入实用面积" View:self.view];
    }else if (!officeHouseListModel.朝向){
        [BaseView _init:@"请选择朝向" View:self.view];
    }else if (!officeHouseListModel.当前租户){
        [BaseView _init:@"请输入当前租户" View:self.view];
    }else if (!officeHouseListModel.出入口门牌号照片){
        [BaseView _init:@"请选择出入口门牌号照片" View:self.view];
    }else if ([NetworkManager address:officeHouseListModel.出入口门牌号照片].count!=1){
        [BaseView _init:@"出入口门牌号照片只需要1张" View:self.view];
    }else if (!officeHouseListModel.房屋照片){
        [BaseView _init:@"请选择房屋照片" View:self.view];
    }else if ([NetworkManager address:officeHouseListModel.房屋照片].count<3||[NetworkManager address:officeHouseListModel.房屋照片].count>6){
        [BaseView _init:@"房屋照片3-5" View:self.view];
    } else{
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
