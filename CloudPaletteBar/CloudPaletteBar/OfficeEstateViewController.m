//
//  OfficeEstateViewController.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "OfficeEstateViewController.h"
#import "CloudPaletteBar.h"
#import "NetworkManager.h"
#import "LowEstateCell.h"
#import "LowFootView.h"
#import "FormInPutView.h"
#import "LowSelectDateView.h"
#import "LowPropertyNameView.h"
#import "OfficeEstateAddressView.h"
#import "LowPackView.h"
#import "CalendarView.h"
#import "SelectFormPickerView.h"
#import "NetworkManager.h"
#import "BaseView.h"
#import "OfficeEstateModel.h"
#import "FormSelectTableView.h"
#import "SystemModel.h"
#import "MJRefresh.h"
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

@interface OfficeEstateViewController ()<UITextFieldDelegate,UISearchBarDelegate>
{
    UITextField *fistTextField;
    OfficeEstateModel *officeEstateModel;
    FormSelectTableView *formSelectTableView;
    OfficeEstateListModel *officeEstateListModel;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    NSMutableArray *addressArray1;
    NSMutableArray *addressArray2;
    NSInteger tagView;
    NSString *secarchName;
    UIView *formSelectView;
}
@property(nonatomic,strong)SelectFormPickerView *selectFormPickerView;
@property(nonatomic,strong)SelectFormPickerView *citypick;
@property(nonatomic,strong)CalendarView *calendarView;
@property(nonatomic,strong)NSMutableArray *lowArray;
@property(nonatomic,strong)NSMutableArray *dropDownArray;
@property (nonatomic ,strong)UISearchBar *searchBar;
@end

@implementation OfficeEstateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor=[UIColor redColor];
//    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//    [button addTarget:self action:@selector(ClockSave) forControlEvents:UIControlEventTouchUpInside];
//    button.frame=CGRectMake(0, 74, 100, 50);
//    button.backgroundColor=[UIColor grayColor];
//    [self.view addSubview:button];
    
    self.baseTableView.frame=CGRectMake(0, 0, screen_width, screen_height-50-64);
    [self registerHeat];
    self.lowArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OpenOrClose"]];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"LowEstateCell" bundle:nil] forCellReuseIdentifier:Identifier];
    //    LowEstate
    self.baseArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"OfficeEstate"]];
    self.dropDownArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"Estate"]];
    _calendarView=[[[NSBundle mainBundle]loadNibNamed:@"CalendarView" owner:self options:nil]lastObject];
    
    [self.calendarView reloadWithDate: 3];
    _selectFormPickerView=[[[NSBundle mainBundle]loadNibNamed:@"SelectFormPickerView" owner:self options:nil]lastObject];
    [_selectFormPickerView _init:nil];
    _citypick=[[[NSBundle mainBundle]loadNibNamed:@"SelectFormPickerView" owner:self options:nil]lastObject];
    [_citypick _init:nil];
    
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
    [self netFormData];
//    [self netSysData:1];
}

-(void)registerHeat{
    [self registerHeat:@"FormInPutView" Mark:Identifier1];
    [self registerHeat:@"LowSelectDateView" Mark:Identifier2];
    [self registerHeat:@"LowPropertyNameView" Mark:Identifier3];
    [self registerHeat:@"OfficeEstateAddressView" Mark:Identifier4];
    [self registerHeat:@"LowPackView" Mark:Identifier5];
    [self registerHeat:@"LowFootView" Mark:Identifier7];
    
    //    [self registerHeat:@"HouseSelectView" Mark:Identifier6];
    //    [self.baseTableView registerClass:[HouseSelectView class] forHeaderFooterViewReuseIdentifier:Identifier6];
}

