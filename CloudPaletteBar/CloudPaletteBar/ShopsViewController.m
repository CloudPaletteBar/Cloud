//
//  ShopsViewController.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import "ShopsViewController.h"
#import "ShopsModel.h"
#import "zySheetPickerView.h"
#import "StoreyView.h"
#import "SaveModel.h"
#import "FormSelectTableView.h"
#import "MJRefresh.h"
#import "LowPropertyNameView.h"
#import "CommerciaEstateModel.h"
#import "StoreMarketView.h"

@interface ShopsViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UISearchBarDelegate>
{
    StoreMarketView *storeMarketView;
    FormSelectTableView *formSelectTableView;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    NSMutableArray *ArrayAll;
    NSMutableArray *ArrayNumber;
    NSString *shopsStr;
    NSInteger integerTag;
    StoreyView *storeyView;
    NSMutableArray *shopsArray;
    ShopsListModel *shopsListModel;
    NSMutableArray *shopsWidthArray;
    NSMutableArray *shopsArray1, *shopsArray2, *shopsArray3, *shopsArray4, *shopsArray5, *shopsArray6;
    NSString *look;
    NSString *shangyeLouDongBianhao;
    
    __weak IBOutlet UIButton *button1;
    __weak IBOutlet UIButton *button3;
    __weak IBOutlet UIButton *button4;
    __weak IBOutlet UIButton *button5;
    __weak IBOutlet UIButton *button6;
    
    __weak IBOutlet UISegmentedControl *segmented1;
    __weak IBOutlet UISegmentedControl *segmented2;
    __weak IBOutlet UISegmentedControl *segmented3;
    __weak IBOutlet UISegmentedControl *segmented4;
    __weak IBOutlet UISegmentedControl *segmented5;
    __weak IBOutlet UISegmentedControl *segmented6;
    
    __weak IBOutlet UISwitch *switch1;
    __weak IBOutlet UISwitch *switch2;
    __weak IBOutlet UISwitch *switch3;
    __weak IBOutlet UISwitch *switch4;
    __weak IBOutlet UISwitch *switch5;
    __weak IBOutlet UISwitch *switch6;
    __weak IBOutlet UISwitch *switch7;
    
    __weak IBOutlet UIView *view1;
    __weak IBOutlet UIButton *mergedButton;
    __weak IBOutlet UIButton *splitButton;
    
    __weak IBOutlet UIView *view2;
    __weak IBOutlet UITextField *textField14;
    __weak IBOutlet UITextField *textField1;
    __weak IBOutlet UITextField *textField2;
    __weak IBOutlet UITextField *textField3;
    __weak IBOutlet UITextField *textField4;
    __weak IBOutlet UITextField *textField5;
    __weak IBOutlet UITextField *textField6;
    __weak IBOutlet UITextField *textField7;
    __weak IBOutlet UITextField *textField8;
    __weak IBOutlet UILabel *jia1;
    __weak IBOutlet UITextField *textField9;
    __weak IBOutlet UILabel *mi2;
    __weak IBOutlet UILabel *jia2;
    __weak IBOutlet UITextField *textField10;
    __weak IBOutlet UILabel *mi3;
    
    __weak IBOutlet UIView *view3;
    __weak IBOutlet NSLayoutConstraint *view3h;
    IBOutlet UIView *view5;
    __weak IBOutlet NSLayoutConstraint *view5H;
    IBOutlet UIView *view6;
    __weak IBOutlet NSLayoutConstraint *view6H;
    IBOutlet UIView *view7;
    IBOutlet UIView *view8;
    __weak IBOutlet NSLayoutConstraint *view8H;
    __weak IBOutlet UITextField *textField11;
    __weak IBOutlet UITextField *textField12;
    __weak IBOutlet UITextField *textField13;
    
    __weak IBOutlet UIView *view4;
    
    __weak IBOutlet NSLayoutConstraint *view1H;
    
    NSString *secarchName;
    UIView *formSelectView;
}
@property (nonatomic ,strong)UISearchBar *searchBar;
@end

