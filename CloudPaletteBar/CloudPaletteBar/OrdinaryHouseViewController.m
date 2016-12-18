//
//  OrdinaryHouseViewController.m
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "OrdinaryHouseViewController.h"
#import "CloudPaletteBar.h"
#import "NetworkManager.h"
#import "LowEstateCell.h"
#import "FormInPutView.h"
#import "LowPropertyNameView.h"
#import "LowHouseSwitchView.h"
#import "HouseSelectView.h"
#import "LowFootView.h"
#import "SystemModel.h"
#import "FormSelectTableView.h"
#import "MJRefresh.h"
#import "OHouseModel.h"
#import "SaveModel.h"

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

@interface OrdinaryHouseViewController ()<UITextFieldDelegate,UISearchBarDelegate>{
    UITextField *fistTextField;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    FormSelectTableView *formSelectTableView;
    OHouseListModel *oHouseListModel;
    //朝向
    OHouseOModel *oHouseOModel;
    //户型
    OHouseAModel *oHouseAModel;
    
    NSString *putongLouPan;
    NSString *secarchName;
    UIView *formSelectView;
}
@property(nonatomic,strong)NSMutableArray *lowArray;
@property(nonatomic,strong)NSMutableArray *dropDownArray;
@property (nonatomic ,strong)UISearchBar *searchBar;
@end

@implementation OrdinaryHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseTableView.frame=CGRectMake(0, 0, screen_width, screen_height-50-64);
    [self registerHeat];
    self.lowArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OpenOrClose"]];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"LowEstateCell" bundle:nil] forCellReuseIdentifier:Identifier];
    //    LowEstate
    self.baseArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OQHouse"]];
    self.dropDownArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OQHouseSelect"]];
    
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
    [self netFormData];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OEloudong:) name:@"OEloudong" object:nil];
}


-(void)OEloudong:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"ID"]);
    NSLog(@"%@",text.userInfo[@"NAME"]);
    oHouseListModel.楼栋编号=text.userInfo[@"ID"];
    oHouseListModel.楼栋名称=text.userInfo[@"NAME"];
    putongLouPan =text.userInfo[@"楼盘名称"];
    [self.baseTableView reloadData];
}

-(void)registerHeat{
    [self registerHeat:@"FormInPutView" Mark:Identifier1];
    [self registerHeat:@"LowPropertyNameView" Mark:Identifier2];
    [self registerHeat:@"LowHouseSwitchView" Mark:Identifier3];
    [self registerHeat:@"OfficeEstateAddressView" Mark:Identifier4];

    [self registerHeat:@"LowFootView" Mark:Identifier7];
    
    //    [self registerHeat:@"HouseSelectView" Mark:Identifier6];
    //    [self.baseTableView registerClass:[HouseSelectView class] forHeaderFooterViewReuseIdentifier:Identifier6];
}

//获取系统楼盘编号和系统楼盘名称
-(void)netSysData:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"houseDBuding",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":[super replaceString:putongLouPan],@"budingName":name}];
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
//                if (formSelectTableView.TagT==1004) {
                    formSelectTableView.formSelectArray=Arraykeys;
//                }else{
//                    formSelectTableView.formSelectArray=Arraykeys;
//                }
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

