//
//  FloorViewController.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import "FloorViewController.h"
#import "FloorModel.h"
#import "StoreyView.h"
#import "BuildingView2.h"
#import "SaveModel.h"
#import "FormSelectTableView.h"
#import "CommerciaEstateModel.h"
#import "MJRefresh.h"
#import "LowPropertyNameView.h"
#import "PhotoPickerViewController.h"
#import "UIImageView+WebCache.h"
#import "POHViewController.h"

@interface FloorViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UISearchBarDelegate>
{
    FormSelectTableView *formSelectTableView;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    BuildingView2 *buildingView2;
    StoreyView *storeyView;
    FloorListModel *floorListModel;
    FloorListTypeModel *floorListTypeModel;
    NSMutableArray *floorArray;
    NSArray *imageArrays;
    NSMutableArray *IDs;
    NSMutableArray  *businessTypeArray, *businessTypeArray1, *businessTypeArray2, *businessTypeArray3,*businessTypeArray4;
    NSString *look;
    NSString *Url;
    NSString *shangyeLouPan;
    
    __weak IBOutlet UITextField *textfield15;
    __weak IBOutlet UITextField *textfield16;
    
    
    IBOutlet UIView *view2;
    __weak IBOutlet UISwitch *switch1;
    __weak IBOutlet UISwitch *switch2;
    __weak IBOutlet UISwitch *switch3;
    __weak IBOutlet UISwitch *switch4;
    __weak IBOutlet UISwitch *switch5;
    IBOutlet UIView *view22;
    __weak IBOutlet UISegmentedControl *segmented1;
    __weak IBOutlet UISegmentedControl *segmented2;
    __weak IBOutlet UITextField *textfield1;
    __weak IBOutlet UITextField *textfield2;
    

    IBOutlet UIView *view3;
    __weak IBOutlet UISwitch *switch6;
    __weak IBOutlet UISwitch *switch7;
    IBOutlet UIView *view33;
    __weak IBOutlet UITextField *textfield3;
    __weak IBOutlet UITextField *textfield4;
    __weak IBOutlet UITextField *textfield5;
    __weak IBOutlet UITextField *textfield6;
    __weak IBOutlet UITextField *textfield7;
    __weak IBOutlet UITextField *textfield8;
    __weak IBOutlet UITextField *textfield9;
    __weak IBOutlet UISegmentedControl *segmented3;
    __weak IBOutlet UISegmentedControl *segmented4;
    
    
    IBOutlet UIView *view4;
    __weak IBOutlet UISwitch *switch8;
    IBOutlet UIView *view44;
    __weak IBOutlet UITextField *textfield10;
    __weak IBOutlet UITextField *textfield11;
    __weak IBOutlet UISegmentedControl *segmented5;
    
    
    IBOutlet UIView *view5;
    __weak IBOutlet UISwitch *switch9;
    IBOutlet UIView *view55;
    __weak IBOutlet UITextField *textfield12;
    __weak IBOutlet UITextField *textfield13;
    __weak IBOutlet UITextField *textfield14;
    __weak IBOutlet UISegmentedControl *segmented6;
    __weak IBOutlet UISegmentedControl *segmented7;
    
    IBOutlet UIView *view6;
    
    __weak IBOutlet UIButton *button1;
    __weak IBOutlet UIButton *button2;
    __weak IBOutlet UIImageView *imageView;
    NSString *secarchName;
    UIView *formSelectView;
}
@property (nonatomic ,strong)UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view2Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view2Height2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view3Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view3Height3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view4Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view4Height4;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view5Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view5Height5;

@end



