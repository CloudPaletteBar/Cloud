//
//  GroundBuilding2ViewController.m
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/8/25.
//  Copyright © 2016年 test. All rights reserved.
//

#import "GroundBuilding2ViewController.h"
#import "FormSelectTableView.h"
#import "MJRefresh.h"
#import "LowPropertyNameView.h"
#import "GongyeZongdiModel.h"
#import "GroundBuilding2Model.h"
#import "zySheetPickerView.h"
#import "SaveModel.h"
#import "MHDatePicker.h"
#import "POHViewController.h"
#import "UIImageView+WebCache.h"

@interface GroundBuilding2ViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UISearchBarDelegate>
{
    MHDatePicker *_selectDatePicker;
    FormSelectTableView *formSelectTableView;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    NSMutableArray *houseArray;
    NSString *houseYesNo;
    NSInteger integerTag;
    NSMutableArray  *IDs;
    
    NSMutableArray *buildingArray;
    GroundBuilding2ListModel *groundBuildingListModel;
    GroundBuilding2ListTypeModel *groundBuildingListTypeModel;
    GroundBuilding2ListType2Model *groundBuildingListType2Model;
    NSString *look;
    NSMutableArray *timeArray;
    NSMutableArray *louCengArray;
    NSMutableArray *zdnoArray;
    NSString *Url;
    
    //选择
    __weak IBOutlet UIButton *button1;
    __weak IBOutlet UIButton *button2;
    
    __weak IBOutlet UIButton *button3;
    __weak IBOutlet UIButton *button4;
    __weak IBOutlet UIButton *button5;
    __weak IBOutlet UIButton *button6;
    __weak IBOutlet UIButton *button7;
    __weak IBOutlet UIButton *button8;
    __weak IBOutlet UIButton *button9;
    __weak IBOutlet UIButton *button10;
    __weak IBOutlet UIButton *button11;
    __weak IBOutlet UIButton *button12;
    __weak IBOutlet UIButton *button13;
    __weak IBOutlet UIButton *button14;
    __weak IBOutlet UIButton *button15;
    
    
    __weak IBOutlet UISegmentedControl *segmented1;
    __weak IBOutlet UISegmentedControl *segmented2;
    __weak IBOutlet UISegmentedControl *segmented3;
    __weak IBOutlet UISegmentedControl *segmented4;
    __weak IBOutlet UISegmentedControl *segmented5;
    __weak IBOutlet UISegmentedControl *segmented6;
    __weak IBOutlet UISegmentedControl *segmented7;
    __weak IBOutlet UISegmentedControl *segmented8;
    __weak IBOutlet UISegmentedControl *segmented9;
    __weak IBOutlet UISegmentedControl *segmented17;
    
    __weak IBOutlet UISwitch *switch1;
    __weak IBOutlet UISwitch *switch2;
    __weak IBOutlet UISwitch *switch3;
    __weak IBOutlet UISwitch *switch4;
    __weak IBOutlet UISwitch *switch5;
    __weak IBOutlet UISwitch *switch6;
    
    __weak IBOutlet UITextField *textField1;
    __weak IBOutlet UITextField *textField2;
    __weak IBOutlet UITextField *textField3;
    __weak IBOutlet UITextField *textField4;
    
    __weak IBOutlet UITextField *textField5;
    __weak IBOutlet UITextField *textField6;
    __weak IBOutlet UITextField *textField7;
    __weak IBOutlet UITextField *textField8;
    __weak IBOutlet UITextField *textField9;
    __weak IBOutlet UITextField *textField10;
    __weak IBOutlet UITextField *textField11;
    __weak IBOutlet UITextField *textField12;
    __weak IBOutlet UITextField *textField13;
    
    
    
    __weak IBOutlet UIView *superV;
    __weak IBOutlet NSLayoutConstraint *superLayout;
    //厂房
    __weak IBOutlet UIView *changFangView;
    __weak IBOutlet UITextField *textField14;
   // __weak IBOutlet UITextField *textField15;
    __weak IBOutlet UIButton *button17;
    __weak IBOutlet UIButton *button18;
    //__weak IBOutlet UIButton *button19;//保存
    __weak IBOutlet UISegmentedControl *segmented15;
    __weak IBOutlet UISegmentedControl *segmented16;
    
    //仓储
    __weak IBOutlet UIView *cangChuView;
    __weak IBOutlet UITextField *textField16;
    //__weak IBOutlet UITextField *textField17;
    __weak IBOutlet UIButton *button20;
    __weak IBOutlet UIButton *button21;
   // __weak IBOutlet UIButton *button22;//保存
    __weak IBOutlet UISegmentedControl *segmented10;
    __weak IBOutlet UISegmentedControl *segmented11;
   
    //工业（办公）
    __weak IBOutlet UIView *gongYeView;
    __weak IBOutlet UISegmentedControl *segmented12;
   // __weak IBOutlet UIButton *button24;
    
    //工业（宿舍）
    __weak IBOutlet UIView *gongYeSusheView;
    __weak IBOutlet UISegmentedControl *segmented13;
    __weak IBOutlet UISegmentedControl *segmented14;
   // __weak IBOutlet UIButton *button25;
    
    //工业（其他）
    __weak IBOutlet UIView *gongYeQitaView;
    __weak IBOutlet UIButton *button16;//保存
    __weak IBOutlet UISwitch *switch7;
    __weak IBOutlet UISwitch *switch8;
    __weak IBOutlet UISwitch *switch9;
    __weak IBOutlet UISwitch *switch10;
    __weak IBOutlet UISwitch *switch11;
    
    __weak IBOutlet UISegmentedControl *segmented18;
    //无法调查
    __weak IBOutlet UIView *view3;
    __weak IBOutlet UITextField *textField19;
    __weak IBOutlet UIButton *button23;
    __weak IBOutlet UISwitch *switch12;
    
    
    __weak IBOutlet UIView *view1;
    __weak IBOutlet NSLayoutConstraint *viewH;
    
    __weak IBOutlet UIView *view2;
    
    __weak IBOutlet UIImageView *imageView1;
    NSString *secarchName;
    UIView *formSelectView;
}
@property (nonatomic ,strong)UISearchBar *searchBar;
@end

@implementation GroundBuilding2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layerButton];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gongYelouPanTolouDong:) name:@"gongYelouPanTolouDong" object:nil];
    _strId = [kUserDefaults objectForKey:@"industryId"];
    _taskId = [kUserDefaults objectForKey:@"taskIdIndustry"];
    buildingArray = [NSMutableArray arrayWithCapacity:1];
    IDs = [NSMutableArray arrayWithCapacity:1];
    look = [kUserDefaults objectForKey:@"工业查看"];
    if ([look isEqualToString:@"工业查看"]) {
        button23.hidden = YES;
        button16.hidden = YES;
    }
    
    if (_taskId.length<1) {
        viewH.constant = 170;
        switch12.hidden = YES;
    }
    
    self.contentView.frame = CGRectMake(0, 0, MainScreenWidth, self.contentView.frame.size.height);
    [self.buil2ScrollView addSubview:self.contentView];
    self.buil2ScrollView.contentSize = CGSizeMake(0, 1940);
    
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
    // Do any additional setup after loading the view from its nib.
}