-(void)netWork:(NSDictionary *)dic{
    typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressOneHUD:self.view Title:@"获取中..."];
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        OHouseModel *oHouseModel = [[OHouseModel alloc]initWithDictionary:responseObject error:nil];
        if (oHouseModel) {
            if ([oHouseModel.status isEqualToString:@"1"]) {
                if (oHouseModel.list.count>0) {
                    oHouseListModel=[oHouseModel.list objectAtIndex:0];
                    oHouseOModel=[[OHouseOModel alloc]initWithDictionary:[NetworkManager stringDictionary:oHouseListModel.朝向] error:nil];
                    oHouseAModel=[[OHouseAModel alloc]initWithDictionary:[NetworkManager stringDictionary:oHouseListModel.户型] error:nil];
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
    oHouseListModel=[[OHouseListModel alloc]init];
    oHouseOModel=[[OHouseOModel alloc]init];
    oHouseAModel=[[OHouseAModel alloc]init];
}

//获取表单数据

-(void)netFormData{
    
   
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"houseDFangwu"}];
    if (self.estateID) {
        if ([kUserDefaults objectForKey:@"ordinaryId" ]!=NULL) {
            [dic setObject:self.estateID forKey:@"taskId"];
//            if (self.selectIndex==2) {
                [dic setObject:[super replaceString:[kUserDefaults objectForKey:@"ordinaryId" ]] forKey:@"ID"];
//            }else{
//                [dic setObject:@"0" forKey:@"ID"];
//            }
            [self Init_o];
            [self netWork:dic];
        }else{
            [self Init_o];
        }
    }else{
        if ([kUserDefaults objectForKey:@"ordinaryId" ]!=NULL) {
//            if (self.selectIndex==2) {
                [dic setObject:[super replaceString:[kUserDefaults objectForKey:@"ordinaryId" ]] forKey:@"ID"];
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
    if (section==5||section==9) {
        return 65;
    }
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary *dic=[self.baseArray objectAtIndex:section];
    NSArray *key=[dic allKeys];
    if (section==4||(section>=14&&section<=18)) {
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier1 ];
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"选填"];
        formInPutView.formTextField.keyboardType=UIKeyboardTypeDefault;
        formInPutView.formTextField.text=@"";
        if (section==4&&oHouseListModel.房屋结构){
            formInPutView.formTextField.text=oHouseListModel.房屋结构;
        }else if (section==14&&oHouseListModel.景观){
            formInPutView.formTextField.text=oHouseListModel.景观;
        }else if (section==15&&oHouseListModel.赠送空间){
            formInPutView.formTextField.text=oHouseListModel.赠送空间;
        }else if (section==16){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (oHouseListModel.赠送面积) {
                formInPutView.formTextField.text=oHouseListModel.赠送面积;
            }
            
        }else if (section==17){
             formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (oHouseListModel.价格水平) {
                formInPutView.formTextField.text=oHouseListModel.价格水平;
            }
            
        }else if (section==18&&oHouseListModel.备注){
            formInPutView.formTextField.text=oHouseListModel.备注;
        }
        return formInPutView;
    }else if (section==0||section==1){
        LowPropertyNameView *lowPropertyNameView=(LowPropertyNameView *)[self C_init:Identifier2 ];
        lowPropertyNameView.tag=1000+section;
        [lowPropertyNameView _init:[key objectAtIndex:0] Weather:@"自动设置"];
        lowPropertyNameView.ClockLow=^(NSInteger Tag){
            if (Tag) {
               
                formSelectTableView.formSelectArray=nil;
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
            oHouseListModel.楼栋名称=selectStr;
            oHouseListModel.楼栋编号=[Arrayvalues objectAtIndex:Index];
            [self.baseTableView reloadData];
        };

        if (section==0) {
            lowPropertyNameView.selectButton.hidden=YES;
        }else
            lowPropertyNameView.selectButton.hidden=NO;
        lowPropertyNameView.titleTextField.text=@"";
        if (section==0&&oHouseListModel.楼栋名称){
            lowPropertyNameView.titleTextField.text=oHouseListModel.楼栋名称;
        }else if (section==1&&oHouseListModel.楼栋编号){
            lowPropertyNameView.titleTextField.text=oHouseListModel.楼栋编号;
        }
        

        return lowPropertyNameView;
    }else if (section>=5&&section<=11){
        LowHouseSwitchView *lowSelectDateView=(LowHouseSwitchView *)[self C_init:Identifier3 ];
        lowSelectDateView.tag=section+1000;
        NSString *keyStr=[key objectAtIndex:0];
        [lowSelectDateView _init:[NetworkManager interceptStrTo:keyStr PleStr:@"+"] Title1:[NetworkManager interceptStrFrom:keyStr PleStr:@"+"] TitleSwitch:NO TitleSwitch1:NO];
        lowSelectDateView.Clock=^(NSInteger indexSwitch,BOOL open){
            NSLog(@"%d",indexSwitch);
            if (open) {
                if (indexSwitch==1006) {
                    oHouseOModel.南=@"南";
                }else if (indexSwitch==1105){
                    oHouseOModel.东=@"东";
                }else if (indexSwitch==1007){
                    oHouseOModel.西=@"西";
                }else if (indexSwitch==1106){
                    oHouseOModel.北=@"北";
                }else if (indexSwitch==1008){
                    oHouseOModel.东南=@"东南";
                }else if (indexSwitch==1107){
                    oHouseOModel.东北=@"东北";
                }else if (indexSwitch==1009){
                    oHouseOModel.西南=@"西南";
                }else if (indexSwitch==1108){
                    oHouseOModel.西北=@"西北";
                }else if (indexSwitch==1010){
                    oHouseAModel.房=@"房";
                }else if (indexSwitch==1109){
                    oHouseAModel.厅=@"厅";
                }else if (indexSwitch==1011){
                    oHouseAModel.厨卫=@"厨卫";
                }else if (indexSwitch==1110){
                    oHouseAModel.阳台=@"阳台";
                }else if (indexSwitch==1012){
                    oHouseAModel.花园=@"花园";
                }
            }else{
                if (indexSwitch==1006) {
                    oHouseOModel.南=@"";
                }else if (indexSwitch==1105){
                    oHouseOModel.东=@"";
                }else if (indexSwitch==1007){
                    oHouseOModel.西=@"";
                }else if (indexSwitch==1106){
                    oHouseOModel.北=@"";
                }else if (indexSwitch==1008){
                    oHouseOModel.东南=@"";
                }else if (indexSwitch==1107){
                    oHouseOModel.东北=@"";
                }else if (indexSwitch==1009){
                    oHouseOModel.西南=@"";
                }else if (indexSwitch==1108){
                    oHouseOModel.西北=@"";
                }else if (indexSwitch==1010){
                    oHouseAModel.房=@"";
                }else if (indexSwitch==1109){
                    oHouseAModel.厅=@"";
                }else if (indexSwitch==1011){
                    oHouseAModel.厨卫=@"";
                }else if (indexSwitch==1110){
                    oHouseAModel.阳台=@"";
                }else if (indexSwitch==1012){
                    oHouseAModel.花园=@"";
                }
            }
        };
        lowSelectDateView.titleSwitch.on=NO;
        lowSelectDateView.titleSwitch1.on=NO;
        lowSelectDateView.cellTitleLable.text=nil;
        if (section==5) {
            lowSelectDateView.cellTitleLable.text=@"朝向";
            if ([oHouseOModel.南 isEqualToString:@"南"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oHouseOModel.东 isEqualToString:@"东"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==6){
            if ([oHouseOModel.西 isEqualToString:@"西"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oHouseOModel.北 isEqualToString:@"北"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==7){
            if ([oHouseOModel.东南 isEqualToString:@"东南"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oHouseOModel.东北 isEqualToString:@"东北"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==8){
            if ([oHouseOModel.西南 isEqualToString:@"西南"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oHouseOModel.西北 isEqualToString:@"西北"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==9){
             lowSelectDateView.cellTitleLable.text=@"户型";
            if ([oHouseAModel.房 isEqualToString:@"房"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oHouseAModel.厅 isEqualToString:@"厅"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==10){
            if ([oHouseAModel.厨卫 isEqualToString:@"厨卫"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            if ([oHouseAModel.阳台 isEqualToString:@"阳台"]) {
                lowSelectDateView.titleSwitch1.on=YES;
            }
        }else if (section==11){
            if ([oHouseAModel.花园 isEqualToString:@"花园"]) {
                lowSelectDateView.titleSwitch.on=YES;
            }
            
        }
        return lowSelectDateView;
    }else if(section==12){
        
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier6];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier6 DataArray:array];
        }
        houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            NSLog(@"%d",Tag);
             oHouseListModel.采光面=[array objectAtIndex:selectIndex];
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:NO];
        if (section==12) {
            if([oHouseListModel.采光面 isEqualToString:@"一般"]){
                houseSelectView.dVSwitch.selectedIndex=1;
            }else if([oHouseListModel.采光面 isEqualToString:@"差"]){
                houseSelectView.dVSwitch.selectedIndex=2;
            }else{
                houseSelectView.dVSwitch.selectedIndex=0;
                oHouseListModel.采光面=@"好";
            }
        }
        return houseSelectView;
    }else if(section==13){
        
        HouseSelectView *houseSelectView=(HouseSelectView *)[self C_init:Identifier8];
        NSArray *array=[self.dropDownArray objectAtIndex:section];
        if (houseSelectView==nil) {
            
            houseSelectView=[[HouseSelectView alloc]initWithReuseIdentifier:Identifier8 DataArray:array];
        }
        houseSelectView.ClockSelect=^(NSInteger selectIndex,NSInteger Tag){
            NSLog(@"%d",Tag);
            oHouseListModel.噪音=[array objectAtIndex:selectIndex];
        };
        
        [houseSelectView _init:[key objectAtIndex:0] SelectIndex:2];
        if (section==12) {
            if ([oHouseListModel.噪音 isEqualToString:@"大"]) {
                houseSelectView.dVSwitch.selectedIndex=0;
            }else if([oHouseListModel.噪音 isEqualToString:@"小"]){
                houseSelectView.dVSwitch.selectedIndex=1;
            }else if([oHouseListModel.噪音 isEqualToString:@"无"]){
                houseSelectView.dVSwitch.selectedIndex=2;
            }
        }
        return houseSelectView;
    } else
    {
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier1 ];
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"必填"];
        formInPutView.formTextField.text=@"";
        if (section==3&&oHouseListModel.楼层范围){
            formInPutView.formTextField.text=oHouseListModel.楼层范围;
        }else if (section==2) {
            formInPutView.formTextField.text=oHouseListModel.现用房号;
        }
        return formInPutView;
    }
    return nil;
}



-(UITableViewHeaderFooterView *)C_init:(NSString *)mark{
    return [self.baseTableView dequeueReusableHeaderFooterViewWithIdentifier:mark];
    //    return [[[NSBundle mainBundle]loadNibNamed:xibName owner:self options:nil]lastObject];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (![self.selectSee isEqualToString:@"查看"]) {
        if (section==18) {
            return 44;
        }
    }
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (![self.selectSee isEqualToString:@"查看"]) {
        if (section==18) {
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
    NSLog(@"%d",textField.tag);
    if (textField.tag==1002) {
        oHouseListModel.现用房号=textField.text;
    }else if (textField.tag==1003){
        oHouseListModel.楼层范围=textField.text;
    }else if (textField.tag==1004){
        oHouseListModel.房屋结构=textField.text;
    }else if (textField.tag==1014){
        oHouseListModel.景观=textField.text;
    }else if (textField.tag==1015){
        oHouseListModel.赠送空间=textField.text;
    }else if (textField.tag==1016){
        oHouseListModel.赠送面积=textField.text;
    }else if (textField.tag==1017){
        oHouseListModel.价格水平=textField.text;
    }else if (textField.tag==1018){
        oHouseListModel.备注=textField.text;
    }
    fistTextField = nil;
}

-(void)netSaveFormData{
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"保存中..."];
    typeof(self)SelfWeek=self;
    
    NSMutableDictionary *dictSave=[[NSMutableDictionary alloc]initWithDictionary:oHouseListModel.toDictionary];
    if (self.estateID) {
        [dictSave setObject:self.estateID forKey:@"taskId"];
    }
    [dictSave setObject:@"houseDFangwu" forKey:@"makeType"];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dictSave relativePath:@"appAction!saveMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        SaveModel *saveModel=[[SaveModel alloc]initWithDictionary:responseObject error:nil];
        if (saveModel) {
            if ([saveModel.status isEqualToString:@"1"]) {
                oHouseListModel.ID=saveModel.ID;
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
    oHouseListModel.朝向=[NetworkManager Datastrings:[oHouseOModel.toDictionary allValues]];
    oHouseListModel.户型=[NetworkManager Datastrings:[oHouseAModel.toDictionary allValues]];
    if (!(oHouseListModel.楼栋编号.length>0)) {
        [BaseView _init:@"请选择楼栋名称" View:self.view];
    }else if (!(oHouseListModel.现用房号.length>0)){
        [BaseView _init:@"请输入现用房号" View:self.view];
    }else if (!(oHouseListModel.楼层范围.length>0)){
        [BaseView _init:@"请输入楼层范围" View:self.view];
    }else if (!(oHouseListModel.朝向.length>0)){
        [BaseView _init:@"请选择朝向" View:self.view];
    }else if (!(oHouseListModel.户型.length>0)){
        [BaseView _init:@"请选择户型" View:self.view];
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