@implementation FloorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shangYeLouDongToLouCeng:) name:@"shangYeLouDongToLouCeng" object:nil];
    
    IDs=[[NSMutableArray alloc]init];
    _strId = [super replaceString:[kUserDefaults objectForKey:@"businessId"]];
    _taskID = [super replaceString:[kUserDefaults objectForKey:@"taskId"]];
    floorArray = [NSMutableArray arrayWithCapacity:1];
    
    look = [kUserDefaults objectForKey:@"商业查看"];
    if ([look isEqualToString:@"商业查看"]) {
        button2.hidden = YES;
    }

    self.contentView.frame = CGRectMake(0, 0, MainScreenWidth, self.contentView.frame.size.height);
    [self.buil3ScrollView addSubview:self.contentView];
    self.buil3ScrollView.contentSize = CGSizeMake(0, 630);
    
    [self viewHeight:_view2Height andHeight:160];
    [self viewHeight:_view2Height2 andHeight:0];
    [self viewHeight:_view3Height andHeight:78];
    [self viewHeight:_view3Height3 andHeight:0];
    [self viewHeight:_view4Height andHeight:70];
    [self viewHeight:_view4Height4 andHeight:0];
    [self viewHeight:_view5Height andHeight:70];
    [self viewHeight:_view5Height5 andHeight:0];
    
    view22.hidden = YES;
    view33.hidden = YES;
    view44.hidden = YES;
    view55.hidden = YES;
    
    [self layerView:button1];
    [self layerView:button2];
    
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
    
    [self kNetworkListMake];
}

-(void)shangYeLouDongToLouCeng:(NSNotification *)sender{
    textfield15.text = [[sender object]objectForKey:@"商业楼栋"];
    floorListModel.楼栋名称 = textfield15.text;
    floorListModel.楼栋编号 = [[sender object]objectForKey:@"商业楼栋编号"];
    shangyeLouPan = [[sender object]objectForKey:@"商业楼盘"];
}

-(void)layerView:(UIView *)view{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0;
}