@implementation ShopsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(gongyeLouCengToShangPu:) name:@"gongyeLouCengToShangPu" object:nil];
    
    look = [kUserDefaults objectForKey:@"商业查看"];
    if ([look isEqualToString:@"商业查看"]) {
        button6.hidden = YES;
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotice:) name:@"noticeBusiness" object:nil];
    
    shopsArray = [NSMutableArray arrayWithCapacity:1];
    _strId = [super replaceString:[kUserDefaults objectForKey:@"businessId"]];
    _taskID = [super replaceString:[kUserDefaults objectForKey:@"taskId"]];

    self.contentView.frame = CGRectMake(0, 0, MainScreenWidth, self.contentView.frame.size.height);
    [self.buil4ScrollView addSubview:self.contentView];
    
    if (self.taskID) {
        view1H.constant = 0;
        self.buil4ScrollView.contentSize = CGSizeMake(0, 810);
    }else{
        self.buil4ScrollView.contentSize = CGSizeMake(0, 860);
    }

    [self kNetworkListMake];
    
    formSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-150)];
    self.searchBar.frame = CGRectMake(0, 0, screen_width, 50.0);
    formSelectTableView=[[FormSelectTableView alloc]initWithFrame:CGRectMake(0, 50, screen_width, formSelectView.frame.size.height-50)];
    [formSelectView addSubview:formSelectTableView];
    __weak typeof(self)SelfWeak=self;
    [formSelectTableView _initOrderUP:^(int Page) {
        [SelfWeak netSysData:Page andTag:integerTag andName:[super replaceString:secarchName]];
    } Down:^(int Page) {
        [SelfWeak netSysData:Page andTag:integerTag andName:[super replaceString:secarchName]];
    }];
    
    [self layerView:button1];
    [self layerView:button3];
    [self layerView:button4];
    [self layerView:button5];
    [self layerView:button6];
    [self layerView:mergedButton];
    [self layerView:splitButton];
    mergedButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    mergedButton.layer.borderWidth = 0.5;
    splitButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    splitButton.layer.borderWidth = 0.5;
    
    storeMarketView=[[[NSBundle mainBundle]loadNibNamed:@"StoreMarketView" owner:self options:nil] lastObject];
    storeMarketView.frame = CGRectMake(0, 150, screen_width, screen_height-150);
    __weak typeof(self)SelfWeak2=self;
    [storeMarketView _initOrderUP:^(int Page) {
        [SelfWeak2 mergingButton:Page];
    } Down:^(int Page) {
        [SelfWeak2 mergingButton:Page];
    }];
}

-(void)gongyeLouCengToShangPu:(NSNotification *)sender{
    textField1.text = [[sender object]objectForKey:@"楼栋名称"];
    shopsListModel.楼栋名称 = textField1.text;
    shopsListModel.楼栋编号 = [[sender object]objectForKey:@"楼栋编号"];
    textField14.text = [[sender object]objectForKey:@"商业楼层"];
    shopsListModel.楼层 = textField14.text;
    shopsStr = [[sender object]objectForKey:@"楼栋名称"];
}

-(void)layerView:(UIView *)view{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0;
}

- (void)reciveNotice:(NSNotification *)notification{
    textField1.text = [super replaceString:[kUserDefaults objectForKey:@"楼栋名称"]];
    textField14.text = [super replaceString:[kUserDefaults objectForKey:@"楼层"]];
    shopsListModel.楼栋名称 = textField1.text;
    shopsListModel.楼层 = textField14.text;
    shopsListModel.楼栋编号 = [kUserDefaults objectForKey:@"楼栋编号"];
    shopsStr = textField1.text;
}

-(void)kNetworkListMake{
    NSDictionary *dcit;
    if (self.selectIndex==3) {
        if (self.taskID.length>1) {
            dcit = @{@"makeType":@"tradeShangpu",@"ID":self.strId,@"taskId":self.taskID};
        }else if(self.strId.length>1){
            dcit = @{@"makeType":@"tradeShangpu",@"ID":self.strId};
        }else{
            dcit = @{@"makeType":@"tradeShangpu"};
        }
    }else{
        dcit = @{@"ID":@"0"};
    }
    __weak typeof(self)SelfWeek=self;
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dcit relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        ShopsModel *shopsModel = [[ShopsModel alloc]initWithDictionary:responseObject error:nil];
        shopsListModel = [[ShopsListModel alloc]init];
        if (shopsModel) {
            [shopsArray addObjectsFromArray:shopsModel.list];
        }else{
            [BaseView _init:@"亲你的网络不给力哦" View:SelfWeek.view];
        }
        if (shopsArray.count>0) {
            [SelfWeek loadData];
        }else{
            [SelfWeek _initObject];
        }
    } failure:^(NSError *error) {
        [BaseView _init:@"亲网络异常请稍后" View:SelfWeek.view];
        [SelfWeek _initObject];
    }];
}

