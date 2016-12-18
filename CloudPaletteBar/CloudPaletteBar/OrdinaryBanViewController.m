//
//  OrdinaryBanViewController.m
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "OrdinaryBanViewController.h"
#import "CloudPaletteBar.h"
#import "NetworkManager.h"
#import "LowEstateCell.h"
#import "LowPropertyNameView.h"
#import "LowInvestigationView.h"
#import "FormInPutView.h"
#import "LowFootView.h"
#import "OfficeEstateAddressView.h"
#import "SystemModel.h"
#import "FormSelectTableView.h"
#import "MJRefresh.h"
#import "OBanModel.h"
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


@interface OrdinaryBanViewController ()<UITextFieldDelegate,UISearchBarDelegate>{
    UITextField *fistTextField;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    FormSelectTableView *formSelectTableView;
    NSMutableArray *addressArray1;
    OBanListModel *oBanListModel;
    NSInteger ViewTag;
    NSString *secarchName;
    UIView *formSelectView;
    NSInteger countInt;
}
@property(nonatomic,strong)NSMutableArray *lowArray;
@property(nonatomic,strong)NSMutableArray *dropDownArray;
@property(nonatomic,assign)BOOL openOrClose;
@property(nonatomic,assign)NSInteger noInvestigation;
@property (nonatomic ,strong)UISearchBar *searchBar;
@end

@implementation OrdinaryBanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _noInvestigation=8;
    _openOrClose=NO;
    self.baseTableView.frame=CGRectMake(0, 0, screen_width, screen_height-50-64);
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerHeat];
    self.lowArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OpenOrClose"]];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"LowEstateCell" bundle:nil] forCellReuseIdentifier:Identifier];
    //    LowEstate
    self.baseArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OQBan"]];
    self.dropDownArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"MaterialScience"]];
    
    formSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-150)];
    self.searchBar.frame = CGRectMake(0, 0, screen_width, 50.0);
    formSelectTableView=[[FormSelectTableView alloc]initWithFrame:CGRectMake(0, 50, screen_width, formSelectView.frame.size.height-50)];
    [formSelectView addSubview:formSelectTableView];
    
    __weak typeof(self)SelfWeak=self;
    [formSelectTableView _initOrderUP:^(int Page) {
        if (ViewTag==1000) {
            [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
        }else
        [SelfWeak netSysData2:Page andName:[super replaceString:secarchName]];
    } Down:^(int Page) {
        if (ViewTag==1000) {
            [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
        }else
            [SelfWeak netSysData2:Page andName:[super replaceString:secarchName]];
    }];
    [self netFormData];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OEloupan:) name:@"OEloupan" object:nil];
}


-(void)OEloupan:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"ID"]);
    NSLog(@"%@",text.userInfo[@"NAME"]);
    oBanListModel.楼盘编号=text.userInfo[@"ID"];
    oBanListModel.楼盘名称=text.userInfo[@"NAME"];
    [self.baseTableView reloadData];
}

-(void)registerHeat{
    [self registerHeat:@"LowPropertyNameView" Mark:Identifier1];
    [self registerHeat:@"LowInvestigationView" Mark:Identifier2];
    [self registerHeat:@"FormInPutView" Mark:Identifier3];
    [self registerHeat:@"OfficeEstateAddressView" Mark:Identifier4];
    [self registerHeat:@"LowFootView" Mark:Identifier7];
    [self registerHeat:@"LowInvestigationView" Mark:Identifier5];
    
    //    [self registerHeat:@"HouseSelectView" Mark:Identifier6];
    //    [self.baseTableView registerClass:[HouseSelectView class] forHeaderFooterViewReuseIdentifier:Identifier6];
}
//获取系统楼栋编号、系统楼栋名称
-(void)netSysData2:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"houseDBuding",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":[super replaceString:oBanListModel.楼盘名称],@"budingName":name}];
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
                    [ Arraykeys addObject:systemListModel.系统楼栋名称];
                    [ Arrayvalues addObject:systemListModel.楼栋编号];
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


