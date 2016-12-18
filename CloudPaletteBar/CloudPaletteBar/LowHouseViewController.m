//
//  LowHouseViewController.m
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "LowHouseViewController.h"
#import "LowEstateCell.h"
#import "CloudPaletteBar.h"
#import "NetworkManager.h"
#import "LowPropertyNameView.h"
#import "FormInPutView.h"
#import "LowHouseSwitchView.h"
#import "HouseSelectView.h"
#import "LowPackView.h"
#import "LowFootView.h"
#import "PhotoView.h"
#import "PhotoPickerViewController.h"
#import "SelectFormPickerView.h"
#import "SystemModel.h"
#import "FormSelectTableView.h"
#import "MJRefresh.h"
#import "LowHouseModel.h"
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
static NSString *Identifier20=@"Identifier20";

@interface LowHouseViewController ()<UITextFieldDelegate,UISearchBarDelegate>{
    UITextField *fistTextField;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    FormSelectTableView *formSelectTableView;
    LowHouseListModel *lowHouseListModel;
//    户型图
    LowHouseStandardPhModel *lowHouseStandardPhModel1;
//    楼栋外观图
    LowHouseStandardPhModel *lowHouseStandardPhModel2;
    //    景观图
    LowHouseStandardPhModel *lowHouseStandardPhModel3;
    NSInteger Indext;
//    朝向
    LowHouseOrientationModel *lowHouseOrientationModel;
//    户型结构
    LowHouseStructureModel *lowHouseStructureModel;
     NSMutableArray  *IDs;
    NSInteger ViewTag;
    NSString *dimiduLouPan;
    NSString *secarchName;
    UIView *formSelectView;
}
@property(nonatomic,strong)SelectFormPickerView *selectFormPickerView;
@property(nonatomic,strong)NSMutableArray *lowArray;
@property(nonatomic,strong)NSMutableArray *dropDownArray;
@property(nonatomic,assign)BOOL openOrClose;
@property (nonatomic ,strong)UISearchBar *searchBar;
@end

@implementation LowHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.estateID);
     IDs=[[NSMutableArray alloc]init];
    self.baseTableView.frame=CGRectMake(0, 0, screen_width, screen_height-50-64);
    [self registerHeat];
    self.lowArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OpenOrClose"]];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"LowEstateCell" bundle:nil] forCellReuseIdentifier:Identifier];
    //    LowEstate
    self.baseArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"LowHouse"]];
    self.dropDownArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"LowHouseSelcet"]];
    _selectFormPickerView=[[[NSBundle mainBundle]loadNibNamed:@"SelectFormPickerView" owner:self options:nil]lastObject];
    [_selectFormPickerView _init:nil];
    [self registerForKeyboardNotifications];
    
    formSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-150)];
    self.searchBar.frame = CGRectMake(0, 0, screen_width, 50.0);
    formSelectTableView=[[FormSelectTableView alloc]initWithFrame:CGRectMake(0, 50, screen_width, formSelectView.frame.size.height-50)];
    [formSelectView addSubview:formSelectTableView];
    __weak typeof(self)SelfWeak=self;
    [formSelectTableView _initOrderUP:^(int Page) {
        if (ViewTag==1001) {
            [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
        }else{
            [SelfWeak netSysData2:Page andName:[super replaceString:secarchName]];
        }
        
    } Down:^(int Page) {
        if (ViewTag==1001) {
            [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
        }else{
            [SelfWeak netSysData2:Page andName:[super replaceString:secarchName]];
        }
    }];
    [self netFormData];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lowloudong:) name:@"lowloudong" object:nil];
}


-(void)lowloudong:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"ID"]);
    NSLog(@"%@",text.userInfo[@"NAME"]);
    lowHouseListModel.楼栋编号=text.userInfo[@"ID"];
    lowHouseListModel.楼栋名称=text.userInfo[@"NAME"];
    dimiduLouPan = text.userInfo[@"楼盘名称"];
    [self.baseTableView reloadData];
}

-(void)registerHeat{
    [self registerHeat:@"LowPropertyNameView" Mark:Identifier1];
    [self registerHeat:@"FormInPutView" Mark:Identifier2];
    [self registerHeat:@"LowHouseSwitchView" Mark:Identifier3];
    [self registerHeat:@"LowPackView" Mark:Identifier4];
//    [self registerHeat:@"HouseSelectView" Mark:Identifier5];
    [self registerHeat:@"LowFootView" Mark:Identifier7];
     [self registerHeat:@"PhotoView" Mark:Identifier20];
    
    //    [self registerHeat:@"HouseSelectView" Mark:Identifier6];
    //    [self.baseTableView registerClass:[HouseSelectView class] forHeaderFooterViewReuseIdentifier:Identifier6];
}
//获取房屋编号、系统房号、先用房号
-(void)netSysData2:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"budingNo":lowHouseListModel.楼栋编号,@"makeType":@"houseFangwu",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"fwNo":name}];
    if (self.estateID) {
        [dic setObject:self.estateID forKey:@"taskId"];
    }
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appSelect!getFangwu.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        Arraykeys=[[NSMutableArray alloc]init];
        Arrayvalues=[[NSMutableArray alloc]init];
        [SelfWeek tableviewEnd];
        SystemModel *systemModel = [[SystemModel alloc]initWithDictionary:responseObject error:nil];
        if (systemModel) {
            if ([systemModel.status isEqualToString:@"1"]) {
                for (SystemListModel *systemListModel in systemModel.list) {
                    [ Arraykeys addObject:systemListModel.房号];
//                    [ Arrayvalues addObject:systemListModel.系统楼盘编号];
                }
//                if (formSelectTableView.TagT==1004) {
//                    formSelectTableView.formSelectArray=Arrayvalues;
//                }else{
                    formSelectTableView.formSelectArray=Arraykeys;
//                }
                //                        formSelectTableView.formSelectArray=keys;
            }
        }
        
    } failure:^(NSError *error) {
        [SelfWeek tableviewEnd];
    }];
}