-(void)_initObject{
    shopsArray1 = [NSMutableArray arrayWithCapacity:1];
    shopsArray2 = [NSMutableArray arrayWithCapacity:1];
    shopsArray3 = [NSMutableArray arrayWithCapacity:1];
    shopsArray4 = [NSMutableArray arrayWithCapacity:1];
    shopsArray5 = [NSMutableArray arrayWithCapacity:1];
    shopsArray6 = [NSMutableArray arrayWithCapacity:1];
    shopsWidthArray = [NSMutableArray arrayWithCapacity:1];
    segmented3.selectedSegmentIndex = 3;
    shopsListModel.经营状况 = @"经营";
    shopsListModel.商铺开面数 = @"单面开面宽";
    shopsListModel.商铺类型 = @"临街商铺";
    shopsListModel.临街类型 = @"三面临街";
}
-(void)loadData{
    shopsListModel = [shopsArray objectAtIndex:0];

    textField1.text = [super replaceString:shopsListModel.楼栋名称];
    textField14.text = [super replaceString:shopsListModel.楼层];
    textField2.text = [super replaceString:shopsListModel.系统商铺号];
    textField3.text = [super replaceString:shopsListModel.现场商铺号];
    textField4.text = [super replaceString:shopsListModel.物业管理费];
    textField5.text = [super replaceString:shopsListModel.租金];
    
    NSString *str1 = [super replaceString:shopsListModel.经营状况];
    if ([str1 isEqualToString:@"经营"]) {
        segmented1.selectedSegmentIndex = 0;
    }else{
        segmented1.selectedSegmentIndex = 1;
    }
    
    shopsArray1 = [NSMutableArray arrayWithArray:[self array:shopsListModel.商品零售业态]];
    shopsArray2 = [NSMutableArray arrayWithArray:[self array:shopsListModel.餐饮零售业态]];
    shopsArray3 = [NSMutableArray arrayWithArray:[self array:shopsListModel.服务零售业态]];
    
    textField6.text = [super replaceString:shopsListModel.商铺进深];
    textField7.text = [super replaceString:shopsListModel.使用面积];
    
    NSString *str2 = [super replaceString:shopsListModel.商铺开面数];
    if ([str2 isEqualToString:@"单面开面宽"]) {
        segmented2.selectedSegmentIndex = 0;
        jia1.hidden = YES;
        jia2.hidden = YES;
        mi2.hidden = YES;
        mi3.hidden = YES;
        textField9.hidden = YES;
        textField10.hidden = YES;
    }else if ([str2 isEqualToString:@"两面开面宽"]){
        segmented2.selectedSegmentIndex = 1;
        jia2.hidden = YES;
        mi3.hidden = YES;
        textField10.hidden = YES;
    }else{
        segmented2.selectedSegmentIndex = 2;
    }
    
    shopsWidthArray = [NSMutableArray arrayWithArray:[self array:[super replaceString:shopsListModel.商铺开面宽]]];
    if (shopsWidthArray.count==1) {
        textField8.text = [shopsWidthArray objectAtIndex:0];
    }else if (shopsWidthArray.count == 2){
        textField8.text = [shopsWidthArray objectAtIndex:0];
        textField9.text = [shopsWidthArray objectAtIndex:1];
    }else if (shopsWidthArray.count == 3){
        textField8.text = [shopsWidthArray objectAtIndex:0];
        textField9.text = [shopsWidthArray objectAtIndex:1];
        textField10.text = [shopsWidthArray objectAtIndex:2];
    }
    
    NSString *str3 = [super replaceString:shopsListModel.商铺类型];
    [button4 setTitle:[NSString stringWithFormat:@"  %@",str3] forState:UIControlStateNormal];
    NSArray *array =@[@"临街商铺",@"内铺或柜台式商铺",@"社区商铺",@"地下交通商铺"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([str3 isEqual:obj]) {
            [self streetViewH:idx];
            *stop = YES;
        }
    }];
}

-(IBAction)selectorButton:(UIButton *)sender{
    switch (sender.tag) {
        case 500:{
            [self selectNumber1:nil];
        }
            break;
        case 502:{
            [self selectNumber2:nil];
        }
            break;
        case 503:{
//            选择经营状态
            [self selectOperationForms:sender];
        }
            break;
        case 504:{
//            商铺类型
            NSArray *array =@[@"临街商铺",@"内铺或柜台式商铺",@"社区商铺",@"地下交通商铺"];
            [self clickArray:array andTag:504];
        }
            break;
        case 505:{
//            内铺或柜台式商铺
            NSArray *array1 =@[@"靠近主梯口或主入口",@"靠近次梯口或次入口",@"主要通道两侧",@"次要通道两侧",@"位置偏远",@"其他"];
            [self clickArray:array1 andTag:505];
        }
            break;
    }
}
//合并
- (IBAction)selectMerged:(id)sender {
    [storeMarketView footerView];
    storeMarketView.breakView.hidden = YES;
    storeMarketView.formSelectArray=nil;
    ArrayAll = [[NSMutableArray alloc]init];
    [self mergingButton:1];
    [[BaseView baseShar]_initPop:storeMarketView Type:1];
    storeMarketView.SelectIndex=^(NSArray *array,NSArray *array2){
        [self saveMergingButton:array andNameArray:array2];
    };
}
//拆分
- (IBAction)selectSplit:(id)sender {
    [storeMarketView footerView];
    storeMarketView.breakView.hidden = NO;
    storeMarketView.formSelectArray=nil;
    ArrayAll = [[NSMutableArray alloc]init];
    [self mergingButton:1];
    [[BaseView baseShar]_initPop:storeMarketView Type:1];
    storeMarketView.SelectIndex2=^(NSArray *array,NSString *str){
        [self saveMergingButton2:array andNumber:[str intValue]];
    };
}