//获取盘编号和楼盘名称
-(void)netSysData:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"houseDLoupan",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":name}];
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
                    [ Arraykeys addObject:systemListModel.实际楼盘名称];
                    [ Arrayvalues addObject:systemListModel.ID];
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
    if (countInt==1000) {
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
    if (countInt==1000) {
        [self netSysData:1 andName:secarchName];
    }else{
        [self netSysData2:1 andName:secarchName];
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
        OBanModel *oBanModel= [[OBanModel alloc]initWithDictionary:responseObject error:nil];
        if (oBanModel) {
            if ([oBanModel.status isEqualToString:@"1"]) {
                if (oBanModel.list.count>0) {
                    oBanListModel=[oBanModel.list objectAtIndex:0];
                    //                    //                    把字符串转成数组
                    addressArray1=[[NSMutableArray alloc]initWithArray:[NetworkManager address:oBanListModel.梯位户数比]];
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
    oBanListModel=[[OBanListModel alloc]init];

    addressArray1=[[NSMutableArray alloc]init];
}
//获取表单数据

-(void)netFormData{
    
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"houseDBuding"}];
    if (self.estateID) {
        if ([kUserDefaults objectForKey:@"ordinaryId" ]!=NULL) {
            [dic setObject:self.estateID forKey:@"taskId"];
//            if (self.selectIndex==1) {
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
//            if (self.selectIndex==1) {
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
    return _noInvestigation;
    
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
    [cell _cellInit:[value objectAtIndex:indexPath.row] Weather:@"必填"];
    cell.cellTextField.delegate=self;
    cell.cellTextField.tag=indexPath.row+indexPath.section+10000;
    cell.cellTextField.text=@"";
    if (indexPath.section==4||oBanListModel.无法调查说明) {
        [cell _cellInit:[value objectAtIndex:indexPath.row] Weather:@"必填"];
        cell.cellTextField.text=oBanListModel.无法调查说明;
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (!self.estateID) {
        if (section==4) {
            return 0;
        }else
            return 44;
    }
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary *dic=[self.baseArray objectAtIndex:section];
    NSArray *key=[dic allKeys];
    if (section>=0&&section<=2){
        LowPropertyNameView *lowPropertyNameView=(LowPropertyNameView *)[self C_init:Identifier1 ];
        lowPropertyNameView.tag=1000+section;
        [lowPropertyNameView _init:[key objectAtIndex:0] Weather:@"自动设置"];
        if (section==1) {
            lowPropertyNameView.selectButton.hidden=YES;
        }else
            lowPropertyNameView.selectButton.hidden=NO;
        lowPropertyNameView.ClockLow=^(NSInteger Tag){
            if (Tag) {
                ViewTag=Tag;
                countInt = ViewTag;
                NSLog(@"%ld",Tag);
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
            if (formSelectTableView.TagT==1000) {
                oBanListModel.楼盘名称=selectStr;
                oBanListModel.楼盘编号=[Arrayvalues objectAtIndex:Index];
            }else{
                oBanListModel.楼栋编号=[Arrayvalues objectAtIndex:Index];
                oBanListModel.系统楼栋名称=selectStr;
            }
            [self.baseTableView reloadData];
        };

        lowPropertyNameView.titleTextField.text=@"";
        if (section==0&&oBanListModel.楼盘名称){
            lowPropertyNameView.titleTextField.text=oBanListModel.楼盘名称;
        }else if (section==1&&oBanListModel.楼栋编号){
            lowPropertyNameView.titleTextField.text=oBanListModel.楼栋编号;
        }else if (section==2&&oBanListModel.系统楼栋名称){
            lowPropertyNameView.titleTextField.text=oBanListModel.系统楼栋名称;
        }

        return lowPropertyNameView;
    }else if (section==4){
        LowInvestigationView *lowInvestigationView=(LowInvestigationView *)[self C_init:Identifier2 ];
        lowInvestigationView.Clock=^(BOOL open){
            _openOrClose=open;
            if (open) {
                _noInvestigation=5;
                [_lowArray replaceObjectAtIndex:section withObject:@"yes"];
            }else{
                _noInvestigation=8;
                [_lowArray replaceObjectAtIndex:section withObject:@"no"];
            }
            
            [self Refresh];
        };
        [lowInvestigationView _init:[key objectAtIndex:0] OpenClose:_openOrClose];
        
        return lowInvestigationView;
        
    }
    else if ((section>=7&&section<=8)) {
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier3 ];
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        [formInPutView _init:[key objectAtIndex:0]
                   WaterMark:@"选填"];
        formInPutView.formTextField.keyboardType=UIKeyboardTypeDefault;
        formInPutView.formTextField.text=@"";
          if (section==7){
              formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
              if (oBanListModel.每层价格相差) {
                  formInPutView.formTextField.text=oBanListModel.每层价格相差;
              }
            
        }else if (section==8&&oBanListModel.备注){
            formInPutView.formTextField.text=oBanListModel.备注;
        }
        return formInPutView;
    }else if (section==5){
        OfficeEstateAddressView *officeEstateAddressView=[tableView dequeueReusableHeaderFooterViewWithIdentifier:Identifier4];//(OfficeEstateAddressView *)[self C_init:@"OfficeEstateAddressView"];
        officeEstateAddressView.addressTextField.tag=10000+section;
        officeEstateAddressView.addressTextField.delegate=self;
        officeEstateAddressView.areaTextField.tag=100+section;
        officeEstateAddressView.areaTextField.delegate=self;
        officeEstateAddressView.roundTextField.tag=10+section;
        officeEstateAddressView.roundTextField.delegate=self;
        [officeEstateAddressView _init:[key objectAtIndex:0] WeatherMarkAddress:@"必填" AreaTitle:@"单元" WeatherMarkArea:@"必填" RoundTitle:@"梯" WeatherMarkRound:@"必填" EndTiele:@"户"];
        officeEstateAddressView.addressTextField.text=@"";
        officeEstateAddressView.areaTextField.text=@"";
        officeEstateAddressView.roundTextField.text=@"";
        officeEstateAddressView.addressTextField.keyboardType=UIKeyboardTypeNumberPad;
        officeEstateAddressView.areaTextField.keyboardType=UIKeyboardTypeNumberPad;
        officeEstateAddressView.roundTextField.keyboardType=UIKeyboardTypeNumberPad;
        
        if (addressArray1.count>1) {
            //                //                    从数组去除对应的值付给空件
            officeEstateAddressView.addressTextField.text=[addressArray1 objectAtIndex:0];
            officeEstateAddressView.areaTextField.text=[addressArray1 objectAtIndex:1];
            officeEstateAddressView.roundTextField.text=[addressArray1 objectAtIndex:2];
        }

        return officeEstateAddressView;
    } else{
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier3 ];
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"必填"];
        formInPutView.formTextField.keyboardType=UIKeyboardTypeDefault;
        formInPutView.formTextField.text=@"";
        if (section==3&&oBanListModel.实际楼栋名称){
            formInPutView.formTextField.text=oBanListModel.实际楼栋名称;
        }else if (section==6){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (oBanListModel.楼层差价) {
                formInPutView.formTextField.text=oBanListModel.楼层差价;
            }
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
    if (self.estateID) {
        if (![self.selectSee isEqualToString:@"查看"]) {
            if (_noInvestigation==5) {
                if (section==4) {
                    return 44;
                }
            }else{
                if (section==7) {
                    return 44;
                }
            }
        }

    }else{
        if (![self.selectSee isEqualToString:@"查看"]) {
            if (_noInvestigation==5) {
                if (section==4) {
                    return 44;
                }
            }else{
                if (section==7) {
                    return 44;
                }
            }
        }

    }
    
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (![self.selectSee isEqualToString:@"查看"]) {
        if (_noInvestigation==5) {
            if (section==4) {
                LowFootView *lowFootView=(LowFootView *)[self C_init:Identifier7];
                lowFootView.SaveClock=^(){
                    [self required];
                };
                return lowFootView;
            }
        }else{
            if (section==7) {
                LowFootView *lowFootView=(LowFootView *)[self C_init:Identifier7];
                lowFootView.SaveClock=^(){
                    [self required];
                };
                return lowFootView;
            }
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
        oBanListModel.系统楼栋名称=textField.text;
    }else if (textField.tag==1003){
        oBanListModel.实际楼栋名称=textField.text;
    }else if (textField.tag==10005){
        [self repn:textField.text Index:0 Datas:addressArray1];
    }else if (textField.tag==105){
        [self repn:textField.text Index:1 Datas:addressArray1];
    }else if (textField.tag==15){
        [self repn:textField.text Index:2 Datas:addressArray1];
    }else if (textField.tag==1006){
        oBanListModel.楼层差价=textField.text;
    }else if (textField.tag==1007){
        oBanListModel.每层价格相差=textField.text;
    }else if (textField.tag == 10004){
        oBanListModel.无法调查说明 = textField.text;
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

-(void)netSaveFormData{
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"保存中..."];
    typeof(self)SelfWeek=self;

    NSMutableDictionary *dictSave=[[NSMutableDictionary alloc]initWithDictionary:oBanListModel.toDictionary];
    if (self.estateID) {
        [dictSave setObject:self.estateID forKey:@"taskId"];
    }
    [dictSave setObject:@"houseDBuding" forKey:@"makeType"];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dictSave relativePath:@"appAction!saveMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        SaveModel *saveModel=[[SaveModel alloc]initWithDictionary:responseObject error:nil];
        if (saveModel) {
            if ([saveModel.status isEqualToString:@"1"]) {
                oBanListModel.ID = saveModel.ID;
                [BaseView _init:saveModel.message View:SelfWeek.view];
                if (![self.selectSee isEqualToString:@"编辑"]) {
                    [SelfWeek postValues:@{@"ID":oBanListModel.楼栋编号,@"NAME":oBanListModel.实际楼栋名称,@"楼盘名称":oBanListModel.楼盘名称}];
                    
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
    NSNotification *notification =[NSNotification notificationWithName:@"OEloudong" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

//判断必填项
-(void)required{
    //    把位置信息转成字符串付给对象属性
    __block int count1 = 0;
    oBanListModel.梯位户数比=[NetworkManager Datastrings:addressArray1];
    [addressArray1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        count1 ++ ;
        if ([obj isEqual:@""]) {
            count1--;
        }
    }];

    if (_noInvestigation==5){
        NSString *str = [super replaceString:oBanListModel.无法调查说明];
        if (!(oBanListModel.楼盘编号.length>0)) {
            [BaseView _init:@"请选择楼盘" View:self.view];
        }else if (!(oBanListModel.楼栋编号.length>0)){
            [BaseView _init:@"请选择楼栋名称" View:self.view];
        }else if (!(oBanListModel.实际楼栋名称.length>0)){
            [BaseView _init:@"请输入实际楼栋名称" View:self.view];
        }else if ([str isEqualToString:@""]){
            [BaseView _init:@"请输入无法调查说明" View:self.view];
        }else{
            [self netSaveFormData];
        }
    }else{
        if (!(oBanListModel.楼盘编号.length>0)) {
            [BaseView _init:@"请选择楼盘" View:self.view];
        }else if (!(oBanListModel.楼栋编号.length>0)){
            [BaseView _init:@"请选择楼栋名称" View:self.view];
        }else if (!(oBanListModel.实际楼栋名称.length>0)){
            [BaseView _init:@"请输入实际楼栋名称" View:self.view];
        }else if (count1 != 3){
            [BaseView _init:@"请输入完整的梯位户数量" View:self.view];
        }else if (!(oBanListModel.楼层差价.length>0)){
            [BaseView _init:@"请输入楼层差价" View:self.view];
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