//获取楼栋编号和楼栋名称
-(void)netSysData:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"houseBuding",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":[super replaceString:dimiduLouPan],@"budingName":name}];
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
                    [ Arraykeys addObject:systemListModel.实际楼栋名称];
                    [ Arrayvalues addObject:systemListModel.楼栋编号];
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
    if (ViewTag==1001) {
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
    if (ViewTag==1001) {
        [self netSysData:1 andName:secarchName];
    }else{
        [self netSysData2:1 andName:secarchName];
    }
}


-(void)tableviewEnd{
    [formSelectTableView.mj_header endRefreshing];
    [formSelectTableView.mj_footer endRefreshing];
}

-(void)Iint_o{
    lowHouseListModel=[[LowHouseListModel alloc]init];
            lowHouseStandardPhModel1=[[LowHouseStandardPhModel alloc]init];
            lowHouseStandardPhModel2=[[LowHouseStandardPhModel alloc]init];
            lowHouseStandardPhModel3=[[LowHouseStandardPhModel alloc]init];
            lowHouseOrientationModel=[[LowHouseOrientationModel alloc]init];
            lowHouseStructureModel=[[LowHouseStructureModel alloc]init];
}

//获取表单数据

-(void)netFormData{
    
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"houseFangwu"}];;
    if (self.estateID) {
        if ([kUserDefaults objectForKey:@"lowDensityId" ]!=NULL) {
            [dic setObject:self.estateID forKey:@"taskId"];
//            if (self.selectIndex==2) {
                [dic setObject:[super replaceString:[kUserDefaults objectForKey:@"lowDensityId" ]] forKey:@"ID"];
//            }else{
//                [dic setObject:@"0"forKey:@"ID"];
//            }
            [self Iint_o];
            [self netWork:dic];
        }else{
            [self Iint_o];
        }
    }else{
        if ([kUserDefaults objectForKey:@"lowDensityId" ]!=NULL) {
//            if (self.selectIndex==2) {
                [dic setObject:[super replaceString:[kUserDefaults objectForKey:@"lowDensityId" ]] forKey:@"ID"];
//            }else{
//                [dic setObject:@"0"forKey:@"ID"];
//            }
            [self Iint_o];
            [self netWork:dic];
        }else{
            [self Iint_o];
        }

    
    }

    }