//合并请求数据  拆分请求数据
-(void)mergingButton:(int)page{
    __weak typeof(self)SelfWeek=self;
    NSDictionary *dict = @{@"makeType":@"tradeShangpu",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"20"};

    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getShangpu.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        [SelfWeek tableviewEnd];
        CommerciaEstateModel *systemModel = [[CommerciaEstateModel alloc]initWithDictionary:responseObject error:nil];
        if (systemModel) {
            if ([systemModel.status isEqualToString:@"1"]) {
                if (page==1) {
                    [ArrayAll removeAllObjects];
                    [ArrayAll addObjectsFromArray:systemModel.list];
                }else{
                    [ArrayAll addObjectsFromArray:systemModel.list];
                }
                storeMarketView.formSelectArray=ArrayAll;
            }
        }
        
    } failure:^(NSError *error) {
        [SelfWeek tableviewEnd];
    }];
}
//合并保存数据
-(void)saveMergingButton:(NSArray *)array andNameArray:(NSArray *)array2{
    if (array.count>1) {
        NSString *str = [array2 objectAtIndex:0];
        for (NSString *str2 in array2) {
            if (![str isEqualToString:str2]) {
                ALERT(@"", @"所选择商铺非同一栋及同一层，不能合并", @"确定");
                return;
            }
        }
        
        NSString *ids = [NetworkManager Datastrings:array];
        NSDictionary *dict = @{@"ids":ids,@"makeType":@"tradeShangpu"};
        
        [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appAction!saveHebin.chtml" success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            NSString *status = [responseObject objectForKey:@"status"];
            if ([status isEqualToString:@"1"]) {
                [[BaseView baseShar]dissMissPop:YES];
                [BaseView _init:@"商铺合并保存成功" View:storeMarketView];
            }else{
                NSString *message = [responseObject objectForKey:@"message"];
                [BaseView _init:message View:storeMarketView];
            }
        } failure:^(NSError *error) {
            [BaseView _init:@"亲网络异常请稍后" View:storeMarketView];
        }];
    }else{
        ALERT(@"", @"至少两个才能合并", @"确定");
    }
}
//拆分保存数据
-(void)saveMergingButton2:(NSArray *)array andNumber:(int)number{
    if (!(number>0 && number<=100)) {
        ALERT(@"", @"拆分数量最少拆分一个,最多拆分一百个", @"确定");
        return;
    }
    if (array.count==1) {
        NSString *ids = [NetworkManager Datastrings:array];
        NSDictionary *dict = @{@"ID":ids,@"cnum":[NSString stringWithFormat:@"%d",number], @"makeType":@"tradeShangpu"};
        
        [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appAction!saveCaifen.chtml" success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            NSString *status = [responseObject objectForKey:@"status"];
            if ([status isEqualToString:@"1"]) {
                [[BaseView baseShar]dissMissPop:YES];
                [BaseView _init:@"商铺拆分保存成功" View:storeMarketView];
            }else{
                NSString *message = [responseObject objectForKey:@"message"];
                [BaseView _init:message View:storeMarketView];
            }
        } failure:^(NSError *error) {
            [BaseView _init:@"亲网络异常请稍后" View:storeMarketView];
        }];
    }else{
        ALERT(@"", @"请选择一个商铺进行拆分", @"确定");
    }
}

-(void)clickArray:(NSArray *)array andTag:(int)tagInt{
    zySheetPickerView *pickerView = [zySheetPickerView ZYSheetStringPickerWithTitle:array andHeadTitle:@"" Andcall:^(zySheetPickerView *pickerView, NSString *choiceString) {
        
        if (tagInt == 504) {
            [button4 setTitle:[NSString stringWithFormat:@"  %@",choiceString] forState:UIControlStateNormal];
            shopsListModel.商铺类型 = choiceString;
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([choiceString isEqual:obj]) {
                    [self streetViewH:idx];
                    *stop = YES;
                }
            }];
        }else{
            [button5 setTitle:[NSString stringWithFormat:@"  %@",choiceString]  forState:UIControlStateNormal];
            shopsListModel.内铺位置 = choiceString;
        }
        [pickerView dismissPicker];
    }];
    [pickerView show];
}

