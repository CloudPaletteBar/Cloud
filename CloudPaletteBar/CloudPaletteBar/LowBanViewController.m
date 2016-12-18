//
//  LowBanViewController.m
//  CloudPaletteBar
//
//  Created by test on 16/8/24.
//  Copyright © 2016年 test. All rights reserved.
//

#import "LowBanViewController.h"
#import "CloudPaletteBar.h"
#import "NetworkManager.h"
#import "LowEstateCell.h"
#import "LowPropertyNameView.h"
#import "FormInPutView.h"
#import "LowSelectDateView.h"
#import "LowPackView.h"
#import "LowFootView.h"
#import "LowInvestigationView.h"
#import "CalendarView.h"
#import "SelectFormPickerView.h"
#import "SystemModel.h"
#import "FormSelectTableView.h"
#import "MJRefresh.h"
#import "LowBanModel.h"
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

@interface LowBanViewController ()<UITextFieldDelegate,UISearchBarDelegate>{
    UITextField *fistTextField;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    FormSelectTableView *formSelectTableView;
    LowBanListModel *lowBanListModel;
    NSInteger Indext;
    NSInteger ViewTag;
    NSMutableArray *timeArray;
    
    BOOL yesNo;
    NSString *secarchName;
    UIView *formSelectView;
}
@property(nonatomic,strong)CalendarView *calendarView;
@property(nonatomic,strong)NSMutableArray *lowArray;
@property(nonatomic,strong)NSMutableArray *dropDownArray;
@property(nonatomic,assign)BOOL openOrClose;
@property(nonatomic,assign)CGFloat noInvestigation;
@property(nonatomic,strong)SelectFormPickerView *selectFormPickerView;
@property (nonatomic ,strong)UISearchBar *searchBar;
@end

@implementation LowBanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.estateID);
    _noInvestigation=13;
    _openOrClose=NO;
    yesNo = NO;
    self.baseTableView.frame=CGRectMake(0, 0, screen_width, screen_height-50-64);
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerHeat];
    self.lowArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OpenOrClose"]];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"LowEstateCell" bundle:nil] forCellReuseIdentifier:Identifier];
    //    LowEstate
    self.baseArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"LowBan"]];
    self.dropDownArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"LowBanP"]];
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
        if (ViewTag==1002) {
            [SelfWeak netSysData2:Page andName:[super replaceString:secarchName]];
        }else{
            [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
        }
        
    } Down:^(int Page) {
        if (ViewTag==1002) {
            [SelfWeak netSysData2:Page andName:[super replaceString:secarchName]];
        }else{
            [SelfWeak netSysData:Page andName:[super replaceString:secarchName]];
        }
    }];
    [self netFormData];
    [self registerForKeyboardNotifications];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lowloupan:) name:@"lowloupan" object:nil];
}


-(void)lowloupan:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"ID"]);
    NSLog(@"%@",text.userInfo[@"NAME"]);
    lowBanListModel.楼盘ID=text.userInfo[@"ID"];
    lowBanListModel.楼盘名称=text.userInfo[@"NAME"];
    [self.baseTableView reloadData];
}