-(void)netWork:(NSDictionary *)dic{
    typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressOneHUD:self.view Title:@"获取中..."];
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        LowHouseModel *lowHouseModel = [[LowHouseModel alloc]initWithDictionary:responseObject error:nil];
        if (lowHouseModel) {
            if ([lowHouseModel.status isEqualToString:@"1"]) {
                if (lowHouseModel.list.count>0) {
                    lowHouseListModel=[lowHouseModel.list objectAtIndex:0];
                    lowHouseStandardPhModel1=[[LowHouseStandardPhModel alloc]initWithDictionary:[NetworkManager stringDictionaryImge:lowHouseListModel.户型图] error:nil];
                    lowHouseStandardPhModel2=[[LowHouseStandardPhModel alloc]initWithDictionary:[NetworkManager stringDictionaryImge:lowHouseListModel.楼栋外观图] error:nil];
                    lowHouseStandardPhModel3=[[LowHouseStandardPhModel alloc]initWithDictionary:[NetworkManager stringDictionaryImge:lowHouseListModel.景观图] error:nil];
                    lowHouseOrientationModel=[[LowHouseOrientationModel alloc]initWithDictionary:[NetworkManager stringDictionary:lowHouseListModel.朝向] error:nil];
                    lowHouseStructureModel=[[LowHouseStructureModel alloc]initWithDictionary:[NetworkManager stringDictionary:lowHouseListModel.户型结构] error:nil];
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
    
    if([self panduan:lowHouseListModel.阁楼 Baohan:@"有"])//_roaldSearchText
    {
        [_lowArray replaceObjectAtIndex:22 withObject:@"YES"];
    }
    if ([self panduan: lowHouseListModel.挑高阳台 Baohan:@"有"]) {
        [_lowArray replaceObjectAtIndex:23 withObject:@"YES"];
    }if ([self panduan: lowHouseListModel.露台空中花园 Baohan:@"有"]) {
        [_lowArray replaceObjectAtIndex:24 withObject:@"YES"];
    }if ([self panduan: lowHouseListModel.私家花园庭院 Baohan:@"有"]) {
        [_lowArray replaceObjectAtIndex:25 withObject:@"YES"];
    }if ([self panduan: lowHouseListModel.私家车位车库 Baohan:@"有"]) {
        [_lowArray replaceObjectAtIndex:26 withObject:@"YES"];
    }if ([self panduan: lowHouseListModel.私家泳池 Baohan:@"有"]) {
        [_lowArray replaceObjectAtIndex:27 withObject:@"YES"];
    }if ([self panduan: lowHouseListModel.中央空调 Baohan:@"有"]) {
        [_lowArray replaceObjectAtIndex:28 withObject:@"YES"];
    }if ([self panduan: lowHouseListModel.电梯 Baohan:@"有"]) {
        [_lowArray replaceObjectAtIndex:29 withObject:@"YES"];
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
    NSString *keyStr=[value objectAtIndex:indexPath.row];
    [cell _cellInit:keyStr Weather:@"选填" ];
    cell.cellTextField.tag=indexPath.section+1000;
    cell.cellTextField.delegate=self;
    cell.cellTextField.text=nil;
    //RightViewM:[NetworkManager interceptStrFrom:keyStr PleStr:@"+"]];
    if (indexPath.section==22&&lowHouseListModel.阁楼面积) {
        cell.cellTextField.text=lowHouseListModel.阁楼面积;
    }else if (indexPath.section==23&&lowHouseListModel.挑高阳台面积) {
        cell.cellTextField.text=lowHouseListModel.挑高阳台面积;
    }else if (indexPath.section==24&&lowHouseListModel.露台面积) {
        cell.cellTextField.text=lowHouseListModel.露台面积;
    }else if (indexPath.section==25&&lowHouseListModel.私家花园面积) {
        cell.cellTextField.text=lowHouseListModel.私家花园面积;
    }else if (indexPath.section==26&&lowHouseListModel.私家车位个数) {
        cell.cellTextField.text=lowHouseListModel.私家车位个数;
    }else if (indexPath.section==27&&lowHouseListModel.私家泳池个数) {
        cell.cellTextField.text=lowHouseListModel.私家泳池个数;
    }else if (indexPath.section==28&&lowHouseListModel.中央空调个数) {
        cell.cellTextField.text=lowHouseListModel.中央空调个数;
    }else if (indexPath.section==29&&lowHouseListModel.电梯个数) {
        cell.cellTextField.text=lowHouseListModel.电梯个数;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==9||section==18) {
        return 65;
    }
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    __weak typeof(self)SelfWeek=self;
    NSDictionary *dic=[self.baseArray objectAtIndex:section];
    NSArray *key=[dic allKeys];
    if ((section>=0&&section<=1)||section==3){
        LowPropertyNameView *lowPropertyNameView=(LowPropertyNameView *)[self C_init:Identifier1 ];
        lowPropertyNameView.tag=1000+section;
        [lowPropertyNameView _init:[key objectAtIndex:0] Weather:@"自动设置"];

        if (section==4) {
            [lowPropertyNameView _init:[key objectAtIndex:0] Weather:@"选填"];

        }
        if (section==0) {
            lowPropertyNameView.selectButton.hidden=YES;
        }else
            lowPropertyNameView.selectButton.hidden=NO;
        lowPropertyNameView.ClockLow=^(NSInteger Tag){
            if (Tag) {
                ViewTag=Tag;
                formSelectTableView.formSelectArray=nil;
                NSLog(@"%ld",Tag);
                if (Tag==1003) {
                    if (!lowHouseListModel.楼栋名称) {
                        [BaseView _init:@"请选择楼栋名称和编号" View:self.view];
                        return;
                    }
                }
                [formSelectTableView.mj_header beginRefreshing];
//                if (Tag==1001) {
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
            if (formSelectTableView.TagT==1001) {
                lowHouseListModel.楼栋名称=selectStr;
                lowHouseListModel.楼栋编号=[Arrayvalues objectAtIndex:Index];
            }else{
                lowHouseListModel.系统房号=[Arraykeys objectAtIndex:Index];
            }
            [self.baseTableView reloadData];
        };
        lowPropertyNameView.titleTextField.text=@"";
        if (section==1&&lowHouseListModel.楼栋名称){
            lowPropertyNameView.titleTextField.text=lowHouseListModel.楼栋名称;
        }else if (section==0&&lowHouseListModel.楼栋编号){
            lowPropertyNameView.titleTextField.text=lowHouseListModel.楼栋编号;
        }else if (section==3&&lowHouseListModel.系统房号){
            lowPropertyNameView.titleTextField.text=lowHouseListModel.系统房号;
        }

        return lowPropertyNameView;
    }else if (((section>=4&&section<=6)||section==8)||section==21){
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier2 ];
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"必填"];
        formInPutView.formTextField.text=@"";
        if (section==3&&lowHouseListModel.系统房号) {
            formInPutView.formTextField.text=lowHouseListModel.系统房号;
        }if (section==4) {
            formInPutView.formTextField.keyboardType=UIKeyboardTypeDefault;
            if (lowHouseListModel.现用房号) {
                formInPutView.formTextField.text=lowHouseListModel.现用房号;
            }
            
        }if (section==5&&lowHouseListModel.所在楼层) {
            formInPutView.formTextField.text=lowHouseListModel.所在楼层;
        }if (section==6&&lowHouseListModel.建筑面积) {
            formInPutView.formTextField.text=lowHouseListModel.建筑面积;
        }if (section==8&&lowHouseListModel.物业管理费) {
            formInPutView.formTextField.keyboardType=UIKeyboardTypeDecimalPad;
            formInPutView.formTextField.text=lowHouseListModel.物业管理费;
        }if (section==21&&lowHouseListModel.价格) {
            formInPutView.formTextField.text=lowHouseListModel.价格;
        }
        return formInPutView;
    }else if (section>=9&&section<=12) {
        LowHouseSwitchView *lowSelectDateView=(LowHouseSwitchView *)[self C_init:Identifier3 ];
        lowSelectDateView.tag=section+1000;
        NSString *keyStr=[key objectAtIndex:0];
        [lowSelectDateView _init:[NetworkManager interceptStrTo:keyStr PleStr:@"+"] Title1:[NetworkManager interceptStrFrom:keyStr PleStr:@"+"] TitleSwitch:NO TitleSwitch1:NO];
        lowSelectDateView.Clock=^(NSInteger indexSwitch,BOOL open){
            NSLog(@"%ld",indexSwitch);
            if (open) {
                if (indexSwitch==1010) {
                    lowHouseOrientationModel.南=@"南";
                }else if (indexSwitch==1109){
                    lowHouseOrientationModel.东=@"东";
                }else if (indexSwitch==1011){
                    lowHouseOrientationModel.西=@"西";
                }else if (indexSwitch==1110){
                    lowHouseOrientationModel.北=@"北";
                }else if (indexSwitch==1012){
                    lowHouseOrientationModel.东南=@"东南";
                }else if (indexSwitch==1111){
                    lowHouseOrientationModel.东北=@"东北";
                }else if (indexSwitch==1013){
                    lowHouseOrientationModel.西南=@"西南";
                }else if (indexSwitch==1112){
                    lowHouseOrientationModel.西北=@"西北";
                }
            }else{
                if (indexSwitch==1010) {
                    lowHouseOrientationModel.南=@"";
                }else if (indexSwitch==1109){
                    lowHouseOrientationModel.东=@"";
                }else if (indexSwitch==1011){
                    lowHouseOrientationModel.西=@"";
                }else if (indexSwitch==1110){
                    lowHouseOrientationModel.北=@"";
                }else if (indexSwitch==1012){
                    lowHouseOrientationModel.东南=@"";
                }else if (indexSwitch==1111){
                    lowHouseOrientationModel.东北=@"";
                }else if (indexSwitch==1013){
                    lowHouseOrientationModel.西南=@"";
                }else if (indexSwitch==1112){
                    lowHouseOrientationModel.西北=@"";
                }
            }
        };
        lowSelectDateView.titleSwitch.on=NO;
        lowSelectDateView.titleSwitch1.on=NO;
        lowSelectDateView.cellTitleLable.text=nil;
        if (section==9){
            lowSelectDateView.cellTitleLable.text=@"朝向";
            if ([lowHouseOrientationModel.南 isEqualToString:@"南"]) {
                lowSelectDateView.titleSwitch.on=YES;
            } if ([lowHouseOrientationModel.东 isEqualToString:@"东"]){
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==10){
            if ([lowHouseOrientationModel.南 isEqualToString:@"南"]) {
                lowSelectDateView.titleSwitch.on=YES;
            } if ([lowHouseOrientationModel.东 isEqualToString:@"东"]){
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==11){
            if ([lowHouseOrientationModel.东南 isEqualToString:@"东南"]) {
                lowSelectDateView.titleSwitch.on=YES;
            } if ([lowHouseOrientationModel.东北 isEqualToString:@"东北"]){
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==12){
            if ([lowHouseOrientationModel.西南 isEqualToString:@"西南"]) {
                lowSelectDateView.titleSwitch.on=YES;
            } if ([lowHouseOrientationModel.西北 isEqualToString:@"西北"]){
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }
        return lowSelectDateView;
    }
    else if (section==17) {
        LowPackView *lowPackView=(LowPackView *)[self C_init:Identifier4];
        lowPackView.titleTextField.delegate=self;
        lowPackView.titleTextField.tag=100+section;
        [lowPackView _init:[key objectAtIndex:0] Weather:@"必填" InPutView:_selectFormPickerView];
        _selectFormPickerView.Clock=^(NSString *str){
            lowPackView.titleTextField=[SelfWeek.view viewWithTag:Indext];
            lowPackView.titleTextField.text=str;
        };
        lowPackView.titleTextField.text=@"";
        if (section==17) {
            if (!lowHouseListModel.装修程度) {
                lowHouseListModel.装修程度=@"毛坯";
            }
            lowPackView.titleTextField.text=lowHouseListModel.装修程度;
        }

        return lowPackView;
    }else if (section==13||section==14)
    {
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier5];
         NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
           
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier5 DataArray:array];
        }
        houseSelectView.tag=section+1000;
        houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            NSLog(@"%ld",Tag);
            if (Tag==1013) {
                lowHouseListModel.采光=[array objectAtIndex:selectIndex];
            }else if (Tag==1014){
                lowHouseListModel.通风=[array objectAtIndex:selectIndex];
            }
            
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
        if (section==13) {
            
            [self select_init:lowHouseListModel.采光 SelectView:houseSelectView];
        }else if (section==14){
            [self select_init:lowHouseListModel.通风 SelectView:houseSelectView];
        }
        return houseSelectView;
    }else if(section==15){
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier6];
         NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
           
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier6 DataArray:array];
        }
        houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            NSLog(@"%ld",Tag);
                lowHouseListModel.联排别墅=[array objectAtIndex:selectIndex];
            
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
        if ([lowHouseListModel.联排别墅 isEqualToString:@"中间"]){
            houseSelectView.dVSwitch.selectedIndex=1;
        }else if ([lowHouseListModel.联排别墅 isEqualToString:@"正中"]){
            houseSelectView.dVSwitch.selectedIndex=2;
        }else{
            lowHouseListModel.联排别墅=@"两侧";
            houseSelectView.dVSwitch.selectedIndex=0;
        }
        
        
        return houseSelectView;
    }else if (section==16){
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier8];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier8 DataArray:array];
        } houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            lowHouseListModel.叠墅洋房=[array objectAtIndex:selectIndex];
            
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
       if ([lowHouseListModel.叠墅洋房 isEqualToString:@"中间"]){
            houseSelectView.dVSwitch.selectedIndex=1;
        }else if ([lowHouseListModel.叠墅洋房 isEqualToString:@"下面"]){
            houseSelectView.dVSwitch.selectedIndex=2;
        } else{
            lowHouseListModel.叠墅洋房=@"上面";
            houseSelectView.dVSwitch.selectedIndex=0;
        }

        return houseSelectView;
    }else if (section>=18&&section<=20){
        LowHouseSwitchView *lowSelectDateView=(LowHouseSwitchView *)[self C_init:Identifier3 ];
        lowSelectDateView.tag=section+1000;
        NSString *keyStr=[key objectAtIndex:0];
        [lowSelectDateView _init:[NetworkManager interceptStrTo:keyStr PleStr:@"+"] Title1:[NetworkManager interceptStrFrom:keyStr PleStr:@"+"] TitleSwitch:NO TitleSwitch1:NO];
        lowSelectDateView.Clock=^(NSInteger indexSwitch,BOOL open){
            NSLog(@"%ld",indexSwitch);
            if (open) {
                if (indexSwitch==1019) {
                    lowHouseStructureModel.房=@"房";
                }else if (indexSwitch==1118){
                    lowHouseStructureModel.厅=@"厅";
                }else if (indexSwitch==1020){
                    lowHouseStructureModel.厨卫=@"厨卫";
                }else if (indexSwitch==1119){
                    lowHouseStructureModel.阳台=@"阳台";
                }else if (indexSwitch==1021){
                    lowHouseStructureModel.花园=@"花园";
                }
            }else{
                if (indexSwitch==1019) {
                    lowHouseStructureModel.房=@"";
                }else if (indexSwitch==1118){
                    lowHouseStructureModel.厅=@"";
                }else if (indexSwitch==1020){
                    lowHouseStructureModel.厨卫=@"";
                }else if (indexSwitch==1119){
                    lowHouseStructureModel.阳台=@"";
                }else if (indexSwitch==1021){
                    lowHouseStructureModel.花园=@"";
                }
            }
        };
        
        lowSelectDateView.titleSwitch.on=NO;
        lowSelectDateView.titleSwitch1.on=NO;
        lowSelectDateView.cellTitleLable.text=nil;
        if (section==18){
            lowSelectDateView.cellTitleLable.text=@"户型结构";
            if ([lowHouseStructureModel.房 isEqualToString:@"房"]) {
                lowSelectDateView.titleSwitch.on=YES;
            } if ([lowHouseStructureModel.厅 isEqualToString:@"厅"]){
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==19){
            if ([lowHouseStructureModel.厨卫 isEqualToString:@"厨卫"]) {
                lowSelectDateView.titleSwitch.on=YES;
            } if ([lowHouseStructureModel.阳台 isEqualToString:@"阳台"]){
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==20){
            if ([lowHouseStructureModel.花园 isEqualToString:@"花园"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
        }
        return lowSelectDateView;
    }else if (section>=22&&section<=29){
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier9];
         NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
           
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier9 DataArray:array];
        }
        houseSelectView.tag=section+1000;
        houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            NSLog(@"%ld",Tag);
            if (selectIndex==0) {
                [self.lowArray replaceObjectAtIndex:section withObject:@"no"];
            }else{
                [self.lowArray replaceObjectAtIndex:section withObject:@"yes"];
                
            }
            if (Tag==1022) {
                lowHouseListModel.阁楼=[array objectAtIndex:selectIndex];
            }else if (Tag==1023){
                lowHouseListModel.挑高阳台=[array objectAtIndex:selectIndex];
            }else if (Tag==1024){
                lowHouseListModel.露台空中花园=[array objectAtIndex:selectIndex];
            }else if (Tag==1025){
                lowHouseListModel.私家花园庭院=[array objectAtIndex:selectIndex];
            }else if (Tag==1026){
                lowHouseListModel.私家车位车库=[array objectAtIndex:selectIndex];
            }else if (Tag==1027){
                lowHouseListModel.私家泳池=[array objectAtIndex:selectIndex];
            }else if (Tag==1028){
                lowHouseListModel.中央空调=[array objectAtIndex:selectIndex];
            }else if (Tag==1029){
                lowHouseListModel.电梯=[array objectAtIndex:selectIndex];
            }
            [self Refresh:section];
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:0];
        if (section==22) {
            [self Cselect_init:lowHouseListModel.阁楼 SelectView:houseSelectView];
        }else if (section==23){
            [self Cselect_init:lowHouseListModel.挑高阳台面积 SelectView:houseSelectView];
        }else if (section==24){
            [self Cselect_init:lowHouseListModel.露台空中花园 SelectView:houseSelectView];
        }else if (section==25){
            [self Cselect_init:lowHouseListModel.私家花园庭院 SelectView:houseSelectView];
        }else if (section==26){
            [self Cselect_init:lowHouseListModel.私家车位车库 SelectView:houseSelectView];
        }else if (section==27){
            [self Cselect_init:lowHouseListModel.私家泳池 SelectView:houseSelectView];
        }else if (section==28){
            [self Cselect_init:lowHouseListModel.中央空调 SelectView:houseSelectView];
        }else if (section==29){
            [self Cselect_init:lowHouseListModel.电梯 SelectView:houseSelectView];
        }
        
        return houseSelectView;
    }else if (section==2||section==7||section==30||section==31||section==41){
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier2 ];
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        formInPutView.formTextField.keyboardType=UIKeyboardTypeDefault;
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"选填"];
        formInPutView.formTextField.text=@"";
        if (section==2) {
            if (lowHouseListModel.房屋编号) {
                formInPutView.formTextField.text=lowHouseListModel.房屋编号;
            }
        }else if (section==7) {
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (lowHouseListModel.实用面积) {
                formInPutView.formTextField.text=lowHouseListModel.实用面积;
            }
            
        }else if (section==30) {
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (lowHouseListModel.总赠送面积) {
                formInPutView.formTextField.text=lowHouseListModel.总赠送面积;
            }
            
        }else if (section==31&&lowHouseListModel.赠送其它){
            formInPutView.formTextField.text=lowHouseListModel.赠送其它;
        }else if (section==41&&lowHouseListModel.备注){
            formInPutView.formTextField.text=lowHouseListModel.备注;
        }
        return formInPutView;
    }else if (section>=32&&section<=37){
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier10];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier10 DataArray:array];
        }
        houseSelectView.tag=section+1000;
        houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            NSLog(@"%ld",Tag);
            if (Tag==1032) {
                lowHouseListModel.海景=[array objectAtIndex:selectIndex];
            }else if (Tag==1033){
                lowHouseListModel.河流湖泊=[array objectAtIndex:selectIndex];
            }else if (Tag==1034){
                lowHouseListModel.山景=[array objectAtIndex:selectIndex];
            }else if (Tag==1035){
                lowHouseListModel.人文景观=[array objectAtIndex:selectIndex];
            }else if (Tag==1036){
                lowHouseListModel.公园=[array objectAtIndex:selectIndex];
            }else if (Tag==1037){
                lowHouseListModel.高尔夫景观=[array objectAtIndex:selectIndex];
            }
            
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:2];
        if (section==32) {
            [self elect_init:lowHouseListModel.海景 SelectView:houseSelectView];
        }else if (section==33){
            [self elect_init:lowHouseListModel.河流湖泊 SelectView:houseSelectView];
        }else if (section==34){
            [self elect_init:lowHouseListModel.山景 SelectView:houseSelectView];
        }else if (section==35){
            [self elect_init:lowHouseListModel.人文景观 SelectView:houseSelectView];
        }else if (section==36){
            [self elect_init:lowHouseListModel.公园 SelectView:houseSelectView];
        }else if (section==37){
            [self elect_init:lowHouseListModel.高尔夫景观 SelectView:houseSelectView];
        }

        
        return houseSelectView;
    }else{
        //        图片
        PhotoView *lowSelectDateView=(PhotoView *)[self C_init:Identifier20 ];
        lowSelectDateView.tag=section+1000;
        NSArray *array=[_dropDownArray objectAtIndex:section];
        [lowSelectDateView _init:[key objectAtIndex:0]PhImage:nil];

        if (section==38&&lowHouseListModel.楼栋外观图) {
            [NetworkManager _initSdImage:[NetworkManager jiequStr:lowHouseListModel.楼栋外观图 rep:@","] ImageView:lowSelectDateView.phImageView];
        }else if (section==39&&lowHouseListModel.户型图){
            [NetworkManager _initSdImage:[NetworkManager jiequStr:lowHouseListModel.户型图 rep:@","] ImageView:lowSelectDateView.phImageView];
        }else if (section==40&&lowHouseListModel.景观图){
            [NetworkManager _initSdImage:[NetworkManager jiequStr:lowHouseListModel.景观图 rep:@","] ImageView:lowSelectDateView.phImageView];
        }
        lowSelectDateView.Clock=^(NSInteger ClockTag){
//            NSArray *array=[_dropDownArray objectAtIndex:ClockTag-1000];
            NSLog(@"%ld",ClockTag);
            NSString *str=[NetworkManager Datastrings:[[self.baseArray objectAtIndex:ClockTag-1000] allKeys]];
            NSLog(@"%@",str);
            POHViewController *pOHViewController=[[POHViewController alloc]initWithNibName:@"POHViewController" bundle:nil];
            if (ClockTag==1038) {
                NSMutableArray *PHarray=[NetworkManager address:lowHouseListModel.楼栋外观图];
                if (PHarray.count==0) {
                    PHarray = [NSMutableArray arrayWithCapacity:1];
                }
                pOHViewController.PHOarray=PHarray;
                pOHViewController.successfulIndex = PHarray.count;
            }else if (ClockTag==1039) {
                NSMutableArray *PHarray=[NetworkManager address:lowHouseListModel.户型图];
                if (PHarray.count==0) {
                    PHarray = [NSMutableArray arrayWithCapacity:1];
                }
                pOHViewController.PHOarray=PHarray;
                pOHViewController.successfulIndex = PHarray.count;
            }else if (ClockTag==1040) {
                NSMutableArray *PHarray=[NetworkManager address:lowHouseListModel.景观图];
                if (PHarray.count==0) {
                    PHarray = [NSMutableArray arrayWithCapacity:1];
                }
                pOHViewController.PHOarray=PHarray;
                pOHViewController.successfulIndex = PHarray.count;
            }
          
            [self.navigationController pushViewController:pOHViewController animated:YES];
            pOHViewController.ClockSave=^(NSArray *ArrayID,NSString *ImageUrl){
                if (ClockTag==1038) {
                    lowHouseListModel.楼栋外观图=ImageUrl;
                    [IDs addObject:ArrayID];
                }else if (ClockTag==1039) {
                    lowHouseListModel.户型图=ImageUrl;
                    [IDs addObject:ArrayID];
                }else if (ClockTag==1040) {
                    lowHouseListModel.景观图=ImageUrl;
                    [IDs addObject:ArrayID];
                }
                [tableView reloadData];
                
            };
            pOHViewController.imageType=str;
            pOHViewController.orderType=@"houseFangwu";
            pOHViewController.ID=lowHouseListModel.ID;
            pOHViewController.stakID=self.estateID;
            pOHViewController.selectMax=5;
        };
        return lowSelectDateView;
        
    }
}