//商铺类型
-(void)streetViewH:(NSInteger)street{
    CGFloat constantFloat = view3h.constant;
    CGFloat yHeight = self.buil4ScrollView.contentSize.height;
    switch (street) {
        case 0:{
            view5.hidden = YES;
            view6.hidden = YES;
            view7.hidden = YES;
            view8.hidden = NO;
            [self viewHeight:view3h andHeight:170];
            if (constantFloat > 170) {
                self.buil4ScrollView.contentSize = CGSizeMake(0, yHeight-(constantFloat-170));
            }else{
                self.buil4ScrollView.contentSize = CGSizeMake(0, yHeight+(170-constantFloat));
            }
            
            shopsArray6 = [NSMutableArray arrayWithArray:[self array:[super replaceString:shopsListModel.临街名称]]];
            
            NSArray *array2 = @[@"不临街",@"单面临街",@"双面临街",@"三面临街"];
            NSString *str2 = [super replaceString:shopsListModel.临街类型];
            [array2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([str2 isEqual:obj]) {
                    segmented3.selectedSegmentIndex = idx;
                    switch (idx) {
                        case 1:
                            if (shopsArray6.count==1) {
                                textField11.text = [shopsArray6 objectAtIndex:0];
                            }
                            break;
                        case 2:
                            if (shopsArray6.count==2) {
                                textField11.text = [shopsArray6 objectAtIndex:0];
                                textField12.text = [shopsArray6 objectAtIndex:1];
                            }
                            break;
                        case 3:
                            if (shopsArray6.count==3) {
                                textField11.text = [shopsArray6 objectAtIndex:0];
                                textField12.text = [shopsArray6 objectAtIndex:1];
                                textField13.text = [shopsArray6 objectAtIndex:2];
                            }
                            break;
                    }
                    *stop = YES;
                }
            }];
        }
            break;
        case 1:{
            view7.hidden = YES;
            view8.hidden = YES;
            view6.hidden = YES;
            view5.hidden = NO;
            [self viewHeight:view3h andHeight:130];
            if (constantFloat > 130) {
                self.buil4ScrollView.contentSize = CGSizeMake(0, yHeight-(constantFloat-130));
            }else{
                self.buil4ScrollView.contentSize = CGSizeMake(0, yHeight+(130-constantFloat));
            }
            
            [button5 setTitle:[NSString stringWithFormat:@"  %@",[super replaceString:shopsListModel.内铺位置]] forState:UIControlStateNormal];
            NSArray *array1 = @[@"内铺",@"柜台式",@"中岛"];
            NSString *str1 = [super replaceString:shopsListModel.内铺类型];
            [array1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([str1 isEqual:obj]) {
                    segmented4.selectedSegmentIndex = idx;
                    *stop = YES;
                }
            }];
            NSArray *array2 = @[@"不临街",@"单面临街",@"双面临街",@"三面临街"];
            NSString *str2 = [super replaceString:shopsListModel.内铺临内街];
            [array2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([str2 isEqual:obj]) {
                    segmented5.selectedSegmentIndex = idx;
                    *stop = YES;
                }
            }];
        }
            break;
        case 2:{
            view7.hidden = YES;
            view8.hidden = YES;
            view5.hidden = YES;
            view6.hidden = NO;
            [self viewHeight:view3h andHeight:130];
            if (constantFloat > 130) {
                self.buil4ScrollView.contentSize = CGSizeMake(0, yHeight-(constantFloat-130));
            }else{
                self.buil4ScrollView.contentSize = CGSizeMake(0, yHeight+(130-constantFloat));
            }
            
            shopsArray4 = [NSMutableArray arrayWithArray:[self array:[super replaceString:shopsListModel.社区商铺]]];
             NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"800",@"靠近社区出入口位置的铺位",@"801",@"其他出入口的铺位",@"802",@"其它", nil];
            for (NSString *str in shopsArray4) {
                NSString *strTag = [dict objectForKey:str];
                switch ([strTag intValue]) {
                    case 800:
                        [switch1 setOn:YES];
                        break;
                    case 801:
                        [switch2 setOn:YES];
                        break;
                    case 802:
                        [switch3 setOn:YES];
                        break;
                }
            }
            
        }
            break;
        case 3:{
            view5.hidden = YES;
            view8.hidden = YES;
            view6.hidden = YES;
            view7.hidden = NO;
            [self viewHeight:view3h andHeight:210];
            if (constantFloat > 210) {
                self.buil4ScrollView.contentSize = CGSizeMake(0, yHeight-(constantFloat-210));
            }else{
                self.buil4ScrollView.contentSize = CGSizeMake(0, yHeight+(210-constantFloat));
            }
            
            shopsArray5 = [NSMutableArray arrayWithArray:[self array:[super replaceString:shopsListModel.地下交通商铺]]];
            NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"803",@"出入口处，人流量大",@"804",@"主要通道两侧，醒目的商铺",@"805",@"位置偏远，人流量小",@"806",@"其他", nil];
            for (NSString *str in shopsArray5) {
                NSString *strTag = [dict2 objectForKey:str];
                switch ([strTag intValue]) {
                    case 803:
                        [switch4 setOn:YES];
                        break;
                    case 804:
                        [switch5 setOn:YES];
                        break;
                    case 805:
                        [switch6 setOn:YES];
                        break;
                    case 806:
                        [switch7 setOn:YES];
                        break;
                }
            }
            NSArray *array2 = @[@"不临街",@"单面临街",@"双面临街",@"三面临街"];
            NSString *str2 = [super replaceString:shopsListModel.地下商铺临内街];
            [array2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([str2 isEqual:obj]) {
                    segmented6.selectedSegmentIndex = idx;
                }
            }];
        }
            break;
    }
}

-(void)viewHeight:(NSLayoutConstraint *)view andHeight:(CGFloat)height{
    view.constant = height;
}

-(IBAction)segmentedAction:(UISegmentedControl *)Seg{
    NSInteger index=Seg.selectedSegmentIndex;
    NSString *str = [Seg titleForSegmentAtIndex:Seg.selectedSegmentIndex];
    NSLog(@"%ld----%@-----%ld",index,str,Seg.tag);
    
    switch (Seg.tag) {
        case 600:
            shopsListModel.经营状况 = str;
            break;
        case 601:
            shopsListModel.商铺开面数 = str;
            [self shopsNumber:index];
            break;
        case 602:
            shopsListModel.临街类型 = str;
            [self streetViewH2:index];
            break;
        case 603:
            shopsListModel.内铺类型 = str;
            break;
        case 604:
            shopsListModel.内铺临内街 = str;
            break;
        case 605:
            shopsListModel.地下商铺临内街 = str;
            break;
    }
}