-(void)gongYelouPanTolouDong:(NSNotification *)sender{
    textField1.text = [[sender object] objectForKey:@"实际楼盘名称"];
    
    groundBuildingListModel.工业楼盘名称 = textField1.text;
    groundBuildingListModel.宗地号 = [[sender object] objectForKey:@"宗地号"];
}

-(void)kNetworkListMake{
    NSDictionary *dcit;
    if (self.selectIndex==3) {
        if (self.taskId) {
            if (self.strId.length>1) {
                dcit = @{@"makeType":@"industryBuding",@"ID":self.strId,@"taskId":self.taskId};
            }else{
                dcit = @{@"makeType":@"industryBuding",@"taskId":self.taskId};
            }
        }else if (self.strId){
            dcit = @{@"makeType":@"industryBuding",@"ID":self.strId};
        }else{
            dcit = @{@"makeType":@"industryBuding"};
        }
    }else{
        dcit = @{@"ID":@"0"};
    }
    __weak typeof(self)SelfWeek=self;
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dcit relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        GroundBuilding2Model *groundBuildingModel = [[GroundBuilding2Model alloc]initWithDictionary:responseObject error:nil];
        groundBuildingListModel = [[GroundBuilding2ListModel alloc]init];
        groundBuildingListTypeModel = [[GroundBuilding2ListTypeModel alloc]init];
        groundBuildingListType2Model = [[GroundBuilding2ListType2Model alloc]init];
        
        if (groundBuildingModel) {
            [buildingArray addObjectsFromArray:groundBuildingModel.list];
        }else{
            [BaseView _init:@"亲你的网络不给力哦" View:SelfWeek.view];
        }
        if (buildingArray.count>0) {
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
    groundBuildingListTypeModel = [[GroundBuilding2ListTypeModel alloc]init];
    groundBuildingListType2Model = [[GroundBuilding2ListType2Model alloc]init];
    groundBuildingListModel.竣工时间准确性 = @"精确";
    groundBuildingListModel.成新率 = @"全新";
    groundBuildingListModel.电梯 = @"无";
    textField9.userInteractionEnabled=NO;
    groundBuildingListModel.建筑结构 = @"混合建筑";
    groundBuildingListModel.外墙装修情况 = @"条形砖";
    groundBuildingListModel.外墙保养情况 = @"好";
    groundBuildingListModel.内墙装修情况 = @"涂料";
    groundBuildingListModel.内墙保养情况 = @"好";
    groundBuildingListModel.天棚装修情况 = @"石膏板吊顶";
    groundBuildingListModel.天棚保养情况 = @"好";
    groundBuildingListModel.楼地面装修情况 = @"水泥";
    groundBuildingListModel.楼地面保养情况 = @"好";
    groundBuildingListModel.入户门装修情况 = @"防火门";
    groundBuildingListModel.入户门保养情况 = @"好";
    groundBuildingListModel.窗装修情况 = @"铝合金窗";
    groundBuildingListModel.窗保养情况 = @"好";
    groundBuildingListModel.物管公司数据来源 = @"业主/租户";
    groundBuildingListModel.物业管理费数据来源 = @"业主/租户";
    groundBuildingListModel.停车位 = @"无";
    textField12.userInteractionEnabled=NO;
    textField13.userInteractionEnabled=NO;
    groundBuildingListModel.配套服务设施 = @"完备";
    groundBuildingListModel.交通便捷度 = @"便捷";
    groundBuildingListModel.临街类型 = @"混合型主干道(城镇内部主要客货运输线)";
    groundBuildingListModel.楼栋类型 = @"厂房";
    [self hiddenView:@"厂房"];
    groundBuildingListModel.厂房仓储类型 = @"标准厂房";
    groundBuildingListModel.产业类型 = @"重工厂房";
    groundBuildingListModel.物管公司=@"无";
    textField10.userInteractionEnabled=NO;
    textField11.userInteractionEnabled=NO;

}

-(void)loadData{
    groundBuildingListModel = [buildingArray objectAtIndex:0];

    textField1.text = [super replaceString:groundBuildingListModel.工业楼盘名称];
//    groundBuildingListModel.工业楼盘ID = [super replaceString:[kUserDefaults objectForKey:@"industryId"]];
    textField2.text = [super replaceString:groundBuildingListModel.楼栋编号];
    textField3.text = [super replaceString:groundBuildingListModel.系统楼栋名称];
    textField4.text = [super replaceString:groundBuildingListModel.实际楼栋名称];
    
    if (self.taskId.length>1) {
        NSString *str1 = [super replaceString:groundBuildingListModel.无法调查说明];
        if (str1.length>1) {
            textField19.text = str1;
            [switch12 setOn:YES];
            [self selectSwitch:switch12];
            return;
        }
    }
    
    textField5.text = [super replaceString:groundBuildingListModel.竣工时间];
    NSString *str1 = [super replaceString:groundBuildingListModel.竣工时间准确性];
    if ([str1 isEqualToString:@"精确"]) {
        segmented1.selectedSegmentIndex = 0;
    }else{
        segmented1.selectedSegmentIndex = 1;
    }
    
    textField6.text = [super replaceString:groundBuildingListModel.楼栋总层数];
    textField7.text = [super replaceString:groundBuildingListModel.地上层数];
    textField8.text = [super replaceString:groundBuildingListModel.地下层数];
    
    [button3 setTitle:[super replaceString:groundBuildingListModel.成新率] forState:UIControlStateNormal];
    NSString *str2 = [super replaceString:groundBuildingListModel.电梯];
    if ([str2 isEqualToString:@"无"]) {
        segmented2.selectedSegmentIndex = 0;
        textField9.userInteractionEnabled=NO;
    }else{
        textField9.userInteractionEnabled=YES;
        segmented2.selectedSegmentIndex = 1;
    }
    textField9.text = [super replaceString:groundBuildingListModel.电梯数量];
    [button4 setTitle:[super replaceString:groundBuildingListModel.建筑结构] forState:UIControlStateNormal];
    [button5 setTitle:[super replaceString:groundBuildingListModel.外墙装修情况] forState:UIControlStateNormal];
    NSArray *array1 = @[@"好",@"较好",@"一般",@"较差",@"差"];
    NSString *str3 = [super replaceString:groundBuildingListModel.外墙保养情况];
    [array1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([str3 isEqual:obj]) {
            segmented3.selectedSegmentIndex = idx;
            *stop = YES;
        }
    }];
    
    [button6 setTitle:[super replaceString:groundBuildingListModel.内墙装修情况] forState:UIControlStateNormal];
    NSString *str4 = [super replaceString:groundBuildingListModel.内墙保养情况];
    [array1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([str4 isEqual:obj]) {
            segmented4.selectedSegmentIndex = idx;
            *stop = YES;
        }
    }];
    
    [button7 setTitle:[super replaceString:groundBuildingListModel.天棚装修情况] forState:UIControlStateNormal];
    NSString *str5 = [super replaceString:groundBuildingListModel.天棚保养情况];
    [array1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([str5 isEqual:obj]) {
            segmented5.selectedSegmentIndex = idx;
            *stop = YES;
        }
    }];
    
    [button8 setTitle:[super replaceString:groundBuildingListModel.楼地面装修情况] forState:UIControlStateNormal];
    NSString *str6 = [super replaceString:groundBuildingListModel.楼地面保养情况];
    [array1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([str6 isEqual:obj]) {
            segmented6.selectedSegmentIndex = idx;
            *stop = YES;
        }
    }];
    
    [button9 setTitle:[super replaceString:groundBuildingListModel.入户门装修情况] forState:UIControlStateNormal];
    NSString *str7 = [super replaceString:groundBuildingListModel.入户门保养情况];
    [array1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([str7 isEqual:obj]) {
            segmented7.selectedSegmentIndex = idx;
            *stop = YES;
        }
    }];
    
    [button10 setTitle:[super replaceString:groundBuildingListModel.窗装修情况] forState:UIControlStateNormal];
    NSString *str8 = [super replaceString:groundBuildingListModel.窗保养情况];
    [array1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([str8 isEqual:obj]) {
            segmented8.selectedSegmentIndex = idx;
            *stop = YES;
        }
    }];
    
    textField10.text = [super replaceString:groundBuildingListModel.物管公司名称];
    [button11 setTitle:[super replaceString:groundBuildingListModel.物管公司数据来源] forState:UIControlStateNormal];
    textField11.text = [super replaceString:groundBuildingListModel.物业管理费];
    [button12 setTitle:[super replaceString:groundBuildingListModel.物业管理费数据来源] forState:UIControlStateNormal];
    NSString *str30 = [super replaceString:groundBuildingListModel.物管公司];
    if ([str30 isEqualToString:@"无"]) {
        textField10.userInteractionEnabled=NO;
        textField11.userInteractionEnabled=NO;
        segmented18.selectedSegmentIndex = 0;
    }else{
        textField10.userInteractionEnabled=YES;
        textField11.userInteractionEnabled=YES;
        segmented18.selectedSegmentIndex = 1;
    }

    NSString *str9 = [super replaceString:groundBuildingListModel.停车位];
    if ([str9 isEqualToString:@"无"]) {
        textField12.userInteractionEnabled=NO;
        textField13.userInteractionEnabled=NO;
        segmented9.selectedSegmentIndex = 0;
    }else{
        textField12.userInteractionEnabled=YES;
        textField13.userInteractionEnabled=YES;
        segmented9.selectedSegmentIndex = 1;
    }
    textField12.text = [super replaceString:groundBuildingListModel.地上停车位];
    textField13.text = [super replaceString:groundBuildingListModel.地下停车位];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"500",@"电气",@"501",@"消防",@"502",@"给排水",@"503",@"弱电",@"504",@"空调",@"505",@"变配电", nil];
    NSArray *array2 = [self array:[super replaceString:groundBuildingListModel.设施安装情况]];
    [switch1 setOn:NO];
    [switch2 setOn:NO];
    [switch3 setOn:NO];
    [switch4 setOn:NO];
    [switch5 setOn:NO];
    [switch6 setOn:NO];
    for (NSString *str in array2) {
        NSString *strTag = [dict objectForKey:str];
        switch ([strTag intValue]) {
            case 500:
                [switch1 setOn:YES];
                groundBuildingListTypeModel.电气 = @"电气";
                break;
            case 501:
                [switch2 setOn:YES];
                groundBuildingListTypeModel.消防 = @"消防";
                break;
            case 502:
                [switch3 setOn:YES];
                groundBuildingListTypeModel.给排水 = @"给排水";
                break;
            case 503:
                [switch4 setOn:YES];
                groundBuildingListTypeModel.弱电 = @"弱电";
                break;
            case 504:
                [switch5 setOn:YES];
                groundBuildingListTypeModel.空调 = @"空调";
                break;
            case 505:
                [switch6 setOn:YES];
                groundBuildingListTypeModel.变配电 = @"变配电";
                break;
        }
    }

    NSString *str10 = [super replaceString:groundBuildingListModel.配套服务设施];
    if ([str10 isEqualToString:@"完备"]) {
        segmented17.selectedSegmentIndex = 0;
    }else if ([str10 isEqualToString:@"一般"]){
        segmented17.selectedSegmentIndex = 1;
    }else{
        segmented17.selectedSegmentIndex = 2;
    }
    
    [button13 setTitle:[super replaceString:groundBuildingListModel.交通便捷度] forState:UIControlStateNormal];
    [button14 setTitle:[super replaceString:groundBuildingListModel.临街类型] forState:UIControlStateNormal];
    NSString *str11 = [super replaceString:groundBuildingListModel.楼栋类型];
    [button15 setTitle:str11 forState:UIControlStateNormal];
    if ([str11 isEqualToString:@"厂房"]) {
        NSString *str12 = [super replaceString:groundBuildingListModel.厂房仓储类型];
        if ([str12 isEqualToString:@"标准厂房"]) {
            segmented15.selectedSegmentIndex = 0;
        }else{
            segmented15.selectedSegmentIndex = 1;
        }
        [button17 setTitle:[super replaceString:groundBuildingListModel.产业集聚度] forState:UIControlStateNormal];
        NSString *str14 = [super replaceString:groundBuildingListModel.产业类型];
        if ([str14 isEqualToString:@"重工厂房"]) {
            segmented16.selectedSegmentIndex = 0;
        }else{
            segmented16.selectedSegmentIndex = 1;
        }
        [button18 setTitle:[super replaceString:groundBuildingListModel.企业行业类别] forState:UIControlStateNormal];
        textField14.text = [super replaceString:groundBuildingListModel.企业名称];
        [self hiddenView:@"厂房"];
    }else if ([str11 isEqualToString:@"仓储"]){
        NSString *str12 = [super replaceString:groundBuildingListModel.厂房仓储类型];
        NSArray *array3 = @[@"单层仓库",@"多层仓库",@"立体仓库"];
        [array3 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([str12 isEqual:obj]) {
                segmented10.selectedSegmentIndex = idx;
                *stop = YES;
            }
        }];
        [button20 setTitle:[super replaceString:groundBuildingListModel.产业集聚度] forState:UIControlStateNormal];
        NSString *str14 = [super replaceString:groundBuildingListModel.产业类型];
        if ([str14 isEqualToString:@"普通货物仓库"]) {
            segmented11.selectedSegmentIndex = 0;
        }else{
            segmented11.selectedSegmentIndex = 1;
        }
        [button21 setTitle:[super replaceString:groundBuildingListModel.企业行业类别] forState:UIControlStateNormal];
        textField16.text = [super replaceString:groundBuildingListModel.企业名称];
        
        [self hiddenView:@"仓储"];
    }else if([str11 isEqualToString:@"工业配套办公"]){
        NSString *str12 = [super replaceString:groundBuildingListModel.办公装修档次];
        NSArray *array4 = @[@"好",@"一般",@"差"];
        [array4 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([str12 isEqual:obj]) {
                segmented12.selectedSegmentIndex = idx;
                *stop = YES;
            }
        }];
         [self hiddenView:@"工业配套办公"];
    }else if([str11 isEqualToString:@"工业配套宿舍"]){
        NSArray *array4 = @[@"好",@"一般",@"差"];
        NSString *str13 = [super replaceString:groundBuildingListModel.宿舍装修档次];
        [array4 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([str13 isEqual:obj]) {
                segmented13.selectedSegmentIndex = idx;
                *stop = YES;
            }
        }];
        
        NSString *str14 = [super replaceString:groundBuildingListModel.宿舍是否独立卫生间];
        if ([str14 isEqualToString:@"是"]) {
            segmented14.selectedSegmentIndex = 0;
        }else{
            segmented14.selectedSegmentIndex = 1;
        }
         [self hiddenView:@"工业配套宿舍"];
    }else{
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"506",@"食堂",@"507",@"变电房",@"508",@"门卫室",@"509",@"锅炉房",@"510",@"其他", nil];
        NSArray *array2 = [self array:[super replaceString:groundBuildingListModel.工业配套]];
        for (NSString *str in array2) {
            NSString *strTag = [dict objectForKey:str];
            switch ([strTag intValue]) {
                case 506:
                    [switch7 setOn:YES];
                    groundBuildingListType2Model.食堂 = @"食堂";
                    break;
                case 507:
                    [switch8 setOn:YES];
                    groundBuildingListType2Model.变电房 = @"变电房";
                    break;
                case 508:
                    [switch9 setOn:YES];
                    groundBuildingListType2Model.门卫室 = @"门卫室";
                    break;
                case 509:
                    [switch10 setOn:YES];
                    groundBuildingListType2Model.锅炉房 = @"锅炉房";
                    break;
                case 510:
                    [switch11 setOn:YES];
                    groundBuildingListType2Model.其他 = @"其他";
                    break;
            }
        }
        [self hiddenView:@"工业配套其它"];
    }
}