-(void)select_init:(NSString *)title SelectView:(HouseSelectView *)selectView{
    if (!title) {
        title=@"好";
        }
        if ([title isEqualToString:@"好"]) {
            selectView.dVSwitch.selectedIndex=0;
        }else if([title isEqualToString:@"一般"]){
            selectView.dVSwitch.selectedIndex=1;
        }else if([title isEqualToString:@"差"]){
            selectView.dVSwitch.selectedIndex=2;
        }
        
    
}

-(void)Cselect_init:(NSString *)title SelectView:(HouseSelectView *)selectView{
    if (!title) {
        title=@"无";
        }
        if ([title isEqualToString:@"无"]) {
            selectView.dVSwitch.selectedIndex=0;
        }else if([title isEqualToString:@"有"]){
            selectView.dVSwitch.selectedIndex=1;
        }
}

-(void)elect_init:(NSString *)title SelectView:(HouseSelectView *)selectView{
    if (!title) {
        title=@"无";
    }
        if ([title isEqualToString:@"全部"]) {
            selectView.dVSwitch.selectedIndex=0;
        }else if([title isEqualToString:@"部分"]){
            selectView.dVSwitch.selectedIndex=1;
        }else if([title isEqualToString:@"无"]){
            selectView.dVSwitch.selectedIndex=2;
        }
        
    
}