//商铺开面数
-(void)shopsNumber:(NSInteger)number{
    switch (number) {
        case 0:
            jia1.hidden = YES;
            jia2.hidden = YES;
            mi2.hidden = YES;
            mi3.hidden = YES;
            textField9.hidden = YES;
            textField10.hidden = YES;
            break;
        case 1:
            jia1.hidden = NO;
            jia2.hidden = YES;
            mi2.hidden = NO;
            mi3.hidden = YES;
            textField9.hidden = NO;
            textField10.hidden = YES;
            break;
        case 2:
            jia1.hidden = NO;
            jia2.hidden = NO;
            mi2.hidden = NO;
            mi3.hidden = NO;
            textField9.hidden = NO;
            textField10.hidden = NO;
            break;
    }
}

//临街类型
-(void)streetViewH2:(NSInteger)street{
    CGFloat yHeight = self.buil4ScrollView.contentSize.height;
    switch (street) {
        case 0:{
            yHeight = yHeight - 45;
            [self viewHeight:view3h andHeight:45];
            [self viewHeight:view8H andHeight:45];
            self.buil4ScrollView.contentSize = CGSizeMake(0, yHeight+45);
            
        }
            break;
        case 1:{
            yHeight = yHeight - 85;
            
            [self viewHeight:view3h andHeight:85];
            [self viewHeight:view8H andHeight:85];
            self.buil4ScrollView.contentSize = CGSizeMake(0, yHeight+85);
        }
            break;
        case 2:{
            yHeight = yHeight - 125;
            [self viewHeight:view3h andHeight:125];
            [self viewHeight:view8H andHeight:125];
            self.buil4ScrollView.contentSize = CGSizeMake(0, yHeight+125);
        }
            break;
        case 3:{
            yHeight = yHeight - 170;
            [self viewHeight:view3h andHeight:170];
            [self viewHeight:view8H andHeight:170];
            self.buil4ScrollView.contentSize = CGSizeMake(0, yHeight+170);
        }
            break;
    }
}