//获取系统楼盘编号和系统楼盘名称
-(void)netSysData:(int)page andName:(NSString *)name{
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"officeLoupan",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":name}];
    if (self.estateID) {
        [dict setObject:self.estateID forKey:@"taskId"];
    }
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getLoupan.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        Arraykeys=[[NSMutableArray alloc]init];
        Arrayvalues=[[NSMutableArray alloc]init];
        [SelfWeek tableviewEnd];
                SystemModel *systemModel = [[SystemModel alloc]initWithDictionary:responseObject error:nil];
                if (systemModel) {
                    if ([systemModel.status isEqualToString:@"1"]) {
                        for (SystemListModel *systemListModel in systemModel.list) {
                           [ Arraykeys addObject:[NSString stringWithFormat:@"%@ %@",systemListModel.系统楼盘名称,systemListModel.系统楼盘编号]];
                            [ Arrayvalues addObject:systemListModel.系统楼盘编号];
                        }
                        if (formSelectTableView.TagT==1002) {
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

-(void)Init_o{
    officeEstateListModel=[[OfficeEstateListModel alloc]init];
    addressArray1=[[NSMutableArray alloc]init];
    addressArray2=[[NSMutableArray alloc]init];
   
    
}

//获取表单数据

-(void)netFormData{
    
 
    NSMutableDictionary  *dic=[[NSMutableDictionary alloc]initWithDictionary:@{@"makeType":@"officeLoupan"}];
    if (self.estateID) {
        if ([kUserDefaults objectForKey:@"officeId" ]!=NULL) {
            [dic setObject:self.estateID forKey:@"taskId"];
//            if (self.selectIndex==0) {
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
//            if (self.selectIndex==0) {
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
        officeEstateModel = [[OfficeEstateModel alloc]initWithDictionary:responseObject error:nil];
        if (officeEstateModel) {
            if ([officeEstateModel.status isEqualToString:@"1"]) {
                if (officeEstateModel.list.count>0) {
                    officeEstateListModel=[officeEstateModel.list objectAtIndex:0];
                    //                    把字符串转成数组
                    addressArray1=[[NSMutableArray alloc]initWithArray:[NetworkManager address:officeEstateListModel.地理位置1]];
                    //                    把字符串转成数组
                    addressArray2=[[NSMutableArray alloc]initWithArray:[NetworkManager address:officeEstateListModel.地理位置2]];
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
    if (section==2) {
        return 0;
    }
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary *dic=[self.baseArray objectAtIndex:section];
    NSArray *key=[dic allKeys];
    
    
    if (section==4||section==9) {
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier1 ];
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        formInPutView.formTextField.keyboardType=UIKeyboardTypeDefault;
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"必填"];
        formInPutView.formTextField.text=@"";
         if (section==4&&officeEstateListModel.实际楼盘名称){
            
            formInPutView.formTextField.text=officeEstateListModel.实际楼盘名称;
        }else if (section==9){
            formInPutView.formTextField.keyboardType=UIKeyboardTypeNumberPad;
            if (officeEstateListModel.总楼栋数) {
                formInPutView.formTextField.text=officeEstateListModel.总楼栋数;
            }
            
        }
        return formInPutView;
    }else if (section==1){
        LowSelectDateView *lowSelectDateView=(LowSelectDateView *)[self C_init:Identifier2 ];
        lowSelectDateView.titleTextField.tag=section+1000;
        lowSelectDateView.titleTextField.delegate=self;
        [lowSelectDateView _init:[key objectAtIndex:0]InPutView:_calendarView];
        _calendarView.ClockDate=^(NSString * dateStr){
            lowSelectDateView.titleTextField.text=[NetworkManager str:dateStr];
        };
        if (!officeEstateListModel.查勘日期) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy.MM.dd"];
            officeEstateListModel.查勘日期=[formatter stringFromDate:[NSDate date]];
            
        }
            lowSelectDateView.titleTextField.text= officeEstateListModel.查勘日期;
        return lowSelectDateView;
        
    }else if (section==2||section==3){
        LowPropertyNameView *lowPropertyNameView=(LowPropertyNameView *)[self C_init:Identifier3 ];
        lowPropertyNameView.tag=1000+section;
        lowPropertyNameView.ClockLow=^(NSInteger Tag){
            if (Tag) {
                formSelectTableView.formSelectArray=nil;
                [formSelectTableView.mj_header beginRefreshing];
                formSelectTableView.TagT=Tag;
                [[BaseView baseShar]_initPop:formSelectView Type:1];
            }
        };
        formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
            _searchBar.text = @"";
            secarchName = @"";
            _searchBar.showsCancelButton = NO;
            [_searchBar resignFirstResponder];
            
            officeEstateListModel.系统楼盘名称=[NetworkManager interceptStrTo:selectStr PleStr:@" "];
            officeEstateListModel.系统楼盘编号=[Arrayvalues objectAtIndex:Index];
            
            [self.baseTableView reloadData];
        };
        [lowPropertyNameView _init:[key objectAtIndex:0] Weather:@"自动设置"];
        lowPropertyNameView.titleTextField.text=@"";
        lowPropertyNameView.selectButton.hidden=NO;
        if (section==2){
            lowPropertyNameView.selectButton.hidden=YES;
            if (officeEstateListModel.系统楼盘编号) {
                lowPropertyNameView.titleTextField.text=officeEstateListModel.系统楼盘编号;
            }
            
        }else if (section==3&&officeEstateListModel.系统楼盘名称){
            lowPropertyNameView.titleTextField.text=officeEstateListModel.系统楼盘名称;
        }
        return lowPropertyNameView;
    }else if (section==0||section==5||section==11||section==10) {
        FormInPutView *formInPutView=(FormInPutView *)[self C_init:Identifier1 ];
        formInPutView.formTextField.tag=section+1000;
        formInPutView.formTextField.delegate=self;
        [formInPutView _init:[key objectAtIndex:0] WaterMark:@"选填"];
        formInPutView.formTextField.text=@"";
        if (section==0) {
            if (!officeEstateListModel.查勘人) {
                NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]);
                officeEstateListModel.查勘人=[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
            }
            formInPutView.formTextField.text=officeEstateListModel.查勘人;
            
        }else if (section==5&&officeEstateListModel.楼盘别名) {
            formInPutView.formTextField.text=officeEstateListModel.楼盘别名;
        }else if (section==10&&officeEstateListModel.开发商){
            formInPutView.formTextField.text=officeEstateListModel.开发商;
        }else if (section==11&&officeEstateListModel.备注){
            formInPutView.formTextField.text=officeEstateListModel.备注;
        }
        return formInPutView;
    }else if(section==6||section==7)
    {
        OfficeEstateAddressView *officeEstateAddressView=[tableView dequeueReusableHeaderFooterViewWithIdentifier:Identifier4];
        officeEstateAddressView.addressTextField.tag=10000+section;
        officeEstateAddressView.addressTextField.delegate=self;
        officeEstateAddressView.areaTextField.tag=100+section;
        officeEstateAddressView.areaTextField.delegate=self;
        officeEstateAddressView.roundTextField.tag=10+section;
        officeEstateAddressView.roundTextField.delegate=self;
        officeEstateAddressView.addressTextField.text=@"";
        officeEstateAddressView.roundTextField.text=@"";
        officeEstateAddressView.areaTextField.text=@"";
        if (section==6) {
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
                    if (addressArray2.count>2){
                        officeEstateAddressView.roundTextField.text=[addressArray2 objectAtIndex:2];
                    }
            }
        }
        _citypick.Clock=^(NSString *str){
           UITextField *TextField= (UITextField *)[self.view viewWithTag:tagView];
            if ([str isEqualToString:@"请选择"]) {
                str = @"";
            }
            TextField.text=str;
            
        };

        return officeEstateAddressView;
    }else{
        LowPackView *lowPackView=(LowPackView *)[self C_init:Identifier5];
        lowPackView.titleTextField.delegate=self;
        lowPackView.titleTextField.tag=100+section;
        [lowPackView _init:[key objectAtIndex:0] Weather:@"必填" InPutView:_selectFormPickerView];
        _selectFormPickerView.Clock=^(NSString *str){
                lowPackView.titleTextField.text=str;
            
        };
        lowPackView.titleTextField.text=@"";
        if (!officeEstateListModel.交通便利程度) {
            officeEstateListModel.交通便利程度=@"便捷";
        }
        lowPackView.titleTextField.text=officeEstateListModel.交通便利程度;
        return lowPackView;
    }
}



-(UITableViewHeaderFooterView *)C_init:(NSString *)mark{
    return [self.baseTableView dequeueReusableHeaderFooterViewWithIdentifier:mark];
    //    return [[[NSBundle mainBundle]loadNibNamed:xibName owner:self options:nil]lastObject];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (![self.selectSee isEqualToString:@"查看"]) {
        if (section==11) {
            return 44;
        }
    }
    
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (![self.selectSee isEqualToString:@"查看"]) {
        if (section==11) {
            LowFootView *lowFootView=(LowFootView *)[self C_init:Identifier7];
            lowFootView.SaveClock=^(){
                [self required ];
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
    NSLog(@"%ld",(long)textField.tag);
    if (textField.tag==1000) {
        officeEstateListModel.查勘人=textField.text;
    }else if (textField.tag==1001){
        officeEstateListModel.查勘日期=textField.text;
    }else if (textField.tag==1004){
        officeEstateListModel.实际楼盘名称=textField.text;
    }else if (textField.tag==1005){
        officeEstateListModel.楼盘别名=textField.text;
    }else if (textField.tag==108){
        officeEstateListModel.交通便利程度=textField.text;
    }else if (textField.tag==1009){
        officeEstateListModel.总楼栋数=textField.text;
    }else if (textField.tag==1010){
        officeEstateListModel.开发商=textField.text;
    }else if (textField.tag==1011){
        officeEstateListModel.备注=textField.text;
    }else if (textField.tag==10006){
//        替换数据的数据跟新数组
        [self repn:textField.text Index:0 Datas:addressArray1];
        
    }else if (textField.tag==106){
        //        替换数据的数据跟新数组
        [self repn:textField.text Index:1 Datas:addressArray1];
    }else if (textField.tag==16){
        //        替换数据的数据跟新数组
        [self repn:textField.text Index:2 Datas:addressArray1];
    }else if (textField.tag==10007){
        //        替换数据的数据跟新数组
        [self repn:textField.text Index:0 Datas:addressArray2];
    }else if (textField.tag==107){
        //        替换数据的数据跟新数组
        [self repn:textField.text Index:1 Datas:addressArray2];
    }else if (textField.tag==17){
        //        替换数据的数据跟新数组
        [self repn:textField.text Index:2 Datas:addressArray2];
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
    if (textField.tag==108) {
        _selectFormPickerView.trafficArray=[self.dropDownArray objectAtIndex:textField.tag-100];
    }else if (textField.tag==10006||textField.tag==10007){
        tagView=textField.tag;
        _citypick.trafficArray=[NetworkManager _readInit:@"city"];
    }
    
    return YES;
}


-(void)netSaveFormData{
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"保存中..."];
    typeof(self)SelfWeek=self;

    NSMutableDictionary *dictSave=[[NSMutableDictionary alloc]initWithDictionary:officeEstateListModel.toDictionary];
    if (self.estateID) {
        [dictSave setObject:self.estateID forKey:@"taskId"];
    }
    [dictSave setObject:@"officeLoupan" forKey:@"makeType"];
   
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dictSave relativePath:@"appAction!saveMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        SaveModel *saveModel=[[SaveModel alloc]initWithDictionary:responseObject error:nil];
        if (saveModel) {
            if ([saveModel.status isEqualToString:@"1"]) {
                [BaseView _init:saveModel.message View:SelfWeek.view];
                officeEstateListModel.ID = saveModel.ID;
                if (![self.selectSee isEqualToString:@"编辑"]) {
                    [SelfWeek postValues:@{@"ID":saveModel.ID,@"NAME":[super replaceString:officeEstateListModel.实际楼盘名称]}];
                    
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
    NSNotification *notification =[NSNotification notificationWithName:@"officeloupan" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
//判断必填项
-(void)required{
    __block int count1 = 0;
    __block int count2 = 0;
    
    //    把位置信息转成字符串付给对象属性
    officeEstateListModel.地理位置1=[NetworkManager Datastrings:addressArray1];
    officeEstateListModel.地理位置2=[NetworkManager Datastrings:addressArray2];
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

    if (!officeEstateListModel.实际楼盘名称){
        [BaseView _init:@"请输入实际楼盘名称" View:self.view];
    }else if (count1!=3&&count2!=3){
        [BaseView _init:@"请输入任意一个完整的地理位置信息" View:self.view];
    }else if (!officeEstateListModel.交通便利程度){
        [BaseView _init:@"请选择交通便利程度" View:self.view];
    }else if (!officeEstateListModel.总楼栋数){
        [BaseView _init:@"请输入总楼栋数" View:self.view];
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