-(void)kNetworkListMake{
    NSDictionary *dcit;
    if (self.selectIndex==2) {
        if (self.taskID.length>1) {
            dcit = @{@"makeType":@"tradeLouceng",@"ID":self.strId,@"taskId":self.taskID};
        }else if(self.strId.length>1){
            dcit = @{@"makeType":@"tradeLouceng",@"ID":self.strId};
        }else{
            dcit = @{@"makeType":@"tradeLouceng"};
        }
    }else{
        dcit = @{@"ID":@"0"};
    }
    __weak typeof(self)SelfWeek=self;
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dcit relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        FloorModel *floorModel = [[FloorModel alloc]initWithDictionary:responseObject error:nil];
        floorListModel = [[FloorListModel alloc]init];
        if (floorModel) {
            [floorArray addObjectsFromArray:floorModel.list];
        }else{
            [BaseView _init:@"亲你的网络不给力哦" View:SelfWeek.view];
        }
        if (floorArray.count>0) {
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
    floorListTypeModel = [[FloorListTypeModel alloc]init];
    businessTypeArray1 = [NSMutableArray arrayWithCapacity:1];
    businessTypeArray2 = [NSMutableArray arrayWithCapacity:1];
    businessTypeArray3 = [NSMutableArray arrayWithCapacity:1];
    businessTypeArray4 = [NSMutableArray arrayWithCapacity:1];
}

-(void)loadData{
    floorListModel = [floorArray objectAtIndex:0];
    floorListTypeModel = [[FloorListTypeModel alloc]initWithDictionary:[NetworkManager stringDictionary:floorListModel.商业类型] error:nil];
    
    textfield15.text = [super replaceString:floorListModel.楼栋名称];
    textfield16.text = [super replaceString:floorListModel.楼层];
    
    businessTypeArray1 = [NSMutableArray arrayWithArray:[self array:floorListModel.商品零售业态]];
    businessTypeArray2 = [NSMutableArray arrayWithArray:[self array:floorListModel.餐饮零售业态]];
    businessTypeArray3 = [NSMutableArray arrayWithArray:[self array:floorListModel.服务零售业态]];
    businessTypeArray4 = [NSMutableArray arrayWithArray:[self array:floorListModel.商场主营品种]];
    
    NSArray *array1 = @[@"毛坯",@"简装",@"精装"];
    NSArray *array2 = @[@"只租不售",@"只售不租",@"租售混合"];
    NSArray *array3 = @[@"高级",@"中级",@"低级"];
    NSString *typeStr = [super replaceString:floorListModel.市场装修情况];
    if (typeStr.length>0) {
        for (int i=0; i<array1.count; i++) {
            NSString *str6 = [array1 objectAtIndex:i];
            if ([str6 isEqualToString:typeStr]) {
                segmented1.selectedSegmentIndex = i;
            }
        }
    }
    NSString *typeStr2 = [super replaceString:floorListModel.市场经营方式];
    if (typeStr2.length>0) {
        for (int i=0; i<array2.count; i++) {
            NSString *str6 = [array2 objectAtIndex:i];
            if ([str6 isEqualToString:typeStr2]) {
                segmented2.selectedSegmentIndex = i;
            }
        }
    }
    textfield1.text = [super replaceString:floorListModel.市场层高];
    textfield2.text = [super replaceString:floorListModel.市场空置率];
    
    textfield3.text = [super replaceString:floorListModel.商品零售比例];
    textfield4.text = [super replaceString:floorListModel.餐饮零售比例];
    textfield5.text = [super replaceString:floorListModel.服务零售比例];
    textfield6.text = [super replaceString:floorListModel.商场代表品牌];
    textfield7.text = [super replaceString:floorListModel.商场整层面积];
    textfield8.text = [super replaceString:floorListModel.商场层高];
    textfield9.text = [super replaceString:floorListModel.商场空置率];
    NSString *typeStr3 = [super replaceString:floorListModel.商场装修情况];
    if (typeStr3.length>0) {
        for (int i=0; i<array1.count; i++) {
            NSString *str6 = [array1 objectAtIndex:i];
            if ([str6 isEqualToString:typeStr3]) {
                segmented3.selectedSegmentIndex = i;
            }
        }
    }
    NSString *typeStr4 = [super replaceString:floorListModel.商场经营方式];
    if (typeStr4.length>0) {
        for (int i=0; i<array2.count; i++) {
            NSString *str6 = [array2 objectAtIndex:i];
            if ([str6 isEqualToString:typeStr4]) {
                segmented4.selectedSegmentIndex = i;
            }
        }
    }
    
    textfield10.text = [super replaceString:floorListModel.酒店层高];
    textfield11.text = [super replaceString:floorListModel.酒店整层面积];
    NSString *typeStr5 = [super replaceString:floorListModel.酒店装修情况];
    if (typeStr5.length>0) {
        for (int i=0; i<array3.count; i++) {
            NSString *str6 = [array3 objectAtIndex:i];
            if ([str6 isEqualToString:typeStr5]) {
                segmented5.selectedSegmentIndex = i;
            }
        }
    }
    
    textfield12.text = [super replaceString:floorListModel.大型超市整层面积];
    textfield13.text = [super replaceString:floorListModel.大型超市层高];
    textfield14.text = [super replaceString:floorListModel.大型超市空置率];
    NSString *typeStr6 = [super replaceString:floorListModel.大型超市装修情况];
    if (typeStr6.length>0) {
        for (int i=0; i<array3.count; i++) {
            NSString *str6 = [array3 objectAtIndex:i];
            if ([str6 isEqualToString:typeStr6]) {
                segmented6.selectedSegmentIndex = i;
            }
        }
    }
    NSString *typeStr7 = [super replaceString:floorListModel.大型超市经营方式];
    if (typeStr7.length>0) {
        for (int i=0; i<array2.count; i++) {
            NSString *str6 = [array2 objectAtIndex:i];
            if ([str6 isEqualToString:typeStr7]) {
                segmented7.selectedSegmentIndex = i;
            }
        }
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"500",@"裙楼商铺",@"501",@"专业市场",@"502",@"综合市场",@"503",@"地下商场",@"504",@"其他",@"505",@"购物中心",@"506",@"百货商场",@"507",@"宾馆酒店",@"508",@"大型超市", nil];
    businessTypeArray = [NSMutableArray arrayWithArray:[self array:floorListModel.商业类型]];
    for (NSString *str in businessTypeArray) {
        NSString *strTag = [dict objectForKey:str];
        switch ([strTag intValue]) {
            case 500:
                [switch1 setOn:YES];
                [self clickSwitch:switch1];
                break;
            case 501:
                [switch2 setOn:YES];
                [self clickSwitch:switch2];
                break;
            case 502:
                [switch3 setOn:YES];
                [self clickSwitch:switch3];
                break;
            case 503:
                [switch4 setOn:YES];
                [self clickSwitch:switch4];
                break;
            case 504:
                [switch5 setOn:YES];
                [self clickSwitch:switch5];
                break;
            case 505:
                [switch6 setOn:YES];
                [self clickSwitch3:switch6];
                break;
            case 506:
                [switch7 setOn:YES];
                [self clickSwitch3:switch7];
                break;
            case 507:
                [switch8 setOn:YES];
                [self clickSwitch4:switch8];
                break;
            case 508:
                [switch9 setOn:YES];
                [self clickSwitch5:switch9];
                break;
        }
    }
    
    NSString *imageStr = [super replaceString:floorListModel.楼层平面图];
    if (imageStr.length>1) {
        NSArray *array = [NetworkManager address:imageStr];
        if (array.count>0) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,[array objectAtIndex:0]]] placeholderImage:nil];
        }
    }
}