- (IBAction)selectButton:(UIButton *)sender {
    
    switch (sender.tag) {
        case 603:{
            NSArray *array = @[@"全新",@"八九成新",@"六七成新",@"六成以下"];
            [self clickArray:array andTag:603];
        }
            break;
        case 604:{
            NSArray *array = @[@"混合结构",@"框架结构",@"框剪结构",@"排架结构",@"钢结构"];
            [self clickArray:array andTag:604];
        }
            break;
        case 605:{
            NSArray *array = @[@"条形砖",@"马赛克",@"涂料",@"水刷石",@"清水墙",@"石材",@"玻璃幕墙",@"其他"];
            [self clickArray:array andTag:605];
        }
            break;
        case 606:{
            NSArray *array = @[@"涂料",@"瓷砖",@"石材",@"墙纸",@"镶板",@"其他"];
            [self clickArray:array andTag:606];
        }
            break;
        case 607:{
            NSArray *array = @[@"涂料",@"石膏板吊顶",@"吸音板",@"金属吊顶",@"其他"];
            [self clickArray:array andTag:607];
        }
            break;
        case 608:{
            NSArray *array = @[@"水泥",@"水刷石",@"瓷砖",@"地板",@"石材",@"地毯",@"其他"];
            [self clickArray:array andTag:608];
        }
            break;
        case 609:{
            NSArray *array = @[@"防火门",@"防盗门",@"拉闸门",@"自动感应门",@"铝合金门",@"其他"];
            [self clickArray:array andTag:609];
        }
            break;
        case 610:{
            NSArray *array = @[@"铝合金窗",@"塑钢窗",@"钢窗",@"其他"];
            [self clickArray:array andTag:610];
        }
            break;
        case 611:{
            NSArray *array = @[@"业主/租户",@"中介",@"网络查询",@"估计",@"其他"];
            [self clickArray:array andTag:611];
        }
            break;
        case 612:{
            NSArray *array = @[@"业主/租户",@"中介",@"网络查询",@"估计",@"其他"];
            [self clickArray:array andTag:612];
        }
            break;
        case 613:{
            NSArray *array = @[@"便捷",@"较便捷",@"一般",@"较差",@"差"];
            [self clickArray:array andTag:613];
        }
            break;
        case 614:{
            NSArray *array = @[@"混合型主干道(城镇内部主要客货运输线)",@"生活型主干道(城镇内部主要以客运为主的道路)",@"交通型主干道(城镇内部主要以货运和过境为主的道路)",@"生活型次干道(城镇内部主要以客运为主的道路)",@"交通型次干道(城镇内部主要以货运和过境为主的道路)",@"支路(各街坊之间的联系道路)"];
            [self clickArray:array andTag:614];
        }
            break;
        case 615:{
            NSArray *array = @[@"厂房",@"仓储",@"工业配套办公",@"工业配套宿舍",@"工业配套其它"];
            [self clickArray:array andTag:615];
        }
            break;
        case 616:
            //工业（办公） 保存按钮
            [self saveListMake];
            break;
        case 617:{
            NSArray *array = @[@"产业联系紧密区",@"产业联系一般区",@"产业联系松散区"];
            [self clickArray:array andTag:617];
        }
            break;
        case 618:{
            NSArray *array = @[@"食品、烟草、纺织服饰、皮革、木材、造纸印刷及娱乐用品制造业",@"医药、橡胶、塑料等制造业",@"计算机、通信和其他电子设备制造业",@"汽车、铁路、船舶、航空航天及其他运输设备制造业",@"通用设备、电气机械及器材、仪器仪表制造业",@"非金属矿物制品、金属冶炼及压延加工、金属制品业",@"石油、天然气开采及其辅助业",@"石油加工、化学原料及制品制造业",@"电力、热力、燃气生产和供应业",@"金属制品、机械和设备修理业",@"其他制造业"];
            [self clickArray:array andTag:618];
        }
            break;
        case 620:{
            NSArray *array = @[@"产业联系紧密区",@"产业联系一般区",@"产业联系松散区"];
            [self clickArray:array andTag:620];
        }
            break;
        case 621:{
            NSArray *array = @[@"食品、烟草、纺织服饰、皮革、木材、造纸印刷及娱乐用品制造业",@"医药、橡胶、塑料等制造业",@"计算机、通信和其他电子设备制造业",@"汽车、铁路、船舶、航空航天及其他运输设备制造业",@"通用设备、电气机械及器材、仪器仪表制造业",@"非金属矿物制品、金属冶炼及压延加工、金属制品业",@"石油、天然气开采及其辅助业",@"石油加工、化学原料及制品制造业",@"电力、热力、燃气生产和供应业",@"金属制品、机械和设备修理业",@"其他制造业"];
            [self clickArray:array andTag:621];
        }
            break;
        case 623:
            //无法调查   保存
            if ([textField19.text isEqualToString:@""]) {
                ALERT(@"", @"请填写无法调查说明", @"确定");
                return;
            }else{
                groundBuildingListModel.无法调查说明 = textField19.text;
            }
            
            if (!(groundBuildingListModel.工业楼盘名称.length>1)) {
                [BaseView _init:@"请选择楼盘名称" View:self.view];
            }else if (!(groundBuildingListModel.楼栋编号.length>1)){
                [BaseView _init:@"请选择楼栋编号" View:self.view];
            }else if (!(groundBuildingListModel.实际楼栋名称.length>1)){
                [BaseView _init:@"请填写实际楼栋名称" View:self.view];
            }else{
                [self kNetworkListMake2];
            }
            break;
    }
    
    NSString *imageStr = [super replaceString:groundBuildingListModel.楼栋外观照片];
    if (imageStr.length>1) {
        NSArray *array = [NetworkManager address:imageStr];
        if (array.count>0) {
            [imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,[array objectAtIndex:0]]] placeholderImage:nil];
        }
        
    }
}
-(void)clickArray:(NSArray *)array andTag:(int)tagInt{
    zySheetPickerView *pickerView = [zySheetPickerView ZYSheetStringPickerWithTitle:array andHeadTitle:@"" Andcall:^(zySheetPickerView *pickerView, NSString *choiceString) {
        
        switch (tagInt) {
            case 603:
                [button3 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.成新率 = choiceString;
                break;
            case 604:
                [button4 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.建筑结构 = choiceString;
                break;
            case 605:
                [button5 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.外墙装修情况 = choiceString;
                break;
            case 606:
                [button6 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.内墙装修情况 = choiceString;
                break;
            case 607:
                [button7 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.天棚装修情况 = choiceString;
                break;
            case 608:
                [button8 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.楼地面装修情况 = choiceString;                break;
            case 609:
                [button9 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.入户门装修情况 = choiceString;                break;
            case 610:
                [button10 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.窗装修情况 = choiceString;                break;
            case 611:
                [button11 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.物管公司数据来源 = choiceString;
                break;
            case 612:
                [button12 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.物业管理费数据来源 = choiceString;
                break;
            case 613:
                [button13 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.交通便捷度 = choiceString;
                break;
            case 614:
                [button14 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.临街类型 = choiceString;
                break;
            case 615:{
                [button15 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.楼栋类型 = choiceString;
                [self hiddenView:choiceString];
            }
                break;
            case 617:
                [button17 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.产业集聚度 = choiceString;
                break;
            case 618:
                [button18 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.企业行业类别 = choiceString;
                break;
            case 620:
                [button20 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.产业集聚度 = choiceString;                break;
            case 621:
                [button21 setTitle:choiceString forState:UIControlStateNormal];
                groundBuildingListModel.企业行业类别 = choiceString;
                break;
        }
        [pickerView dismissPicker];
    }];
    [pickerView show];
}

-(void)hiddenView:(NSString *)type{
    if ([type isEqualToString:@"厂房"]) {
        cangChuView.hidden = YES;
        gongYeView.hidden = YES;
        gongYeSusheView.hidden = YES;
        gongYeQitaView.hidden = YES;
        changFangView.hidden = NO;
        superLayout.constant = 250;

        groundBuildingListModel.厂房仓储类型 = [segmented15 titleForSegmentAtIndex:segmented15.selectedSegmentIndex];
        groundBuildingListModel.产业类型 = [segmented16 titleForSegmentAtIndex:segmented16.selectedSegmentIndex];
        groundBuildingListModel.产业集聚度 = button17.titleLabel.text;
        groundBuildingListModel.企业行业类别 = button18.titleLabel.text;
        groundBuildingListModel.企业名称 = textField14.text;
        
        self.buil2ScrollView.contentSize = CGSizeMake(0, 1940);
    }else if([type isEqualToString:@"仓储"]){
        changFangView.hidden = YES;
        gongYeView.hidden = YES;
        gongYeSusheView.hidden = YES;
        gongYeQitaView.hidden = YES;
        cangChuView.hidden = NO;
        superLayout.constant = 250;
        
        groundBuildingListModel.厂房仓储类型 = [segmented10 titleForSegmentAtIndex:segmented10.selectedSegmentIndex];
        groundBuildingListModel.产业类型 = [segmented11 titleForSegmentAtIndex:segmented11.selectedSegmentIndex];
        groundBuildingListModel.产业集聚度 = button20.titleLabel.text;
        groundBuildingListModel.企业行业类别 = button21.titleLabel.text;
        groundBuildingListModel.企业名称 = textField16.text;
        
        self.buil2ScrollView.contentSize = CGSizeMake(0, 1940);
    }else if([type isEqualToString:@"工业配套办公"]){
        changFangView.hidden = YES;
        cangChuView.hidden = YES;
        gongYeView.hidden = NO;
        gongYeSusheView.hidden = YES;
        gongYeQitaView.hidden = YES;
        superLayout.constant =  90;
        groundBuildingListModel.办公装修档次 = [segmented12 titleForSegmentAtIndex:segmented12.selectedSegmentIndex];
        
        self.buil2ScrollView.contentSize = CGSizeMake(0, 1840);
    }else if ([type isEqualToString:@"工业配套宿舍"]){
        changFangView.hidden = YES;
        cangChuView.hidden = YES;
        gongYeView.hidden = YES;
        gongYeSusheView.hidden = NO;
        gongYeQitaView.hidden = YES;
        superLayout.constant = 130;
        
        groundBuildingListModel.宿舍装修档次 = [segmented13 titleForSegmentAtIndex:segmented13.selectedSegmentIndex];
        groundBuildingListModel.宿舍是否独立卫生间 = [segmented14 titleForSegmentAtIndex:segmented14.selectedSegmentIndex];
        
        self.buil2ScrollView.contentSize = CGSizeMake(0, 1840);
    }else{
        changFangView.hidden = YES;
        cangChuView.hidden = YES;
        gongYeView.hidden = YES;
        gongYeSusheView.hidden = YES;
        gongYeQitaView.hidden = NO;
        superLayout.constant = 130;
        
        self.buil2ScrollView.contentSize = CGSizeMake(0, 1800);
    }
//  @[@"厂房",@"仓储",@"工业配套办公",@"工业配套宿舍",@"工业配套其它"];
}

-(NSArray *)array:(NSString *)str{
    NSArray *strArray;
    if (str.length>1) {
        strArray = [str componentsSeparatedByString:@","];
        return strArray;
    }
    return strArray;
}

-(IBAction)segmentedAction:(UISegmentedControl *)Seg{
    NSInteger index=Seg.selectedSegmentIndex;
    NSString *str = [Seg titleForSegmentAtIndex:Seg.selectedSegmentIndex];
    NSLog(@"%ld----%@-----%ld",index,str,Seg.tag);
    
    switch (Seg.tag) {
        case 801:
            groundBuildingListModel.竣工时间准确性 = str;
            break;
        case 802:{
            if (index==0) {
                textField9.userInteractionEnabled=NO;
            }else
                textField9.userInteractionEnabled=YES;
            groundBuildingListModel.电梯 = str;
        }
            
            break;
        case 803:
            groundBuildingListModel.外墙保养情况 = str;
            break;
        case 804:
            groundBuildingListModel.内墙保养情况 = str;
            break;
        case 805:
            groundBuildingListModel.天棚保养情况 = str;
            break;
        case 806:
            groundBuildingListModel.楼地面保养情况 = str;
            break;
        case 807:
            groundBuildingListModel.入户门保养情况 = str;
            break;
        case 808:
            groundBuildingListModel.窗保养情况 = str;
            break;
        case 809:
            {
                if (index==0) {
                    textField12.userInteractionEnabled=NO;
                    textField13.userInteractionEnabled=NO;
                }else{
                    textField12.userInteractionEnabled=YES;
                    textField13.userInteractionEnabled=YES;
                }
                groundBuildingListModel.停车位 = str;
                
            }
            break;
        case 810:
            groundBuildingListModel.厂房仓储类型 = str;
            break;
        case 811:
            groundBuildingListModel.产业类型 = str;
            break;
        case 812:
            groundBuildingListModel.办公装修档次 = str;
            break;
        case 813:
            groundBuildingListModel.宿舍装修档次 = str;
            break;
        case 814:
            groundBuildingListModel.宿舍是否独立卫生间 = str;
            break;
        case 815:
            groundBuildingListModel.厂房仓储类型 = str;
            break;
        case 816:
            groundBuildingListModel.产业类型 = str;
            break;
        case 817:
            groundBuildingListModel.配套服务设施 = str;
            break;
        case 818:{
            if (index==0) {
                textField10.userInteractionEnabled=NO;
                textField11.userInteractionEnabled=NO;
            }else{
                textField10.userInteractionEnabled=YES;
                textField11.userInteractionEnabled=YES;
            }
            groundBuildingListModel.物管公司 = str;
        }
            
            break;
    }
}

- (IBAction)selectSwitch:(UISwitch *)sender {
    switch (sender.tag) {
        case 500:
            if ([sender isOn]) {
                groundBuildingListTypeModel.电气 = @"电气";
            }else{
                groundBuildingListTypeModel.电气 = @"";
            }
            break;
        case 501:
            if ([sender isOn]) {
                groundBuildingListTypeModel.消防 = @"消防";
            }else{
                groundBuildingListTypeModel.消防 = @"";
            }
            break;
        case 502:
            if ([sender isOn]) {
                groundBuildingListTypeModel.给排水 = @"给排水";
            }else{
                groundBuildingListTypeModel.给排水 = @"";
            }
            break;
        case 503:
            if ([sender isOn]) {
                groundBuildingListTypeModel.弱电 = @"弱电";
            }else{
                groundBuildingListTypeModel.弱电 = @"";
            }
            break;
        case 504:
            if ([sender isOn]) {
                groundBuildingListTypeModel.空调 = @"空调";
            }else{
                groundBuildingListTypeModel.空调 = @"";
            }
            break;
        case 505:
            if ([sender isOn]) {
                groundBuildingListTypeModel.变配电 = @"变配电";
            }else{
                groundBuildingListTypeModel.变配电 = @"";
            }
            break;
        case 506:
            if ([sender isOn]) {
                groundBuildingListType2Model.食堂 = @"食堂";
            }else{
                groundBuildingListType2Model.食堂 = @"";
            }
            break;
        case 507:
            if ([sender isOn]) {
                groundBuildingListType2Model.变电房 = @"变电房";
            }else{
                groundBuildingListType2Model.变电房 = @"";
            }
            break;
        case 508:
            if ([sender isOn]) {
                groundBuildingListType2Model.门卫室 = @"门卫室";
            }else{
                groundBuildingListType2Model.门卫室 = @"";
            }
            break;
        case 509:
            if ([sender isOn]) {
                groundBuildingListType2Model.锅炉房 = @"锅炉房";
            }else{
                groundBuildingListType2Model.锅炉房 = @"";
            }
            break;
        case 510:
            if ([sender isOn]) {
                groundBuildingListType2Model.其他 = @"其他";
            }else{
                groundBuildingListType2Model.其他 = @"";
            }
            break;
        case 511:
            textField19.text = @"";
            groundBuildingListModel.无法调查说明 = @"";
            if ([sender isOn]) {
                view2.hidden = YES;
                view3.hidden = NO;
                self.buil2ScrollView.contentSize = CGSizeMake(0, 322);
            }else{
                view2.hidden = NO;
                view3.hidden = YES;
                self.buil2ScrollView.contentSize = CGSizeMake(0, 1940);
            }
            break;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 703:{
            groundBuildingListModel.实际楼栋名称 = textField.text;
        }
            break;
        case 704:{
            groundBuildingListModel.无法调查说明 = textField.text;
        }
            break;
        case 705:{
            groundBuildingListModel.竣工时间 = textField.text;
        }
            break;
        case 706:{
            groundBuildingListModel.楼栋总层数 = textField.text;
        }
            break;
        case 707:{
            groundBuildingListModel.地上层数 = textField.text;
        }
            break;
        case 708:{
            groundBuildingListModel.地下层数 = textField.text;
        }
            break;
        case 709:{
            groundBuildingListModel.电梯数量 = textField.text;
        }
            break;
        case 710:{
            groundBuildingListModel.物管公司名称 = textField.text;
        }
            break;
        case 711:{
            groundBuildingListModel.物业管理费 = textField.text;
        }
            break;
        case 712:{
            groundBuildingListModel.地上停车位 = textField.text;
        }
            break;
        case 713:{
            groundBuildingListModel.地下停车位 = textField.text;
        }
            break;
        case 714:{
            groundBuildingListModel.企业名称 = textField.text;
        }
            break;
        case 715:{
            groundBuildingListModel.备注 = textField.text;
        }
            break;
        case 716:{
            groundBuildingListModel.企业名称 = textField.text;
        }
            break;
        case 717:{
            groundBuildingListModel.备注 = textField.text;
        }
            break;
        case 718:{
            groundBuildingListModel.备注 = textField.text;
        }
            break;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}

-(IBAction)timePicker:(UIButton *)sender{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    _selectDatePicker = [[MHDatePicker alloc] init];
    _selectDatePicker.isBeforeTime = YES;
    _selectDatePicker.datePickerMode = UIDatePickerModeDate;
    
    [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
        
        NSString *timeStr = [NSString stringWithFormat:@"%@",selectedDate];
        NSLog(@"%@",timeStr);
        textField5.text = [timeStr substringToIndex:10];
        groundBuildingListModel.竣工时间 = textField5.text;
    }];
}

- (IBAction)selectNumber1:(id)sender {
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
    formSelectTableView.formSelectArray=nil;
    Arraykeys=[[NSMutableArray alloc]init];
    Arrayvalues=[[NSMutableArray alloc]init];
    zdnoArray=[[NSMutableArray alloc]init];
    integerTag = 1000;
    [self netSysData:1 andTag:integerTag andName:[super replaceString:secarchName]];
    [[BaseView baseShar]_initPop:formSelectView Type:1];
    formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
        _searchBar.text = @"";
        secarchName = @"";
        _searchBar.showsCancelButton = NO;
        [_searchBar resignFirstResponder];
        groundBuildingListModel.工业楼盘名称 = [NetworkManager interceptStrFrom1:selectStr PleStr:@" "];
        groundBuildingListModel.工业楼盘ID = [Arrayvalues objectAtIndex:Index];
        groundBuildingListModel.宗地号=[zdnoArray objectAtIndex:Index];
        textField1.text = [NetworkManager interceptStrFrom1:selectStr PleStr:@" "];
    };
}

- (IBAction)selectNumber2:(id)sender {
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
    if (textField1.text.length<1) {
        ALERT(@"", @"请先选择楼盘", @"确定");
        return;
    }
    formSelectTableView.formSelectArray=nil;
    Arraykeys=[[NSMutableArray alloc]init];
    Arrayvalues=[[NSMutableArray alloc]init];
    timeArray=[[NSMutableArray alloc]init];
    louCengArray=[[NSMutableArray alloc]init];
    houseArray = [[NSMutableArray alloc] init];
    integerTag = 1001;
    [self netSysData:1 andTag:integerTag andName:[super replaceString:secarchName]];
    [[BaseView baseShar]_initPop:formSelectView Type:1];
    formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
        _searchBar.text = @"";
        secarchName = @"";
        _searchBar.showsCancelButton = NO;
        [_searchBar resignFirstResponder];
        groundBuildingListModel.系统楼栋名称 = selectStr;
        groundBuildingListModel.楼栋编号 = [Arrayvalues objectAtIndex:Index];
        NSLog(@"%@",[timeArray objectAtIndex:Index]);
        groundBuildingListModel.竣工时间 = [NetworkManager interceptStrTo:[timeArray objectAtIndex:Index] PleStr:@" "];
        groundBuildingListModel.楼栋总层数=[louCengArray objectAtIndex:Index];
        textField2.text = [Arrayvalues objectAtIndex:Index];
        textField3.text = selectStr;
        textField5.text =groundBuildingListModel.竣工时间;
        textField6.text =groundBuildingListModel.楼栋总层数;
        houseYesNo = [houseArray objectAtIndex:Index];
        groundBuildingListModel.是否独栋 = [houseArray objectAtIndex:Index];
    };
}

//获取系统楼盘编号和系统楼盘名称
-(void)netSysData:(int)page andTag:(NSInteger)integerInt andName:(NSString *)name{
    
    __weak typeof(self)SelfWeek=self;
    NSDictionary *dict;
    if (integerInt == 1000) {
        if (self.taskId.length>0) {
            dict = @{@"makeType":@"industryLoupan",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"taskId":self.taskId,@"zdno":[super replaceString:groundBuildingListModel.宗地号],@"louPanName":name} ;
        }else{
            dict = @{@"makeType":@"industryLoupan",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"zdno":[super replaceString:groundBuildingListModel.宗地号],@"louPanName":name};
        }
        [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getLoupan.chtml" success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            
            [SelfWeek tableviewEnd];
            GongyeZongdiModel *systemModel = [[GongyeZongdiModel alloc]initWithDictionary:responseObject error:nil];
            if (systemModel) {
                if ([systemModel.status isEqualToString:@"1"]) {
                    if (page==1) {
                        [Arraykeys removeAllObjects];
                        [Arrayvalues removeAllObjects];
                        [timeArray removeAllObjects];
                        [louCengArray removeAllObjects];
                    }
                    for (GongyeZongdiListModel *systemListModel in systemModel.list) {
                        if (systemListModel.实际楼盘名称) {
                            [Arraykeys addObject:[NSString stringWithFormat:@"%@ %@",systemListModel.宗地号,systemListModel.实际楼盘名称]];
                        }else
                        [Arraykeys addObject:[NSString stringWithFormat:@"%@",systemListModel.宗地号]];
                        [Arrayvalues addObject:systemListModel.ID];
                        [zdnoArray addObject:[super replaceString:systemListModel.宗地号]];
                    }
                    formSelectTableView.formSelectArray=Arraykeys;
                }
            }
            
        } failure:^(NSError *error) {
            [SelfWeek tableviewEnd];
        }];
    }else{
        if (self.taskId.length>0) {
            dict = @{@"makeType":@"industryBuding",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"taskId":self.taskId,@"zdno":[super replaceString:groundBuildingListModel.宗地号],@"budingName":name};
        }else{
            dict = @{@"makeType":@"industryBuding",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"zdno":[super replaceString:groundBuildingListModel.宗地号],@"budingName":name};
        }
        [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getBuding.chtml" success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            
            [SelfWeek tableviewEnd];
            GongyeZongdiModel *systemModel = [[GongyeZongdiModel alloc]initWithDictionary:responseObject error:nil];
            if (systemModel) {
                if ([systemModel.status isEqualToString:@"1"]) {
                    if (page==1) {
                        [Arraykeys removeAllObjects];
                        [Arrayvalues removeAllObjects];
                        [timeArray removeAllObjects];
                        [louCengArray removeAllObjects];
                        [houseArray removeAllObjects];
                    }
                    for (GongyeZongdiListModel *systemListModel in systemModel.list) {
                        [Arraykeys addObject:systemListModel.系统楼栋名称];
                        [Arrayvalues addObject:systemListModel.楼栋编号];
                        [timeArray addObject:systemListModel.CONST_ENDDATE];
                        [louCengArray addObject:systemListModel.BLDG_FLOORS];
                        [houseArray addObject:systemListModel.是否独栋];
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

    [self netSysData:1 andTag:integerTag andName:secarchName];
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
    [self netSysData:1 andTag:integerTag andName:secarchName];
}

-(void)tableviewEnd{
    [formSelectTableView.mj_header endRefreshing];
    [formSelectTableView.mj_footer endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layerButton{
    [self layerView:button1];
    [self layerView:button2];
    [self layerView:button3];
    [self layerView:button4];
    [self layerView:button5];
    [self layerView:button6];
    [self layerView:button7];
    [self layerView:button8];
    [self layerView:button9];
    [self layerView:button10];
    [self layerView:button11];
    [self layerView:button12];
    [self layerView:button13];
    [self layerView:button14];
    [self layerView:button15];
    [self layerView:button16];
    [self layerView:button17];
    [self layerView:button18];
    [self layerView:button20];
    [self layerView:button21];
    [self layerView:button23];
}

-(void)layerView:(UIView *)view{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0;
}

-(void)saveListMake{
    if (!(groundBuildingListModel.工业楼盘名称.length>0)) {
        [BaseView _init:@"请选择楼盘名称" View:self.view];
    }else if (!(groundBuildingListModel.楼栋编号.length>0)){
        [BaseView _init:@"请选择楼栋编号" View:self.view];
    }else if (!(groundBuildingListModel.实际楼栋名称.length>0)){
        [BaseView _init:@"请填写实际楼栋名称" View:self.view];
    }else if(!(groundBuildingListModel.竣工时间.length>0)){
        [BaseView _init:@"请填写竣工时间" View:self.view];
    }else if(!(groundBuildingListModel.楼栋总层数.length>0)){
        [BaseView _init:@"请填写楼栋总层数" View:self.view];
    }else if ([NetworkManager address:groundBuildingListModel.楼栋外观照片].count<1 ){
        [BaseView _init:@"楼栋外观照片1-3张" View:self.view];
    }else{
        [self kNetworkListMake2];
    }
}

-(void)kNetworkListMake2{
    
    groundBuildingListModel.设施安装情况=[NetworkManager Datastrings:[groundBuildingListTypeModel.toDictionary allValues]];
    groundBuildingListModel.工业配套=[NetworkManager Datastrings:[groundBuildingListType2Model.toDictionary allValues]];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:groundBuildingListModel.toDictionary];
    [dict setObject:@"industryBuding" forKey:@"makeType"];
    if (self.taskId) {
        [dict setObject:self.taskId forKey:@"taskId"];
    }else if (self.strId){
        [dict setObject:self.strId forKey:@"id"];
    }
    
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"保存中..."];
    
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appAction!saveMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        SaveModel *saveModel=[[SaveModel alloc]initWithDictionary:responseObject error:nil];
        if (saveModel) {
            if ([saveModel.status isEqualToString:@"1"]) {
                for (NSArray *numbers in IDs) {
                    for (NSNumber *number in numbers) {
                        [[NetworkManager shar]updata:[number longLongValue] FormID:saveModel.ID TackId:self.taskId];
                    }
                }
                [BaseView _init:saveModel.message View:SelfWeek.view];
                groundBuildingListModel.ID = saveModel.ID;
                [kUserDefaults setObject:[super replaceString:saveModel.ID] forKey:@"industryId"];
                groundBuildingListModel.ID=[super replaceString:saveModel.ID];
                if ([look isEqualToString:@"工业新增"]) {
                    //0就不是 1就是（留在当前页面）
                    if (self.taskId) {
                        if ([houseYesNo isEqualToString:@"0"]) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"gongYelouDongTolouCeng" object:@{@"工业楼盘":[super replaceString:textField1.text],@"工业楼栋":[super replaceString:textField4.text],@"工业楼栋编号":[super replaceString:textField2.text]}];
                            
                            UIScrollView *scrollView=(UIScrollView *)self.view.superview;
                            CGFloat offsetX = scrollView.contentOffset.x + scrollView.frame.size.width;
                            offsetX = (int)(offsetX/MainScreenWidth) * MainScreenWidth;
                            [scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
                        }
                    }else{
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"gongYelouDongTolouCeng" object:@{@"工业楼盘":[super replaceString:textField1.text],@"工业楼栋":[super replaceString:textField4.text],@"工业楼栋编号":[super replaceString:textField2.text]}];
                            
                        UIScrollView *scrollView=(UIScrollView *)self.view.superview;
                        CGFloat offsetX = scrollView.contentOffset.x + scrollView.frame.size.width;
                        offsetX = (int)(offsetX/MainScreenWidth) * MainScreenWidth;
                        [scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
                    }
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(IBAction)pushImageController:(id)sender{
    POHViewController *pOHViewController=[[POHViewController alloc]initWithNibName:@"POHViewController" bundle:nil];
    NSMutableArray *PHarray=[NetworkManager address:groundBuildingListModel.楼栋外观照片];
    if (PHarray.count==0) {
        PHarray = [NSMutableArray arrayWithCapacity:1];
    }
    pOHViewController.PHOarray=PHarray;
    pOHViewController.successfulIndex = PHarray.count;
    
    if ([look isEqualToString:@"工业查看"]) {
        pOHViewController.type = @"查看";
    }
    
    [self.navigationController pushViewController:pOHViewController animated:YES];
    pOHViewController.ClockSave=^(NSArray *ArrayID,NSString *ImageUrl){
        groundBuildingListModel.楼栋外观照片=ImageUrl;
        [IDs removeAllObjects];
        [IDs addObject:ArrayID];
        Url=[NetworkManager jiequStr:ImageUrl rep:@","];
        [NetworkManager _initSdImage:Url ImageView:imageView1];
    };
    pOHViewController.imageType=@"楼栋位置图";
    pOHViewController.orderType=@"tradeLoupan";
    pOHViewController.ID=groundBuildingListModel.ID;
    pOHViewController.stakID=self.taskId;
    pOHViewController.selectMax=3;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