-(void)registerHeat{
    [self registerHeat:@"LowPropertyNameView" Mark:Identifier1];
    [self registerHeat:@"LowSelectDateView" Mark:Identifier2];
    [self registerHeat:@"FormInPutView" Mark:Identifier3];
    [self registerHeat:@"LowPackView" Mark:Identifier4];
    [self registerHeat:@"LowFootView" Mark:Identifier7];
    [self registerHeat:@"LowInvestigationView" Mark:Identifier5];
    
    //    [self registerHeat:@"HouseSelectView" Mark:Identifier6];
    //    [self.baseTableView registerClass:[HouseSelectView class] forHeaderFooterViewReuseIdentifier:Identifier6];
}
//获取系统楼栋编号和系统楼栋名称
-(void)netSysData2:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"houseBuding",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":[super replaceString:lowBanListModel.楼盘名称],@"budingName":name}];
    if (self.estateID) {
        [dic setObject:self.estateID forKey:@"taskId"];
    }
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dic relativePath:@"appSelect!getBuding.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        Arraykeys=[[NSMutableArray alloc]init];
        Arrayvalues=[[NSMutableArray alloc]init];
        timeArray=[[NSMutableArray alloc]init];
        [SelfWeek tableviewEnd];
        SystemModel *systemModel = [[SystemModel alloc]initWithDictionary:responseObject error:nil];
        if (systemModel) {
            if ([systemModel.status isEqualToString:@"1"]) {
                for (SystemListModel *systemListModel in systemModel.list) {
                    [ Arraykeys addObject:systemListModel.系统楼栋名称];
                    [ Arrayvalues addObject:systemListModel.楼栋编号];
                    [timeArray addObject:systemListModel.CONST_ENDDATE];
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
//获取楼盘编号和楼盘名称
-(void)netSysData:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"houseXiaoqu",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":name}];
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
//                    formSelectTableView.formSelectArray=Arrayvalues;
//                }else{
//                    formSelectTableView.formSelectArray=Arraykeys;
//                }
                                        formSelectTableView.formSelectArray=Arraykeys;
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
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
    if (ViewTag==1002) {
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
    if (ViewTag==1002) {
        [self netSysData2:1 andName:secarchName];
    }else{
        [self netSysData:1 andName:secarchName];
    }
}

-(void)tableviewEnd{
    [formSelectTableView.mj_header endRefreshing];
    [formSelectTableView.mj_footer endRefreshing];
}

-(void)Init_O{
    lowBanListModel=[[LowBanListModel alloc]init];
}
//获取表单数据

-(void)netFormData{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"houseBuding"}];
    if (self.estateID) {
        if ([kUserDefaults objectForKey:@"lowDensityId" ]!=NULL) {
            [dic setObject:self.estateID forKey:@"taskId"];
//            if (self.selectIndex==1) {
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
//            if (self.selectIndex==1) {
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
        LowBanModel *lowBanModel = [[LowBanModel alloc]initWithDictionary:responseObject error:nil];
        if (lowBanModel) {
            if ([lowBanModel.status isEqualToString:@"1"]) {
                if (lowBanModel.list.count>0) {
                    lowBanListModel=[lowBanModel.list objectAtIndex:0];
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
    [cell _cellInit:[value objectAtIndex:indexPath.row] Weather:@"选填"];
    cell.cellTextField.delegate=self;
    cell.cellTextField.tag=indexPath.row+indexPath.section+10000;
    cell.cellTextField.text=@"";
    if (indexPath.section==4||lowBanListModel.无法调查说明) {
        [cell _cellInit:[value objectAtIndex:indexPath.row] Weather:@"必填"];
        cell.cellTextField.text=lowBanListModel.无法调查说明;
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
    __weak typeof(self)selfWeek=self;
    NSDictionary *dic=[self.baseArray objectAtIndex:section];
    NSArray *key=[dic allKeys];
     if (section>=0&&section<=2){
        LowPropertyNameView *lowPropertyNameView=(LowPropertyNameView *)[self C_init:Identifier1 ];
         lowPropertyNameView.tag=1000+section;
         [lowPropertyNameView _init:[key objectAtIndex:0] Weather:@"自动设置"];
         lowPropertyNameView.ClockLow=^(NSInteger Tag){
             if (Tag) {

                 ViewTag=Tag;
                 formSelectTableView.formSelectArray=nil;
                 [formSelectTableView.mj_header beginRefreshing];
//                 if (Tag==1001) {
//                     
//                     formSelectTableView.formSelectArray=Arrayvalues;
//                 }else{
//                     formSelectTableView.formSelectArray=Arraykeys;
//                 }
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
                 lowBanListModel.系统楼栋名称=selectStr;
                 lowBanListModel.楼栋编号=[Arrayvalues objectAtIndex:Index];
                 lowBanListModel.竣工年代=[NetworkManager interceptStrTo:[timeArray objectAtIndex:Index] PleStr:@" "];
             }else{
                 lowBanListModel.楼盘名称=selectStr;
                 lowBanListModel.楼盘ID=[Arrayvalues objectAtIndex:Index];
             }
             [self.baseTableView reloadData];
         };
         lowPropertyNameView.titleTextField.text=@"";
        
         if (section==0||section==2) {
             lowPropertyNameView.selectButton.hidden=NO;
         }else{
             lowPropertyNameView.selectButton.hidden=YES;
         }
         if (section==0&&lowBanListModel.楼盘名称){
             lowPropertyNameView.titleTextField.text=lowBanListModel.楼盘名称;
         }else if (section==1&&lowBanListModel.楼栋编号){
             lowPropertyNameView.titleTextField.text=lowBanListModel.楼栋编号;
         }else if (section==2&&lowBanListModel.系统楼栋名称){
             lowPropertyNameView.titleTextField.text=lowBanListModel.系统楼栋名称;
         }

        return lowPropertyNameView;
     }else if (section==4){
         LowInvestigationView *lowInvestigationView=(LowInvestigationView *)[self C_init:Identifier5 ];
         lowInvestigationView.Clock=^(BOOL open){
             _openOrClose=open;
             if (open) {
                 _noInvestigation=5;
                 [_lowArray replaceObjectAtIndex:section withObject:@"yes"];
             }else{
                 _noInvestigation=13;
                 [_lowArray replaceObjectAtIndex:section withObject:@"no"];
             }
             
             [self Refresh];
         };
         [lowInvestigationView _init:[key objectAtIndex:0] OpenClose:_openOrClose];
         return lowInvestigationView;
     }else if (section==5) {
         LowSelectDateView *lowSelectDateView=(LowSelectDateView *)[self C_init:Identifier2 ];
         lowSelectDateView.titleTextField.tag=section+1000;
         lowSelectDateView.titleTextField.delegate=self;
         [lowSelectDateView _init:[key objectAtIndex:0]InPutView:_calendarView];
         _calendarView.ClockDate=^(NSString * dateStr){
             lowSelectDateView.titleTextField.text=[NetworkManager str:dateStr];
             
         };
          if(section==5){
//              if (!lowBanListModel.竣工年代) {
//                  NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//                  [formatter setDateFormat:@"yyyy.MM.dd"];
//                  lowBanListModel.竣工年代=[formatter stringFromDate:[NSDate date]];
//                  
//              }
             lowSelectDateView.titleTextField.text=lowBanListModel.竣工年代;
         }

         return lowSelectDateView;
     }
     else if ((section>=6&&section<=8)||section==3) {
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier3 ];
        formInPutView.formTextField.tag=section+1000;
         formInPutView.formTextField.delegate=self;
         formInPutView.formTextField.keyboardType=UIKeyboardTypeDefault;
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"必填"];
         formInPutView.formTextField.text=@"";
         if (section==3&&lowBanListModel.实际楼栋名称){
             formInPutView.formTextField.text=lowBanListModel.实际楼栋名称;
         }else if (section==6){
             formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
             if (lowBanListModel.总楼层) {
                 formInPutView.formTextField.text=lowBanListModel.总楼层;
             }
             
         }else if (section==7){
             formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
             if (lowBanListModel.地上楼层) {
                 formInPutView.formTextField.text=lowBanListModel.地上楼层;
             }
             
         }else if (section==8){
             formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
             if (lowBanListModel.地下楼层) {
                  formInPutView.formTextField.text=lowBanListModel.地下楼层;
             }
            
         }
        return formInPutView;
     }else if (section==9||section==11)
     {
         LowPackView *lowPackView=(LowPackView *)[self C_init:Identifier4];
         lowPackView.titleTextField.delegate=self;
         lowPackView.titleTextField.tag=100+section;
         [lowPackView _init:[key objectAtIndex:0] Weather:@"选填" InPutView:_selectFormPickerView];
         _selectFormPickerView.Clock=^(NSString *str){
             lowPackView.titleTextField=[selfWeek.view viewWithTag:Indext];
             lowPackView.titleTextField.text=str;
         };
         if (section==9) {
             if (!lowBanListModel.建筑形态) {
                 lowBanListModel.建筑形态=@"独栋别墅";
             }
             lowPackView.titleTextField.text=lowBanListModel.建筑形态;
         }else if (section==11){
             if (!lowBanListModel.相对位置) {
                 lowBanListModel.相对位置=@"楼王,独一无二";
             }
             lowPackView.titleTextField.text=lowBanListModel.相对位置;
         }


         return lowPackView;
     }else{

         FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier3 ];
         formInPutView.formTextField.tag=section+1000;
         formInPutView.formTextField.delegate=self;
         formInPutView.formTextField.keyboardType=UIKeyboardTypeDefault;
         [formInPutView _init:[key objectAtIndex:0] WaterMark:@"选填"];
         formInPutView.formTextField.text=@"";
         if (section==10) {
             formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
             if (lowBanListModel.联排别墅数量) {
                 formInPutView.formTextField.text=lowBanListModel.联排别墅数量;
             }
         }else if (section==12&&lowBanListModel.备注){
             formInPutView.formTextField.text=lowBanListModel.备注;
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
                return 0;
            }else{
                if (section==12) {
                    return 44;
                }
                return 0;
            }
            
        }
    }else{
        if (![self.selectSee isEqualToString:@"查看"]) {
            if (_noInvestigation==5) {
                if (section==4) {
                    return 44;
                }
                return 0;
            }else{
                if (section==12) {
                    return 44;
                }
                return 0;
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
            if (section==12) {
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
    yesNo = !yesNo;
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
        lowBanListModel.系统楼栋名称=textField.text;
    }else if (textField.tag==1003){
        lowBanListModel.实际楼栋名称=textField.text;
    }else if (textField.tag == 10004){
        lowBanListModel.无法调查说明 = textField.text;
    }else if (textField.tag==1005){
        lowBanListModel.竣工年代=textField.text;
    }else if (textField.tag==1006){
        lowBanListModel.总楼层=textField.text;
    }else if (textField.tag==1007){
        lowBanListModel.地上楼层=textField.text;
    }else if (textField.tag==1008){
        lowBanListModel.地下楼层=textField.text;
    }else if (textField.tag==109){
        lowBanListModel.建筑形态=textField.text;
    }else if (textField.tag==1010){
        lowBanListModel.联排别墅数量=textField.text;
    }else if (textField.tag==1012){
        lowBanListModel.备注=textField.text;
    }
    fistTextField = nil;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    Indext=textField.tag;
    NSLog(@"%d",textField.tag);
    if (textField.tag==109||textField.tag==111) {
        _selectFormPickerView.trafficArray=[self.dropDownArray objectAtIndex:textField.tag-100];
    }
//
    return YES;
}

-(void)netSaveFormData{
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"保存中..."];
    typeof(self)SelfWeek=self;
    
    NSMutableDictionary *dictSave=[[NSMutableDictionary alloc]initWithDictionary:lowBanListModel.toDictionary];
    if (self.estateID) {
        [dictSave setObject:self.estateID forKey:@"taskId"];
    }
    [dictSave setObject:@"houseBuding" forKey:@"makeType"];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dictSave relativePath:@"appAction!saveMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        SaveModel *saveModel=[[SaveModel alloc]initWithDictionary:responseObject error:nil];
        if (saveModel) {
            if ([saveModel.status isEqualToString:@"1"]) {
                
                [BaseView _init:saveModel.message View:SelfWeek.view];
                if (![self.selectSee isEqualToString:@"编辑"]) {
                    [SelfWeek postValues:@{@"ID":lowBanListModel.楼栋编号,@"NAME":lowBanListModel.实际楼栋名称,@"楼盘名称":[super replaceString:lowBanListModel.楼盘名称]}];
                    
                    UIScrollView *scrollView=(UIScrollView *)self.view.superview;
                    [scrollView setContentOffset:CGPointMake(2*self.view.frame.size.width, 0) animated:YES];
                }
                lowBanListModel.ID = saveModel.ID;
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
    NSNotification *notification =[NSNotification notificationWithName:@"lowloudong" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

//判断必填项
-(void)required{
    if (yesNo) {
        if (!(lowBanListModel.楼盘ID.length>0)) {
            [BaseView _init:@"请选择楼盘名称" View:self.view];
        }else if (!(lowBanListModel.楼栋编号.length>0)){
            [BaseView _init:@"请选择系统楼栋名称" View:self.view];
        }else if (!(lowBanListModel.实际楼栋名称.length>0)){
            [BaseView _init:@"请输入实际楼栋名称" View:self.view];
        }else if(!(lowBanListModel.无法调查说明.length>0)){
            [BaseView _init:@"请输入无法调查说明" View:self.view];
        } else{
            [self netSaveFormData];
        }
    }else{
        if (!(lowBanListModel.楼盘ID.length>0)) {
            [BaseView _init:@"请选择楼盘名称" View:self.view];
        }else if (!(lowBanListModel.楼栋编号.length>0)){
            [BaseView _init:@"请选择系统楼栋名称" View:self.view];
        }else if (!(lowBanListModel.实际楼栋名称.length>0)){
            [BaseView _init:@"请输入实际楼栋名称" View:self.view];
        }else if (!(lowBanListModel.总楼层.length>0)){
            [BaseView _init:@"请输入总楼层" View:self.view];
        }else if (!(lowBanListModel.地上楼层.length>0)){
            [BaseView _init:@"请输入地上楼层" View:self.view];
        }else if (!(lowBanListModel.地下楼层.length>0)){
            [BaseView _init:@"请输入地下楼层" View:self.view];
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