-(NSArray *)array:(NSString *)str{
    NSArray *strArray;
    if (str.length>1) {
        strArray = [str componentsSeparatedByString:@","];
        return strArray;
    }
    return strArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//选择主要经营业态
-(void)selectOperationForms:(UIButton *)sender{
    NSArray *array1 = @[@"食杂店",@"便利店",@"	便利超市",@"大型超市",@"仓储会员店",@"百货店",@"专业店",@"办公用品",	@"玩具",	@"家电",@"药品",	@"服饰鞋帽",	@"箱包",@"家居建材",@"五金",@"电子通讯",@"汽车及配件",@"其他"];
    NSArray *array2 = @[@"快卖店",@"快餐店",@"小吃店",@"专卖店",@"休闲厅",@"餐厅",@"酒楼",@"美食广场"];
    NSArray *array3 = @[@"专业服务",@"租赁服务",@"咨询机构",@"培训机构",@"家居服务",@"体验式服务"];
    NSArray *array4 = [NSArray arrayWithObjects:array1,array2,array3, nil];
    [self building2View:array4 andArray1:shopsArray1 andArray2:shopsArray2 andArray3:shopsArray3];
    
}

-(void)building2View:(NSArray *)array andArray1:(NSArray *)array1 andArray2:(NSArray *)array2 andArray3:(NSArray *)array3{
    if (storeyView == nil) {
        storeyView = [[[NSBundle mainBundle]loadNibNamed:@"StoreyView" owner:self options:nil] lastObject];
        storeyView.BuildingButton = ^(NSArray *arr1, NSArray *arr2, NSArray *arr3){
            [shopsArray1 removeAllObjects];
            [shopsArray1 addObjectsFromArray:arr1];
            [shopsArray2 removeAllObjects];
            [shopsArray2 addObjectsFromArray:arr2];
            [shopsArray3 removeAllObjects];
            [shopsArray3 addObjectsFromArray:arr3];
            storeyView.frame = CGRectMake(0, MainScreenheight, MainScreenWidth, 400);
        };
        [self.view addSubview:storeyView];
    }
    
    storeyView.frame = CGRectMake(0, MainScreenheight-520, MainScreenWidth, 400);
    [storeyView _initArray:array andArray1:array1 andArray2:array2 andArray3:array3];
}

- (IBAction)selectSwitch:(UISwitch *)sender {
    switch (sender.tag) {
        case 800:
            if ([sender isOn]) {
                [shopsArray4 addObject:@"靠近社区出入口位置的铺位"];
            }else{
                [shopsArray4 removeObject:@"靠近社区出入口位置的铺位"];
            }
            break;
        case 801:
            if ([sender isOn]) {
                [shopsArray4 addObject:@"其他出入口的铺位"];
            }else{
                [shopsArray4 removeObject:@"其他出入口的铺位"];
            }
            break;
        case 802:
            if ([sender isOn]) {
                [shopsArray4 addObject:@"其它"];
            }else{
                [shopsArray4 removeObject:@"其它"];
            }
            break;
        case 803:
            if ([sender isOn]) {
                [shopsArray5 addObject:@"出入口处，人流量大"];
            }else{
                [shopsArray5 removeObject:@"出入口处，人流量大"];
            }
            break;
        case 804:
            if ([sender isOn]) {
                [shopsArray5 addObject:@"主要通道两侧，醒目的商铺"];
            }else{
                [shopsArray5 removeObject:@"主要通道两侧，醒目的商铺"];
            }
            break;
        case 805:
            if ([sender isOn]) {
                [shopsArray5 addObject:@"位置偏远，人流量小"];
            }else{
                [shopsArray5 removeObject:@"位置偏远，人流量小"];
            }
            break;
        case 806:
            if ([sender isOn]) {
                [shopsArray5 addObject:@"其他"];
            }else{
                [shopsArray5 removeObject:@"其他"];
            }
            break;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 700:{
            shopsListModel.楼栋名称 = textField.text;
        }
            break;
        case 701:{
            shopsListModel.系统商铺号 = textField.text;
        }
            break;
        case 702:{
            shopsListModel.现场商铺号 = textField.text;
        }
            break;
        case 703:{
            shopsListModel.物业管理费 = textField.text;
        }
            break;
        case 704:{
            shopsListModel.租金 = textField.text;
        }
            break;
        case 705:{
            shopsListModel.商铺进深 = textField.text;
        }
            break;
        case 706:{
            shopsListModel.使用面积 = textField.text;
        }
            break;
        case 707:{
            [self repn:textField.text Index:0 Datas:shopsWidthArray];
        }
            break;
        case 708:{
            [self repn:textField.text Index:1 Datas:shopsWidthArray];
        }
            break;
        case 709:{
            [self repn:textField.text Index:2 Datas:shopsWidthArray];
        }
            break;
        case 710:{
            [self repn:textField.text Index:0 Datas:shopsArray6];
        }
            break;
        case 711:{
            [self repn:textField.text Index:1 Datas:shopsArray6];
        }
            break;
        case 712:{
            [self repn:textField.text Index:2 Datas:shopsArray6];
        }
            break;
        case 713:{
            shopsListModel.楼层 = textField.text;
        }
            break;
    }
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

//保存按钮。
- (IBAction)saveButton:(UIButton *)sender {
    shopsListModel.临街名称 = [NetworkManager Datastrings:shopsArray6];
    if (!(shopsListModel.楼栋名称.length>1)) {
        [BaseView _init:@"请选择楼栋名称" View:self.view];
    }else if (!(shopsListModel.现场商铺号.length>1)){
        [BaseView _init:@"请输入现场商铺号" View:self.view];
    }else if (!(shopsListModel.物业管理费.length>0)){
        [BaseView _init:@"请输入物业管理费" View:self.view];
    }else if (!(shopsListModel.租金.length>0)){
        [BaseView _init:@"请输入租金" View:self.view];
    }else if (!(shopsListModel.商铺进深.length>0)){
        [BaseView _init:@"请输入商铺进深" View:self.view];
    }else if (!(textField8.text.length>0)){
        [BaseView _init:@"请输入单面开面宽" View:self.view];
    }else if (!(shopsListModel.使用面积.length>0)){
        [BaseView _init:@"请输入使用面积" View:self.view];
    }else if (segmented3.selectedSegmentIndex==1&&textField11.text.length==0){
        [BaseView _init:@"请输入临街名称" View:self.view];
    }else if ((segmented3.selectedSegmentIndex==2&&textField11.text.length==0)||(segmented3.selectedSegmentIndex==2&&textField12.text.length==0)){
        [BaseView _init:@"请输入临街名称" View:self.view];
    }else if ((segmented3.selectedSegmentIndex==3&&textField11.text.length==0)||(segmented3.selectedSegmentIndex==3&&textField12.text.length==0)||(segmented3.selectedSegmentIndex==3&&textField13.text.length==0)){
        [BaseView _init:@"请输入临街名称" View:self.view];
    }else{
        [self kNetworkListMake2];
    }
}

-(void)kNetworkListMake2{
    shopsListModel.商品零售业态 = [NetworkManager Datastrings:shopsArray1];
    shopsListModel.餐饮零售业态 = [NetworkManager Datastrings:shopsArray2];
    shopsListModel.服务零售业态 = [NetworkManager Datastrings:shopsArray3];
    shopsListModel.社区商铺 = [NetworkManager Datastrings:shopsArray4];
    shopsListModel.地下交通商铺 = [NetworkManager Datastrings:shopsArray5];
    
    shopsListModel.商铺开面宽 = [NetworkManager Datastrings:shopsWidthArray];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:shopsListModel.toDictionary];
    [dict setObject:@"tradeShangpu" forKey:@"makeType"];
    if (self.taskID.length>1) {
        [dict setObject:self.taskID forKey:@"taskId"];
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
                [BaseView _init:saveModel.message View:SelfWeek.view];
                shopsListModel.ID=saveModel.ID;
                [kUserDefaults removeObjectForKey:@"楼栋名称"];
                [kUserDefaults removeObjectForKey:@"楼层"];
                [kUserDefaults removeObjectForKey:@"楼栋编号"];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)selectNumber1:(id)sender {
    formSelectTableView.formSelectArray=nil;
    Arraykeys=[[NSMutableArray alloc]init];
    Arrayvalues=[[NSMutableArray alloc]init];
    ArrayAll = [[NSMutableArray alloc]init];
    ArrayNumber = [[NSMutableArray alloc]init];
    integerTag = 1000;
    [self netSysData:1 andTag:integerTag andName:[super replaceString:secarchName]];
    [[BaseView baseShar]_initPop:formSelectView Type:1];
    formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
        _searchBar.text = @"";
        secarchName = @"";
        _searchBar.showsCancelButton = NO;
        [_searchBar resignFirstResponder];
        textField1.text = [Arraykeys objectAtIndex:Index];
        textField14.text = [Arrayvalues objectAtIndex:Index];
        shopsListModel.楼栋名称 = [Arraykeys objectAtIndex:Index];
        shopsListModel.楼层 = [Arrayvalues objectAtIndex:Index];
        shopsListModel.楼栋编号 = [ArrayNumber objectAtIndex:Index];
        shopsStr = [Arraykeys objectAtIndex:Index];
    };
}

- (void)selectNumber2:(id)sender {
    if (!(shopsStr.length>0)) {
        ALERT(@"", @"请先选择楼栋", @"确定");
        return;
    }
    formSelectTableView.formSelectArray=nil;
    Arraykeys=[[NSMutableArray alloc]init];
    integerTag = 1001;
    [self netSysData:1 andTag:integerTag andName:[super replaceString:secarchName]];
    [[BaseView baseShar]_initPop:formSelectView Type:1];
    formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
        _searchBar.text = @"";
        secarchName = @"";
        _searchBar.showsCancelButton = NO;
        [_searchBar resignFirstResponder];
        shopsListModel.系统商铺号=selectStr;
        textField2.text = selectStr;
    };
}
//获取系统楼盘编号和系统楼盘名称
-(void)netSysData:(int)page andTag:(NSInteger)integerInt andName:(NSString *)name{
    
    __weak typeof(self)SelfWeek=self;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",page],@"pageNo",@"10",@"pageSize", nil];
    if (integerInt == 1000) {
        [dict setObject:@"local" forKey:@"dateType"];
        [dict setObject:@"tradeLouceng" forKey:@"makeType"];
        [dict setObject:name forKey:@"floor"];
        if (self.taskID.length>1) {
            [dict setObject:self.taskID forKey:@"taskId"];
        }
        
        [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getLouceng.chtml" success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            
            [SelfWeek tableviewEnd];
            CommerciaEstateModel *systemModel = [[CommerciaEstateModel alloc]initWithDictionary:responseObject error:nil];
            if (systemModel) {
                if ([systemModel.status isEqualToString:@"1"]) {
                    if (page==1) {
                        [Arraykeys removeAllObjects];
                        [Arrayvalues removeAllObjects];
                        [ArrayAll removeAllObjects];
                        [ArrayNumber removeAllObjects];
                    }
                    for (CommerciaEstateListModel *systemListModel in systemModel.list) {
                        [ArrayAll addObject:[NSString stringWithFormat:@"%@ %@层",systemListModel.楼栋名称,systemListModel.楼层]];
                        [Arraykeys addObject:systemListModel.楼栋名称];
                        [Arrayvalues addObject:systemListModel.楼层];
                        [ArrayNumber addObject:systemListModel.楼栋编号];
                    }
                    formSelectTableView.formSelectArray=ArrayAll;
                }
            }
            
        } failure:^(NSError *error) {
            [SelfWeek tableviewEnd];
        }];
    }else{
        [dict setObject:@"system" forKey:@"dateType"];
        [dict setObject:@"tradeShangpu" forKey:@"makeType"];
        [dict setObject:[super replaceString:shopsListModel.楼栋编号] forKey:@"budingNo"];
        [dict setObject:[super replaceString:shopsListModel.楼层] forKey:@"louCengNo"];
        [dict setObject:name forKey:@"spNo"];

        if (self.taskID.length>1) {
            [dict setObject:self.taskID forKey:@"taskId"];
        }
        [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getShangpu.chtml" success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            
            [SelfWeek tableviewEnd];
            CommerciaEstateModel *systemModel = [[CommerciaEstateModel alloc]initWithDictionary:responseObject error:nil];
            if (systemModel) {
                if ([systemModel.status isEqualToString:@"1"]) {
                    if (page==1) {
                        [Arraykeys removeAllObjects];
                    }
                    for (CommerciaEstateListModel *systemListModel in systemModel.list) {
                        if (systemListModel.房号) {
                            [Arraykeys addObject:systemListModel.房号];
                        }
                    }
                    formSelectTableView.formSelectArray=Arraykeys;
                }
            }
            
        } failure:^(NSError *error) {
            [SelfWeek tableviewEnd];
        }];
    }
    
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
   [self netSysData:1 andTag:integerTag andName:[super replaceString:secarchName]];
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
    [self netSysData:1 andTag:integerTag andName:[super replaceString:secarchName]];
}
-(void)tableviewEnd{
    [formSelectTableView.mj_header endRefreshing];
    [formSelectTableView.mj_footer endRefreshing];
    
    [storeMarketView.shopsTableView.mj_header endRefreshing];
    [storeMarketView.shopsTableView.mj_footer endRefreshing];
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