-(void)Refresh:(NSInteger)section{
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    [self.baseTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(UITableViewHeaderFooterView *)C_init:(NSString *)mark{
    return [self.baseTableView dequeueReusableHeaderFooterViewWithIdentifier:mark];
    //    return [[[NSBundle mainBundle]loadNibNamed:xibName owner:self options:nil]lastObject];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (![self.selectSee isEqualToString:@"查看"]) {
        if (section==41) {
            return 44;
        }
    }
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (![self.selectSee isEqualToString:@"查看"]) {
        if (section==41) {
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

-(void)Refresh{//:(NSInteger)section{
    //    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    //    [self.baseTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%ld",textField.tag);
    if (textField.tag==1002) {
        lowHouseListModel.房屋编号=textField.text;
    }else if (textField.tag==1003) {
        lowHouseListModel.系统房号=textField.text;
    }else if (textField.tag==1004) {
        lowHouseListModel.现用房号=textField.text;
    }else if (textField.tag==1005) {
        lowHouseListModel.所在楼层=textField.text;
    }else if (textField.tag==1006) {
        lowHouseListModel.建筑面积=textField.text;
    }else if (textField.tag==1007) {
        lowHouseListModel.实用面积=textField.text;
    }else if (textField.tag==1008) {
        lowHouseListModel.物业管理费=textField.text;
    }else if (textField.tag==117) {
        lowHouseListModel.装修程度=textField.text;
    }else if (textField.tag==1021) {
        lowHouseListModel.价格=textField.text;
    }else if (textField.tag==1022) {
        lowHouseListModel.阁楼面积=textField.text;
    }else if (textField.tag==1023) {
        lowHouseListModel.挑高阳台面积=textField.text;
    }else if (textField.tag==1024) {
        lowHouseListModel.露台面积=textField.text;
    }else if (textField.tag==1025) {
        lowHouseListModel.私家花园面积=textField.text;
    }else if (textField.tag==1026) {
        lowHouseListModel.私家车位个数=textField.text;
    }else if (textField.tag==1027) {
        lowHouseListModel.私家泳池个数=textField.text;
    }else if (textField.tag==1028) {
        lowHouseListModel.中央空调个数=textField.text;
    }else if (textField.tag==1029) {
        lowHouseListModel.电梯个数=textField.text;
    }else if (textField.tag==1030) {
        lowHouseListModel.总赠送面积=textField.text;
    }else if (textField.tag==1031) {
        lowHouseListModel.赠送其它=textField.text;
    }else if (textField.tag==1041) {
        lowHouseListModel.备注=textField.text;
    }
    fistTextField = nil;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    Indext=textField.tag;
    NSLog(@"%ld",textField.tag);
    if (textField.tag==117) {
          _selectFormPickerView.trafficArray=[self.dropDownArray objectAtIndex:textField.tag-100];
    }
//
    return YES;
}

-(void)netSaveFormData{
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"保存中..."];
    typeof(self)SelfWeek=self;
    
    NSMutableDictionary *dictSave=[[NSMutableDictionary alloc]initWithDictionary:lowHouseListModel.toDictionary];
    if (self.estateID) {
        [dictSave setObject:self.estateID forKey:@"taskId"];
    }
    [dictSave setObject:@"houseFangwu" forKey:@"makeType"];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dictSave relativePath:@"appAction!saveMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        SaveModel *saveModel=[[SaveModel alloc]initWithDictionary:responseObject error:nil];
        if (saveModel) {
            if ([saveModel.status isEqualToString:@"1"]) {
                lowHouseListModel.ID=saveModel.ID;
                for (NSArray *numbers in IDs) {
                    for (NSNumber *number in numbers) {
                        [[NetworkManager shar]updata:[number longLongValue] FormID:saveModel.ID TackId:[super replaceString:self.estateID]];
                    }
                    
                }
                lowHouseListModel.ID = saveModel.ID;
                [BaseView _init:[super replaceString:saveModel.message] View:SelfWeek.view];
            }else{
                [BaseView _init:[super replaceString:saveModel.message] View:SelfWeek.view];
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
    lowHouseListModel.朝向=[NetworkManager Datastrings:[lowHouseOrientationModel.toDictionary allValues]];
    lowHouseListModel.户型结构=[NetworkManager Datastrings:[lowHouseStructureModel.toDictionary allValues]];
    if (!(lowHouseListModel.楼栋编号.length>0)) {
        [BaseView _init:@"请选择楼栋名称" View:self.view];
    }else if (!(lowHouseListModel.现用房号.length>0)){
        [BaseView _init:@"请输入现用房号" View:self.view];
    }else if (!(lowHouseListModel.所在楼层.length>0)){
        [BaseView _init:@"请输入所在楼层" View:self.view];
    }else if (!(lowHouseListModel.建筑面积.length>0)){
        [BaseView _init:@"请输入建筑面积" View:self.view];
    }else if (!(lowHouseListModel.物业管理费.length>0)){
        [BaseView _init:@"请输入物业管理费" View:self.view];
    }else if (!(lowHouseListModel.价格.length>0)){
        [BaseView _init:@"请输入价格" View:self.view];
    }else if (!(lowHouseListModel.楼栋外观图.length>0)){
        [BaseView _init:@"请选择楼栋外观图" View:self.view];
    }else if ([NetworkManager address:lowHouseListModel.楼栋外观图].count<2||[NetworkManager address:lowHouseListModel.楼栋外观图].count>6){
        [BaseView _init:@"楼栋外观图2-5张" View:self.view];
    }else if (!(lowHouseListModel.户型图.length>0)){
        [BaseView _init:@"请选择户型图" View:self.view];
    }else if ([NetworkManager address:lowHouseListModel.户型图].count<2||[NetworkManager address:lowHouseListModel.户型图].count>6){
        [BaseView _init:@"户型图2-5张" View:self.view];
    }else if (!(lowHouseListModel.景观图.length>0)){
        [BaseView _init:@"请选择景观图" View:self.view];
    }else if ([NetworkManager address:lowHouseListModel.景观图].count<2||[NetworkManager address:lowHouseListModel.景观图].count>6){
        [BaseView _init:@"景观图2-5张" View:self.view];
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