-(IBAction)segmentedAction:(UISegmentedControl *)Seg{
    NSInteger index=Seg.selectedSegmentIndex;
    NSString *str = [Seg titleForSegmentAtIndex:Seg.selectedSegmentIndex];
    NSLog(@"%ld----%@-----%ld",index,str,Seg.tag);
    
    switch (Seg.tag) {
        case 600:
            floorListModel.市场装修情况 = str;
            break;
        case 601:
            floorListModel.市场经营方式 = str;
            break;
        case 602:
            floorListModel.商场装修情况 = str;
            break;
        case 603:
            floorListModel.商场经营方式 = str;
            break;
        case 604:
            floorListModel.酒店装修情况 = str;
            break;
        case 605:
            floorListModel.大型超市装修情况 = str;
            break;
        case 606:
            floorListModel.大型超市经营方式 = str;
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

-(NSString *)Datastrings:(NSArray *)dataStrings{
    return [dataStrings componentsJoinedByString:@","];
}

-(void)viewHeight:(NSLayoutConstraint *)view andHeight:(CGFloat)height{
    view.constant = height;
}

- (IBAction)clickSwitch:(UISwitch *)sender {
    BOOL isOnBool = false;
    CGFloat yHeight = self.buil3ScrollView.contentSize.height;
    CGFloat yConstraint = _view2Height2.constant;
    for (UIView *view in view2.subviews) {
        if ([view isKindOfClass:[UISwitch class]]) {
            UISwitch *sw = (UISwitch *)view;
            if ([sw isOn]) {
                isOnBool = YES;
                break;
            }else{
                isOnBool = NO;
            }
        }
    }
    
    if (isOnBool) {
        if (yConstraint < 10) {
            [self viewHeight:_view2Height andHeight:359];
            [self viewHeight:_view2Height2 andHeight:199];
            self.buil3ScrollView.contentSize = CGSizeMake(0, yHeight+199);
            view22.hidden = NO;
            [self segmentedAction:segmented1];
            [self segmentedAction:segmented2];
        }
    }else{
        [self viewHeight:_view2Height andHeight:160];
        [self viewHeight:_view2Height2 andHeight:0];
        self.buil3ScrollView.contentSize = CGSizeMake(0, yHeight-199);
        view22.hidden = YES;
        floorListModel.市场装修情况 = @"";
        floorListModel.市场经营方式 = @"";
    }
    
    switch (sender.tag) {
        case 500:
            if ([sender isOn]) {
                floorListTypeModel.裙楼商铺 = @"裙楼商铺";
            }else{
                floorListTypeModel.裙楼商铺 = @"";
            }
            break;
        case 501:
            if ([sender isOn]) {
                floorListTypeModel.专业市场 = @"专业市场";
            }else{
                floorListTypeModel.专业市场 = @"";
            }
            break;
        case 502:
            if ([sender isOn]) {
                floorListTypeModel.综合市场 = @"综合市场";
            }else{
                floorListTypeModel.综合市场 = @"";
            }
            break;
        case 503:
            if ([sender isOn]) {
                floorListTypeModel.地下商场 = @"地下商场";
            }else{
                floorListTypeModel.地下商场 = @"";
            }
            break;
        case 504:
            if ([sender isOn]) {
                floorListTypeModel.其它 = @"其它";
            }else{
                floorListTypeModel.其它 = @"";
            }
            break;
    }
}

- (IBAction)clickSwitch3:(UISwitch *)sender {
    BOOL isOnBool = false;
    CGFloat yHeight = self.buil3ScrollView.contentSize.height;
    CGFloat yConstraint = _view3Height3.constant;
    for (UIView *view in view3.subviews) {
        if ([view isKindOfClass:[UISwitch class]]) {
            UISwitch *sw = (UISwitch *)view;
            if ([sw isOn]) {
                isOnBool = YES;
                break;
            }else{
                isOnBool = NO;
            }
        }
    }
    
    if (isOnBool) {
        if (yConstraint < 10) {
            [self viewHeight:_view3Height andHeight:483];
            [self viewHeight:_view3Height3 andHeight:405];
            self.buil3ScrollView.contentSize = CGSizeMake(0, yHeight+405);
            view33.hidden = NO;
            [self segmentedAction:segmented3];
            [self segmentedAction:segmented4];
        }
    }else{
        [self viewHeight:_view3Height andHeight:78];
        [self viewHeight:_view3Height3 andHeight:0];
        self.buil3ScrollView.contentSize = CGSizeMake(0, yHeight-405);
        view33.hidden = YES;
        floorListModel.商场装修情况 = @"";
        floorListModel.商场经营方式 = @"";
    }
    
    switch (sender.tag) {
        case 505:
            if ([sender isOn]) {
                floorListTypeModel.购物中心 = @"购物中心";
            }else{
                floorListTypeModel.购物中心 = @"";
            }
            break;
        case 506:
            if ([sender isOn]) {
                floorListTypeModel.百货商场 = @"百货商场";
            }else{
                floorListTypeModel.百货商场 = @"";
            }
            break;
    }
}

- (IBAction)clickSwitch4:(UISwitch *)sender {
    CGFloat yHeight = self.buil3ScrollView.contentSize.height;
    if (sender.isOn) {
        [self viewHeight:_view4Height andHeight:195];
        [self viewHeight:_view4Height4 andHeight:125];
        self.buil3ScrollView.contentSize = CGSizeMake(0, yHeight+125);
        view44.hidden = NO;
        floorListTypeModel.宾馆酒店 = @"宾馆酒店";
        [self segmentedAction:segmented5];
    }else{
        [self viewHeight:_view4Height andHeight:70];
        [self viewHeight:_view4Height4 andHeight:0];
        self.buil3ScrollView.contentSize = CGSizeMake(0, yHeight-125);
        view44.hidden = YES;
        floorListTypeModel.宾馆酒店 = @"";
        floorListModel.酒店装修情况 = @"";
    }
}

- (IBAction)clickSwitch5:(UISwitch *)sender {
    CGFloat yHeight = self.buil3ScrollView.contentSize.height;
    if (sender.isOn) {
        [self viewHeight:_view5Height andHeight:275];
        [self viewHeight:_view5Height5 andHeight:205];
        self.buil3ScrollView.contentSize = CGSizeMake(0, yHeight+205);
        view55.hidden = NO;
        floorListTypeModel.大型超市 = @"大型超市";
        [self segmentedAction:segmented6];
        [self segmentedAction:segmented7];
    }else{
        [self viewHeight:_view5Height andHeight:70];
        [self viewHeight:_view5Height5 andHeight:0];
        self.buil3ScrollView.contentSize = CGSizeMake(0, yHeight-205);
        view55.hidden = YES;
        floorListTypeModel.大型超市 = @"";
        floorListModel.大型超市装修情况 = @"";
        floorListModel.大型超市经营方式 = @"";
    }
}

//选择主要经营业态
-(IBAction)selectOperationForms:(UIButton *)sender{
    NSArray *array1 = @[@"食杂店",@"便利店",@"便利超市",@"大型超市",@"仓储会员店",@"百货店",@"专业店",@"办公用品",	@"玩具",	@"家电",@"药品",	@"服饰鞋帽",	@"箱包",@"家居建材",@"五金",@"电子通讯",@"汽车及配件",@"其他"];
    NSArray *array2 = @[@"快卖店",@"快餐店",@"小吃店",@"专卖店",@"休闲厅",@"餐厅",@"酒楼",@"美食广场"];
    NSArray *array3 = @[@"专业服务",@"租赁服务",@"咨询机构",@"培训机构",@"家居服务",@"体验式服务"];
    NSArray *array4 = [NSArray arrayWithObjects:array1,array2,array3, nil];
    [self building2View:array4 andArray1:businessTypeArray1 andArray2:businessTypeArray2 andArray3:businessTypeArray3];
    
}
//选择主营品种
-(IBAction)selectorVarieties:(UIButton *)sender{
    NSArray *array = @[@"化妆品",@"金银首饰",	@"珠宝钟表",@"鞋帽",@"女装",@"男装",@"童装",@"家居服",@"内衣",@"文体用品",@"办公用品",@"家居用品",@"餐饮",@"家电数码",@"娱乐休闲",@"箱包",@"超市",@"图书音像",@"其他"];
    [self building2View:array andSelectArray:businessTypeArray4 andIndex:0];
}

-(void)building2View:(NSArray *)array andArray1:(NSArray *)array1 andArray2:(NSArray *)array2 andArray3:(NSArray *)array3{
    if (storeyView == nil) {
        storeyView = [[[NSBundle mainBundle]loadNibNamed:@"StoreyView" owner:self options:nil] lastObject];
        storeyView.BuildingButton = ^(NSArray *arr1, NSArray *arr2, NSArray *arr3){
            [businessTypeArray1 removeAllObjects];
            [businessTypeArray1 addObjectsFromArray:arr1];
            [businessTypeArray2 removeAllObjects];
            [businessTypeArray2 addObjectsFromArray:arr2];
            [businessTypeArray3 removeAllObjects];
            [businessTypeArray3 addObjectsFromArray:arr3];
            
            storeyView.frame = CGRectMake(0, MainScreenheight, MainScreenWidth, 400);
        };
        [self.view addSubview:storeyView];
    }
    
    storeyView.frame = CGRectMake(0, MainScreenheight-520, MainScreenWidth, 400);
    [storeyView _initArray:array andArray1:array1 andArray2:array2 andArray3:array3];
}

-(void)building2View:(NSArray *)array andSelectArray:(NSArray *)array2 andIndex:(int)index{
    if (buildingView2 == nil) {
        buildingView2 = [[[NSBundle mainBundle]loadNibNamed:@"BuildingView2" owner:self options:nil] lastObject];
        buildingView2.BuildingButton = ^(NSArray *arr, int number){
            [businessTypeArray4 removeAllObjects];
            [businessTypeArray4 addObjectsFromArray:arr];
            buildingView2.frame = CGRectMake(0, MainScreenheight, MainScreenWidth, 400);
        };
        [self.view addSubview:buildingView2];
    }
    
    buildingView2.frame = CGRectMake(0, MainScreenheight-520, MainScreenWidth, 400);
    [buildingView2 _initArray:array andSelectArray:array2 andIndex:index];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 701:{
            floorListModel.楼层 = textField.text;
        }
            break;
        case 702:{
            floorListModel.市场层高 = textField.text;
        }
            break;
        case 703:{
            floorListModel.市场空置率 = textField.text;
        }
            break;
        case 704:{
            floorListModel.商品零售比例 = textField.text;
        }
            break;
        case 705:{
            floorListModel.餐饮零售比例 = textField.text;
        }
            break;
        case 706:{
            floorListModel.服务零售比例 = textField.text;
        }
            break;
        case 707:{
            floorListModel.商场代表品牌 = textField.text;
        }
            break;
        case 708:{
            floorListModel.商场整层面积 = textField.text;
        }
            break;
        case 709:{
            floorListModel.商场层高 = textField.text;
        }
            break;
        case 710:{
            floorListModel.商场空置率 = textField.text;
        }
            break;
        case 711:{
            floorListModel.酒店层高 = textField.text;
        }
            break;
        case 712:{
            floorListModel.酒店整层面积 = textField.text;
        }
            break;
        case 713:{
            floorListModel.大型超市整层面积 = textField.text;
        }
            break;
        case 714:{
            floorListModel.大型超市层高 = textField.text;
        }
            break;
        case 715:{
            floorListModel.大型超市空置率 = textField.text;
        }
            break;
    }
}

//保存按钮。
- (IBAction)saveButton:(UIButton *)sender {
    if (!(floorListModel.楼栋名称.length>1)) {
        [BaseView _init:@"请选择楼栋名称" View:self.view];
    }else if (!(floorListModel.楼层.length>0)){
        [BaseView _init:@"请输入楼层" View:self.view];
    }else if (!floorListModel.楼层平面图){
        [BaseView _init:@"请选择楼层平面图" View:self.view];
    }else{
        [self kNetworkListMake2];
    }
}
-(void)kNetworkListMake2{
    [kUserDefaults setObject:floorListModel.楼层 forKey:@"楼层"];
    
    floorListModel.商业类型=[NetworkManager Datastrings:[floorListTypeModel.toDictionary allValues]];
    floorListModel.商品零售业态 = [NetworkManager Datastrings:businessTypeArray1];
    floorListModel.餐饮零售业态 = [NetworkManager Datastrings:businessTypeArray2];
    floorListModel.服务零售业态 = [NetworkManager Datastrings:businessTypeArray3];
    floorListModel.商场主营品种 = [NetworkManager Datastrings:businessTypeArray4];

    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:floorListModel.toDictionary];
    [dict setObject:@"tradeLouceng" forKey:@"makeType"];
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
                for (NSArray *numbers in IDs) {
                    for (NSNumber *number in numbers) {
                        [[NetworkManager shar]updata:[number longLongValue] FormID:saveModel.ID TackId:self.taskID];
                    }
                }
                floorListModel.ID = saveModel.ID;
                [BaseView _init:saveModel.message View:SelfWeek.view];
                [kUserDefaults setObject:saveModel.ID forKey:@"businessId"];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotificationName:@"noticeBusiness" object:nil];
                [[NSUserDefaults standardUserDefaults]setObject:[super replaceString:floorListModel.楼栋编号] forKey:@"楼栋编号"];
                if ([look isEqualToString:@"商业新增"]) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"gongyeLouCengToShangPu" object:@{@"楼栋名称":[super replaceString:textfield15.text],@"楼栋编号":[super replaceString:floorListModel.楼栋编号],@"商业楼层":[super replaceString:textfield16.text]}];
                    
                    UIScrollView *scrollView=(UIScrollView *)self.view.superview;
                    CGFloat offsetX = scrollView.contentOffset.x + scrollView.frame.size.width;
                    offsetX = (int)(offsetX/MainScreenWidth) * MainScreenWidth;
                    [scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
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

//图片选择
- (IBAction)selectImageView:(id)sender {
    [self pushImageController];
    
}

-(void)pushImageController{
    POHViewController *pOHViewController=[[POHViewController alloc]initWithNibName:@"POHViewController" bundle:nil];
    NSMutableArray *PHarray=[NetworkManager address:floorListModel.楼层平面图];
    if (PHarray.count==0) {
        PHarray = [NSMutableArray arrayWithCapacity:1];
    }
    pOHViewController.PHOarray=PHarray;
    
    if ([look isEqualToString:@"商业查看"]) {
        pOHViewController.type = @"查看";
    }
    
    [self.navigationController pushViewController:pOHViewController animated:YES];
    
    pOHViewController.ClockSave=^(NSArray *ArrayID,NSString *ImageUrl){
        floorListModel.楼层平面图=ImageUrl;
        [IDs removeAllObjects];
        [IDs addObject:ArrayID];
        Url=[NetworkManager jiequStr:ImageUrl rep:@","];
        [NetworkManager _initSdImage:Url ImageView:imageView];
    };
    pOHViewController.imageType=@"楼层平面图";
    pOHViewController.orderType=@"tradeLouceng";
    pOHViewController.ID=floorListModel.ID;
    pOHViewController.stakID=self.taskID;
    pOHViewController.selectMax=5;
}

- (IBAction)selectNumber:(UIButton *)sender {
    formSelectTableView.formSelectArray=nil;
    Arraykeys=[[NSMutableArray alloc]init];
    Arrayvalues=[[NSMutableArray alloc]init];
    [self netSysData:1 andName:[super replaceString:secarchName]];
    [[BaseView baseShar]_initPop:formSelectView Type:1];
    formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
        _searchBar.text = @"";
        secarchName = @"";
        _searchBar.showsCancelButton = NO;
        [_searchBar resignFirstResponder];
        floorListModel.楼栋名称=selectStr;
        floorListModel.楼栋编号 = [Arrayvalues objectAtIndex:Index];
        [kUserDefaults setObject:selectStr forKey:@"楼栋名称"];
        [kUserDefaults setObject:[Arrayvalues objectAtIndex:Index] forKey:@"楼栋编号"];
        textfield15.text = selectStr;
    };
}
//获取系统楼盘编号和系统楼盘名称
-(void)netSysData:(int)page andName:(NSString *)name{
    
    __weak typeof(self)SelfWeek=self;
    NSDictionary *dict;
    if (self.taskID.length>1) {
        dict = @{@"makeType":@"tradeBuding",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":[super replaceString:shangyeLouPan],@"taskId":self.taskID,@"budingName":name} ;
    }else{
        dict = @{@"makeType":@"tradeBuding",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":[super replaceString:shangyeLouPan],@"budingName":name};
    }
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getBuding.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        [SelfWeek tableviewEnd];
        CommerciaEstateModel *systemModel = [[CommerciaEstateModel alloc]initWithDictionary:responseObject error:nil];
        if (systemModel) {
            if ([systemModel.status isEqualToString:@"1"]) {
                if (page==1) {
                    [Arraykeys removeAllObjects];
                    [Arrayvalues removeAllObjects];
                }
                for (CommerciaEstateListModel *systemListModel in systemModel.list) {
                    [Arraykeys addObject:systemListModel.实际名称];
                    [Arrayvalues addObject:systemListModel.楼栋编号];
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
