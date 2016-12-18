//
//  Building2ViewController.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/18.
//  Copyright © 2016年 test. All rights reserved.
//

#import "Building2ViewController.h"
#import "BuildingView2.h"
#import "Building2Model.h"
#import "SaveModel.h"
#import "FormSelectTableView.h"
#import "MJRefresh.h"
#import "LowPropertyNameView.h"
#import "CommerciaEstateModel.h"
#import "PhotoPickerViewController.h"
#import "UIImageView+WebCache.h"
#import "POHViewController.h"

@interface Building2ViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UISearchBarDelegate>
{
    FormSelectTableView *formSelectTableView;
    NSMutableArray *Arraykeys;
    NSMutableArray *Arrayvalues;
    BuildingView2 *buildingView2;
    NSInteger integerTag;
    int numberInt;
    NSMutableArray  *buildingArray;
    NSMutableArray  *typeArray;
    NSMutableArray  *typeArray2;
    NSMutableArray  *typeArray3;
//    NSMutableArray  *addressArray1;
    NSMutableArray  *businessTypeArray1, *businessTypeArray2, *businessTypeArray3, *businessTypeArray4, *businessTypeArray5;
    Building2ListModel *buildingListModel;
    Building2ListTypeModel *buildingListTyperModel;
    NSArray *imageArrays;
    NSMutableArray *IDs;
    NSString *look;
    IBOutlet UIView *view1;
    NSString *Url;
    __weak IBOutlet UIButton *button0;
    __weak IBOutlet UIButton *button00;
    __weak IBOutlet UITextField *textField1;
    __weak IBOutlet UITextField *textField2;

    IBOutlet UIView *view2;
    __weak IBOutlet UIButton *button1;
    __weak IBOutlet UIButton *button2;
    __weak IBOutlet UIButton *button3;
    __weak IBOutlet UIButton *button4;
    __weak IBOutlet UIButton *button5;
    __weak IBOutlet UIButton *button6;
    __weak IBOutlet UIButton *button7;
    __weak IBOutlet UIButton *button9;
    __weak IBOutlet UIImageView *imageView;
    
    __weak IBOutlet UIView *numberView;
    __weak IBOutlet UILabel *numberLabel;
    __weak IBOutlet UITextField *textField3;
    __weak IBOutlet UITextField *textField4;
    __weak IBOutlet UITextField *textField5;
//    __weak IBOutlet UITextField *textField6;
//    __weak IBOutlet UITextField *textField7;
//    __weak IBOutlet UITextField *textField8;
    __weak IBOutlet UITextField *textField9;
    __weak IBOutlet UITextField *textField10;
    __weak IBOutlet UIView *numberView2;
    __weak IBOutlet UITextField *textField11;
    __weak IBOutlet UITextField *textField12;
    __weak IBOutlet UITextField *textField13;
    __weak IBOutlet UITextField *textField14;
    __weak IBOutlet UITextField *textField15;
    __weak IBOutlet UITextField *textField16;
    __weak IBOutlet UITextField *textField17;
    __weak IBOutlet UITextField *textField18;
    __weak IBOutlet UITextField *textField19;
    __weak IBOutlet UITextField *textField20;

    __weak IBOutlet UIView *streetView;
    __weak IBOutlet UISegmentedControl *segmented;
    __weak IBOutlet UIView *streetView2;
    __weak IBOutlet UITextField *textField21;
    __weak IBOutlet UITextField *textField22;
    __weak IBOutlet UITextField *textField23;
    __weak IBOutlet UITextField *textField24;
    
    __weak IBOutlet NSLayoutConstraint *numberViewH;//210   //34
    __weak IBOutlet NSLayoutConstraint *numberView2H;//176
    __weak IBOutlet NSLayoutConstraint *streetViewH;//196  //41
    __weak IBOutlet NSLayoutConstraint *streetView2H;//155
    
    IBOutlet UIView *view3;
    __weak IBOutlet UITextField *textField25;
    __weak IBOutlet UISwitch *switch1;
    __weak IBOutlet UIButton *button10;
    
    __weak IBOutlet NSLayoutConstraint *view1H;//135
    
    __weak IBOutlet UISwitch *switch5;
    __weak IBOutlet UISwitch *switch6;
    __weak IBOutlet UISwitch *switch7;
    __weak IBOutlet UISwitch *switch8;
    NSString *secarchName;
    UIView *formSelectView;
}
@property (nonatomic ,strong)UISearchBar *searchBar;
@end

@implementation Building2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IDs=[[NSMutableArray alloc]init];
    numberInt = 1;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shangYelouPanTolouDong:) name:@"shangYelouPanTolouDong" object:nil];
    _strId = [super replaceString:[kUserDefaults objectForKey:@"businessId"]];
    _taskId = [super replaceString:[kUserDefaults objectForKey:@"taskId"]];
    buildingArray = [NSMutableArray arrayWithCapacity:1];
    
    if (_taskId.length<1) {
        view1H.constant = 90;
        switch1.hidden = YES;
    }
    
    look = [kUserDefaults objectForKey:@"商业查看"];
    if ([look isEqualToString:@"商业查看"]) {
        button9.hidden = YES;
    }
    
    self.contentView.frame = CGRectMake(0, 0, MainScreenWidth, self.contentView.frame.size.height);
    [self.buil2ScrollView addSubview:self.contentView];
    
    self.buil2ScrollView.contentSize = CGSizeMake(0, 987);
    
    [self viewHeight:numberViewH andHeight:65];
    [self viewHeight:numberView2H andHeight:31];
    [self viewHeight:streetViewH andHeight:76];
    [self viewHeight:streetView2H andHeight:35];
    
    [self layerView:button0];
    [self layerView:button00];
    [self layerView:button9];
    [self layerView:button10];
    button1.hidden = YES;
    button2.hidden = YES;
    button3.hidden = YES;
    button4.hidden = YES;
    button5.hidden = YES;
    
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
}

-(void)shangYelouPanTolouDong:(NSNotification *)sender{
    textField1.text = [sender object];
    buildingListModel.楼盘名称 = textField1.text;
}

-(void)layerView:(UIView *)view{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0;
}

-(void)segmentedAction:(UISegmentedControl *)Seg{
    NSInteger index=Seg.selectedSegmentIndex;
    NSString *str = [Seg titleForSegmentAtIndex:Seg.selectedSegmentIndex];
    NSLog(@"%ld----%@",index,str);
    buildingListModel.临街类型 = [NSString stringWithFormat:@"%@临街",str];
    [self streetViewH:index];
}

-(void)kNetworkListMake{
    NSDictionary *dcit;
    if (self.selectIndex == 1) {
        if (self.taskId.length>1) {
            dcit = @{@"makeType":@"tradeBuding",@"ID":self.strId,@"taskId":self.taskId};
        }else if(self.strId.length>1){
            dcit = @{@"makeType":@"tradeBuding",@"ID":self.strId};
        }else{
            dcit = @{@"makeType":@"tradeBuding"};
        }
    }else{
        dcit = @{@"ID":@"0"};
    }
    __weak typeof(self)SelfWeek=self;
    [NetworkManager requestWithMethod:@"POST" bodyParameter:dcit relativePath:@"appAction!getMake.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        Building2Model *buildingModel = [[Building2Model alloc]initWithDictionary:responseObject error:nil];
        buildingListModel = [[Building2ListModel alloc]init];
        if (buildingModel) {
            [buildingArray addObjectsFromArray:buildingModel.list];
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
    buildingListTyperModel = [[Building2ListTypeModel alloc]init];
    businessTypeArray1 = [NSMutableArray arrayWithCapacity:1];
    businessTypeArray2 = [NSMutableArray arrayWithCapacity:1];
    businessTypeArray3 = [NSMutableArray arrayWithCapacity:1];
    businessTypeArray4 = [NSMutableArray arrayWithCapacity:1];
    businessTypeArray5 = [NSMutableArray arrayWithCapacity:1];
//    addressArray1 = [NSMutableArray arrayWithCapacity:1];
    typeArray2 = [NSMutableArray arrayWithCapacity:1];
    typeArray3 = [NSMutableArray arrayWithCapacity:1];
    buildingListModel.临街类型 = @"单面";
    [segmented addTarget: self action: @selector(segmentedAction:) forControlEvents: UIControlEventValueChanged];
}

-(void)loadData{
    buildingListModel = [buildingArray objectAtIndex:0];
    buildingListTyperModel = [[Building2ListTypeModel alloc]initWithDictionary:[NetworkManager stringDictionary:buildingListModel.商业类型] error:nil];
    
    textField1.text = [super replaceString:buildingListModel.楼盘名称];
    textField2.text = [super replaceString:buildingListModel.楼栋编号];
    
    if (self.taskId.length>1) {
        NSString *str1 = [super replaceString:buildingListModel.无法调查说明];
        if (str1.length>1) {
            textField25.text = str1;
            [switch1 setOn:YES];
            [self switchAction:switch1];
            return;
        }
    }
    
    typeArray = [[NSMutableArray alloc]initWithArray:[NetworkManager address:buildingListModel.商业类型]];
    if (typeArray.count>1) {
        for (NSString *str in typeArray) {
            for (UIView *view in view2.subviews) {
                if ([view isKindOfClass:[UILabel class]]) {
                    UILabel *label = (UILabel *)view;
                    if ([label.text isEqualToString:str]) {
                        [self switchOnIsOff:label.tag];
                        break;
                    }
                }
            }
        }
    }
    businessTypeArray1 = [NSMutableArray arrayWithArray:[NetworkManager address:buildingListModel.裙楼分类]];
    businessTypeArray2 = [NSMutableArray arrayWithArray:[NetworkManager address:buildingListModel.市场类型]];
    businessTypeArray3 = [NSMutableArray arrayWithArray:[NetworkManager address:buildingListModel.商场定位]];
    businessTypeArray4 = [NSMutableArray arrayWithArray:[NetworkManager address:buildingListModel.酒店类型]];
    businessTypeArray5 = [NSMutableArray arrayWithArray:[NetworkManager address:buildingListModel.超市品牌]];
    
    textField3.text = [super replaceString:buildingListModel.系统名称];
    textField4.text = [super replaceString:buildingListModel.实际名称];
    textField5.text = [super replaceString:buildingListModel.物业管理公司];
    
   /* addressArray1 = [[NSMutableArray alloc]initWithArray:[NetworkManager address:buildingListModel.楼栋位置]];
    switch (addressArray1.count) {
        case 1:
            textField6.text = [addressArray1 objectAtIndex:0];
            break;
        case 2:
            textField6.text = [addressArray1 objectAtIndex:0];
            textField7.text = [addressArray1 objectAtIndex:1];
            break;
        case 3:
            textField6.text = [addressArray1 objectAtIndex:0];
            textField7.text = [addressArray1 objectAtIndex:1];
            textField8.text = [addressArray1 objectAtIndex:2];
            break;
    }*/
    
    textField9.text = [super replaceString:buildingListModel.地下层数];
    textField10.text = [super replaceString:buildingListModel.地上层数];
    
    typeArray2 = [NSMutableArray arrayWithArray:[NetworkManager address:buildingListModel.商业层数]];
    switch (typeArray2.count) {
        case 2:
        case 3:
            textField11.text = [typeArray2 objectAtIndex:0];
            textField12.text = [typeArray2 objectAtIndex:1];
            break;
        case 4:
        case 5:
            textField11.text = [typeArray2 objectAtIndex:0];
            textField12.text = [typeArray2 objectAtIndex:1];
            textField13.text = [typeArray2 objectAtIndex:2];
            textField14.text = [typeArray2 objectAtIndex:3];
            break;
        case 6:
        case 7:
            textField11.text = [typeArray2 objectAtIndex:0];
            textField12.text = [typeArray2 objectAtIndex:1];
            textField13.text = [typeArray2 objectAtIndex:2];
            textField14.text = [typeArray2 objectAtIndex:3];
            textField15.text = [typeArray2 objectAtIndex:4];
            textField16.text = [typeArray2 objectAtIndex:5];
            break;
        case 8:
        case 9:
            textField11.text = [typeArray2 objectAtIndex:0];
            textField12.text = [typeArray2 objectAtIndex:1];
            textField13.text = [typeArray2 objectAtIndex:2];
            textField14.text = [typeArray2 objectAtIndex:3];
            textField15.text = [typeArray2 objectAtIndex:4];
            textField16.text = [typeArray2 objectAtIndex:5];
            textField17.text = [typeArray2 objectAtIndex:6];
            textField18.text = [typeArray2 objectAtIndex:7];
            break;
        case 10:
        case 11:
            textField11.text = [typeArray2 objectAtIndex:0];
            textField12.text = [typeArray2 objectAtIndex:1];
            textField13.text = [typeArray2 objectAtIndex:2];
            textField14.text = [typeArray2 objectAtIndex:3];
            textField15.text = [typeArray2 objectAtIndex:4];
            textField16.text = [typeArray2 objectAtIndex:5];
            textField17.text = [typeArray2 objectAtIndex:6];
            textField18.text = [typeArray2 objectAtIndex:7];
            textField19.text = [typeArray2 objectAtIndex:8];
            textField20.text = [typeArray2 objectAtIndex:9];
            break;
    }
    numberLabel.text = [NSString stringWithFormat:@"%ld",typeArray2.count/2];
    [self numberViewH:[numberLabel.text intValue] andAdd:YES];
    
    NSString *typeStr = [super replaceString:buildingListModel.临街类型];
    if (typeStr.length>0) {
        NSArray *segmentedArray = @[@"单面",@"双面",@"三面",@"四面"];
        for (int i=0; i<segmentedArray.count; i++) {
            NSString *str6 = [NSString stringWithFormat:@"%@临街",[segmentedArray objectAtIndex:i]];
            if ([str6 isEqualToString:typeStr]) {
                segmented.selectedSegmentIndex = i;
            }
        }
    }
    
    typeArray3 = [NSMutableArray arrayWithArray:[NetworkManager address:buildingListModel.所临街道名称]];
    if (typeArray3.count>1) {
        textField21.text = [typeArray3 objectAtIndex:0];
        switch (segmented.selectedSegmentIndex) {
            case 1:
                textField22.text = [typeArray3 objectAtIndex:1];
                break;
            case 2:
                textField22.text = [typeArray3 objectAtIndex:1];
                textField23.text = [typeArray3 objectAtIndex:2];
                break;
            case 3:
                textField22.text = [typeArray3 objectAtIndex:1];
                textField23.text = [typeArray3 objectAtIndex:2];
                textField24.text = [typeArray3 objectAtIndex:3];
                break;
        }
        [self streetViewH:segmented.selectedSegmentIndex];
    }
    [segmented addTarget: self action: @selector(segmentedAction:) forControlEvents: UIControlEventValueChanged];
    
    NSString *imageStr = [super replaceString:buildingListModel.临街道照片];
    if (imageStr.length>1) {
        NSArray *array = [NetworkManager address:imageStr];
        if (array.count>0) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,[array objectAtIndex:0]]] placeholderImage:nil];
        }
        
    }
}

-(void)viewHeight:(NSLayoutConstraint *)view andHeight:(CGFloat)height{
    view.constant = height;
}

-(void)switchOnIsOff:(NSInteger)integer{
    for (UIView *view in view2.subviews) {
        if ([view isKindOfClass:[UISwitch class]]) {
            UISwitch *sw = (UISwitch *)view;
            if (sw.tag == integer) {
                [sw setOn:YES];
                if (sw.tag == 501) {
                    button1.hidden = NO;
                }else if (sw.tag == 504|| sw.tag == 505) {
                    button2.hidden = NO;
                }else if (sw.tag == 506|| sw.tag == 507){
                    button3.hidden = NO;
                }else if(sw.tag == 508){
                    button4.hidden = NO;
                }else if(sw.tag == 509){
                    button5.hidden = NO;
                }
                return;
            }
        }
    }
}

//无法调查
- (IBAction)switchAction:(UISwitch *)sender {
    switch (sender.tag) {
        case 500:{
            textField25.text = @"";
            buildingListModel.无法调查说明 = @"";
            if ([sender isOn]) {
                view2.hidden = YES;
                view3.hidden = NO;
                self.buil2ScrollView.contentSize = CGSizeMake(0, 480);
            }else{
                view2.hidden = NO;
                view3.hidden = YES;
                self.buil2ScrollView.contentSize = CGSizeMake(0, 1200);
            }
        }
            break;
        case 501:{
            if ([sender isOn]) {
                button1.hidden = NO;
                buildingListTyperModel.裙楼商铺 = @"裙楼商铺";
            }else{
                button1.hidden = YES;
                buildingListTyperModel.裙楼商铺 = @"";
            }
        }
            break;
        case 502:{
            if ([sender isOn]) {
                buildingListTyperModel.地下商场 = @"地下商场";
            }else{
                buildingListTyperModel.地下商场 = @"";
            }
        }
            break;
        case 503:{
            if ([sender isOn]) {
                buildingListTyperModel.其它 = @"其它";
            }else{
                buildingListTyperModel.其它 = @"";
            }
        }
            break;
        case 504:
        case 505:{
            if (sender.tag == 504) {
                if ([sender isOn]) {
                    buildingListTyperModel.专业市场 = @"专业市场";
                }else{
                    buildingListTyperModel.专业市场 = @"";
                }
            }else if (sender.tag == 505){
                if ([sender isOn]) {
                    buildingListTyperModel.综合市场 = @"综合市场";
                }else{
                    buildingListTyperModel.综合市场 = @"";
                }
            }
            if ([switch5 isOn] || [switch6 isOn]) {
                button2.hidden = NO;
            }else{
                button2.hidden = YES;
            }
        }
            break;
        case 506:
        case 507:{
            if (sender.tag == 506) {
                if ([sender isOn]) {
                    buildingListTyperModel.百货商场 = @"百货商场";
                }else{
                    buildingListTyperModel.百货商场 = @"";
                }
            }else if(sender.tag == 507){
                if ([sender isOn]) {
                    buildingListTyperModel.购物中心 = @"购物中心";
                }else{
                    buildingListTyperModel.购物中心 = @"";
                }
            }
            if ([switch7 isOn] || [switch8 isOn]) {
                button3.hidden = NO;
            }else{
                button3.hidden = YES;
            }
        }
            break;
        case 508:{
            if ([sender isOn]) {
                buildingListTyperModel.宾馆酒店 = @"宾馆酒店";
                button4.hidden = NO;
            }else{
                button4.hidden = YES;
                buildingListTyperModel.宾馆酒店 = @"";
            }
        }
            break;
        case 509:{
            if ([sender isOn]) {
                button5.hidden = NO;
                buildingListTyperModel.大型超市 = @"大型超市";
            }else{
                button5.hidden = YES;
                buildingListTyperModel.大型超市 = @"";
            }
        }
            break;
    }
}

//商业层数
- (IBAction)clickButton:(UIButton *)sender {
    switch (sender.tag) {
        case 501:{//减号
            numberInt = [numberLabel.text intValue];
            if (numberInt == 1) {
                [BaseView _init:@"最少一层" View:self.view];
            }else{
                numberInt = numberInt - 1;
                numberLabel.text = [NSString stringWithFormat:@"%d",numberInt];
                [self numberViewH:numberInt andAdd:NO];
            }
        }
            break;
        case 502:{//加号
            numberInt = [numberLabel.text intValue];
            if (numberInt == 5) {
                [BaseView _init:@"最多五层" View:self.view];
            }else{
                numberInt = numberInt + 1;
                numberLabel.text = [NSString stringWithFormat:@"%d",numberInt];
                [self numberViewH:numberInt andAdd:YES];
            }
        }
            break;
    }
}

//选择图片
- (IBAction)selectImageView:(id)sender {
    [self pushImageController];
}

-(void)pushImageController{
    POHViewController *pOHViewController=[[POHViewController alloc]initWithNibName:@"POHViewController" bundle:nil];
    
    NSMutableArray *PHarray=[NetworkManager address:buildingListModel.临街道照片];
    if (PHarray.count==0) {
        PHarray = [NSMutableArray arrayWithCapacity:1];
    }
    pOHViewController.PHOarray=PHarray;
    pOHViewController.successfulIndex = PHarray.count;
    if ([look isEqualToString:@"商业查看"]) {
        pOHViewController.type = @"查看";
    }
    
    [self.navigationController pushViewController:pOHViewController animated:YES];
    
    pOHViewController.ClockSave=^(NSArray *ArrayID,NSString *ImageUrl){
        buildingListModel.临街道照片=ImageUrl;
        [IDs removeAllObjects];
        [IDs addObject:ArrayID];
        Url=[NetworkManager jiequStr:ImageUrl rep:@","];
        [NetworkManager _initSdImage:Url ImageView:imageView];
    };
    pOHViewController.imageType=@"临街道照片";
    pOHViewController.orderType=@"tradeBuding";
    pOHViewController.ID=buildingListModel.ID;
    pOHViewController.stakID=self.taskId;
    pOHViewController.selectMax=5;
    
//    PhotoPickerViewController *photoPickerViewController=[[PhotoPickerViewController alloc]init];
//    if (imageArrays.count!=0) {
//        photoPickerViewController.LQPhotoPicker_selectedAssetArray=[NSMutableArray arrayWithArray:[imageArrays objectAtIndex:0]];
//        photoPickerViewController.LQPhotoPicker_smallImageArray=[NSMutableArray arrayWithArray:[imageArrays objectAtIndex:3]];
//        photoPickerViewController.LQPhotoPicker_bigImageArray=[NSMutableArray arrayWithArray:[imageArrays objectAtIndex:1]];
//    }
//    photoPickerViewController.imageType=@"临街道照片";
//    photoPickerViewController.orderType=@"tradeBuding";
//    photoPickerViewController.ID=buildingListModel.ID;
//    photoPickerViewController.stakID=self.taskId;
//    NSArray *aray=[NetworkManager address: buildingListModel.临街道照片];
//    photoPickerViewController.LQPhotoPicker_smallImageArray=[NSMutableArray arrayWithArray:aray];
//    photoPickerViewController.Arraycount=aray.count;
//    photoPickerViewController.ClockPhon=^(NSArray *phionImgeArray){
//        imageArrays=phionImgeArray;
//        if ([[[imageArrays objectAtIndex:3] objectAtIndex:0] isKindOfClass:[NSString class]]) {
//            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,[[imageArrays objectAtIndex:3] objectAtIndex:0]]]];
//        }else{
//            imageView.image=[[imageArrays objectAtIndex:3] objectAtIndex:0];
//        }
//    };
//    photoPickerViewController.ClockSave=^(NSArray *ArrayID,NSString *ImageUrl){
//        buildingListModel.临街道照片=ImageUrl;
//        [IDs addObject:ArrayID];
//    };
//    
//    //            photoPickerViewController.LQPhotoPicker_selectedAssetArray=array;
//    [self.navigationController pushViewController:photoPickerViewController animated:YES];
}

-(void)numberViewH:(int)number andAdd:(BOOL)addBool{
    CGFloat yHeight = self.buil2ScrollView.contentSize.height;
    switch (number) {
        case 1:{
            [self viewHeight:numberViewH andHeight:65];
            [self viewHeight:numberView2H andHeight:31];
            self.buil2ScrollView.contentSize = CGSizeMake(0, yHeight-31);
        }
            break;
        case 2:{
            [self viewHeight:numberViewH andHeight:101];
            [self viewHeight:numberView2H andHeight:67];
            if (addBool) {
                self.buil2ScrollView.contentSize = CGSizeMake(0, yHeight+36);
            }else{
                self.buil2ScrollView.contentSize = CGSizeMake(0, yHeight-36);
            }
        }
            break;
        case 3:{
            [self viewHeight:numberViewH andHeight:136];
            [self viewHeight:numberView2H andHeight:102];
            if (addBool) {
                self.buil2ScrollView.contentSize = CGSizeMake(0, yHeight+35);
            }else{
                self.buil2ScrollView.contentSize = CGSizeMake(0, yHeight-35);
            }
        }
            break;
        case 4:{
            [self viewHeight:numberViewH andHeight:171];
            [self viewHeight:numberView2H andHeight:137];
            if (addBool) {
                self.buil2ScrollView.contentSize = CGSizeMake(0, yHeight+35);
            }else{
                self.buil2ScrollView.contentSize = CGSizeMake(0, yHeight-35);
            }
        }
            break;
        case 5:{
            [self viewHeight:numberViewH andHeight:210];
            [self viewHeight:numberView2H andHeight:176];
            self.buil2ScrollView.contentSize = CGSizeMake(0, yHeight+39);
        }
            break;
    }
}

//临街类型
-(void)streetViewH:(NSInteger)street{
    NSInteger yHeight = self.buil2ScrollView.contentSize.height;
    NSLog(@"------------%ld",yHeight);
    switch (street) {
        case 0:{
            yHeight = yHeight - 76;
            [self viewHeight:streetViewH andHeight:76];
            [self viewHeight:streetView2H andHeight:35];
            self.buil2ScrollView.contentSize = CGSizeMake(0, yHeight+76);

        }
            break;
        case 1:{
            yHeight = yHeight - 116;
            
            [self viewHeight:streetViewH andHeight:116];
            [self viewHeight:streetView2H andHeight:75];
            self.buil2ScrollView.contentSize = CGSizeMake(0, yHeight+116);
        }
            break;
        case 2:{
            yHeight = yHeight - 156;
            [self viewHeight:streetViewH andHeight:156];
            [self viewHeight:streetView2H andHeight:115];
            self.buil2ScrollView.contentSize = CGSizeMake(0, yHeight+156);
        }
            break;
        case 3:{
            yHeight = yHeight - 196;
            [self viewHeight:streetViewH andHeight:196];
            [self viewHeight:streetView2H andHeight:155];
            self.buil2ScrollView.contentSize = CGSizeMake(0, yHeight+196+60);
            if (yHeight+196+60>=1252) {
                self.buil2ScrollView.contentSize = CGSizeMake(0, 1200);
            }
        }
            break;
    }
}

//button商业类型
-(IBAction)selectButton:(UIButton *)sender{
    switch (sender.tag) {
        case 600:{
            NSArray *array = @[@"住宅裙楼",@"办公裙楼"];
            [self building2View:array andSelectArray:businessTypeArray1 andIndex:1];
        }
            break;
        case 601:{
            NSArray *array = @[@"电子通讯",@"电器",@"家居建材",@"服饰鞋帽箱包",@"汽车及配件",@"食品肉菜",@"工业产品",@"花鸟鱼虫",@"工艺礼品文具",@"五金机电",@"珠宝古董",@"图书",@"布匹",@"其它"];
            [self building2View:array andSelectArray:businessTypeArray2 andIndex:2];
        }
            break;
        case 602:{
            NSArray *array = @[@"市级",@"行政区级",@"片区级"];
            [self building2View:array andSelectArray:businessTypeArray3 andIndex:3];
        }
            break;
        case 603:{
            NSArray *array = @[@"大酒店：一级",@"大酒店：二级",@"大酒店：三级",@"经济酒店",@"招待所"];
            [self building2View:array andSelectArray:businessTypeArray4 andIndex:4];
        }
            break;
        case 604:{
            NSArray *array = @[@"沃尔玛",@"山姆会员店",@"家乐福",@"麦德隆",@"华润万家",@"百佳",@"吉之岛",@"其他"];
            [self building2View:array andSelectArray:businessTypeArray5 andIndex:5];
        }
            break;
    }
}
-(void)building2View:(NSArray *)array andSelectArray:(NSArray *)array2 andIndex:(int)index{
    if (buildingView2 == nil) {
        buildingView2 = [[[NSBundle mainBundle]loadNibNamed:@"BuildingView2" owner:self options:nil] lastObject];
        buildingView2.BuildingButton = ^(NSArray *arr, int number){
            switch (number) {
                case 1:
                    [businessTypeArray1 removeAllObjects];
                    [businessTypeArray1 addObjectsFromArray:arr];
                    break;
                case 2:
                    [businessTypeArray2 removeAllObjects];
                    [businessTypeArray2 addObjectsFromArray:arr];
                    break;
                case 3:
                    [businessTypeArray3 removeAllObjects];
                    [businessTypeArray3 addObjectsFromArray:arr];
                    break;
                case 4:
                    [businessTypeArray4 removeAllObjects];
                    [businessTypeArray4 addObjectsFromArray:arr];
                    break;
                case 5:
                    [businessTypeArray5 removeAllObjects];
                    [businessTypeArray5 addObjectsFromArray:arr];
                    break;

            }
             buildingView2.frame = CGRectMake(0, MainScreenheight, MainScreenWidth, 400);
        };
        [self.view addSubview:buildingView2];
    }
    
    buildingView2.frame = CGRectMake(0, MainScreenheight-520, MainScreenWidth, 400);
    [buildingView2 _initArray:array andSelectArray:array2 andIndex:index];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 700:{
            buildingListModel.楼盘名称 = textField.text;
        }
            break;
        case 701:{
            buildingListModel.楼栋编号 = textField.text;
        }
            break;
        case 702:{
            buildingListModel.系统名称 = textField.text;
        }
            break;
        case 703:{
            buildingListModel.实际名称 = textField.text;
        }
            break;
        case 704:{
            buildingListModel.物业管理公司 = textField.text;
        }
            break;
//        case 705:{
//            [self repn:textField.text Index:0 Datas:addressArray1];
//        }
//            break;
//        case 706:{
//            [self repn:textField.text Index:1 Datas:addressArray1];
//        }
//            break;
//        case 707:{
//            [self repn:textField.text Index:2 Datas:addressArray1];
//        }
//            break;
        case 708:{
            buildingListModel.地下层数 = textField.text;
        }
            break;
        case 709:{
            buildingListModel.地上层数 = textField.text;
        }
            break;
        case 710:{
            [self repn:textField.text Index:0 Datas:typeArray2];
        }
            break;
        case 711:{
            [self repn:textField.text Index:1 Datas:typeArray2];
        }
            break;
        case 712:{
            [self repn:textField.text Index:2 Datas:typeArray2];
        }
            break;
        case 713:{
            [self repn:textField.text Index:3 Datas:typeArray2];
        }
            break;
        case 714:{
            [self repn:textField.text Index:4 Datas:typeArray2];
        }
            break;
        case 715:{
            [self repn:textField.text Index:5 Datas:typeArray2];
        }
            break;
        case 716:{
            [self repn:textField.text Index:6 Datas:typeArray2];
        }
            break;
        case 717:{
            [self repn:textField.text Index:7 Datas:typeArray2];
        }
            break;
        case 718:{
            [self repn:textField.text Index:8 Datas:typeArray2];
        }
            break;
        case 719:{
            [self repn:textField.text Index:9 Datas:typeArray2];
        }
            break;
        case 720:{
            [self repn:textField.text Index:0 Datas:typeArray3];
        }
            break;
        case 721:{
            [self repn:textField.text Index:1 Datas:typeArray3];
        }
            break;
        case 722:{
            [self repn:textField.text Index:2 Datas:typeArray3];
        }
            break;
        case 723:{
            [self repn:textField.text Index:3 Datas:typeArray3];
        }
            break;
        case 724:{
            buildingListModel.无法调查说明 = textField.text;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

//保存按钮。
- (IBAction)saveButton:(UIButton *)sender {
//    buildingListModel.楼栋位置 = [NetworkManager Datastrings:addressArray1];
    buildingListModel.商业层数 = [NetworkManager Datastrings:typeArray2];
    if (typeArray2.count > [numberLabel.text intValue]*2) {
        NSRange range = NSMakeRange([numberLabel.text intValue]*2, typeArray2.count-([numberLabel.text intValue]*2));
        [typeArray2 removeObjectsInRange:range];
        switch ([numberLabel.text intValue]) {
            case 1:
                textField13.text = @"";
                textField14.text = @"";
                textField15.text = @"";
                textField16.text = @"";
                textField17.text = @"";
                textField18.text = @"";
                textField19.text = @"";
                textField20.text = @"";
                break;
            case 2:
                textField15.text = @"";
                textField16.text = @"";
                textField17.text = @"";
                textField18.text = @"";
                textField19.text = @"";
                textField20.text = @"";
                break;
            case 3:
                textField17.text = @"";
                textField18.text = @"";
                textField19.text = @"";
                textField20.text = @"";
                break;
            case 4:
                textField19.text = @"";
                textField20.text = @"";
                break;
        }
    }
    if (!(buildingListModel.楼盘名称.length>1)) {
        [BaseView _init:@"请输入楼盘名称" View:self.view];
    }else if (!(buildingListModel.实际名称.length>1)){
        [BaseView _init:@"请输入实际楼栋名称" View:self.view];
    }else if (!(buildingListModel.物业管理公司.length>1)){
        [BaseView _init:@"请输入物业管理公司" View:self.view];
    }else if (!(buildingListModel.地下层数.length>0)){
        [BaseView _init:@"请输入楼栋地下层数" View:self.view];
    }else if (!(buildingListModel.地上层数.length>0)){
        [BaseView _init:@"请输入楼栋地上层数" View:self.view];
    }else if ([numberLabel.text intValue]*2 > typeArray2.count){
        [BaseView _init:@"请输入完整的商业层数" View:self.view];
    }else if ([NetworkManager address:buildingListModel.临街道照片].count>segmented.selectedSegmentIndex+1||[NetworkManager address:buildingListModel.临街道照片].count<segmented.selectedSegmentIndex+1){
        [BaseView _init:[NSString stringWithFormat:@"临街道照片%ld张",segmented.selectedSegmentIndex+1] View:self.view];
    }else{
        [self kNetworkListMake2];
    }
}
-(void)kNetworkListMake2{
    buildingListModel.商业类型=[NetworkManager Datastrings:[buildingListTyperModel.toDictionary allValues]];
    buildingListModel.裙楼分类 = [NetworkManager Datastrings:businessTypeArray1];
    buildingListModel.市场类型 = [NetworkManager Datastrings:businessTypeArray2];
    buildingListModel.商场定位 = [NetworkManager Datastrings:businessTypeArray3];
    buildingListModel.酒店类型 = [NetworkManager Datastrings:businessTypeArray4];
    buildingListModel.超市品牌 = [NetworkManager Datastrings:businessTypeArray5];
    buildingListModel.所临街道名称 = [NetworkManager Datastrings:typeArray3];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:buildingListModel.toDictionary];
    [dict setObject:@"tradeBuding" forKey:@"makeType"];
    if (self.taskId.length>1) {
        [dict setObject:self.taskId forKey:@"taskId"];
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
                        [[NetworkManager shar]updata:[number longLongValue] FormID:saveModel.ID TackId:self.taskId];
                    }
                }
                buildingListModel.ID = saveModel.ID;
                [BaseView _init:saveModel.message View:SelfWeek.view];
                [kUserDefaults setObject:saveModel.ID forKey:@"businessId"];
                if ([look isEqualToString:@"商业新增"]) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"shangYeLouDongToLouCeng" object:@{@"商业楼盘":[super replaceString:textField1.text],@"商业楼栋":[super replaceString:textField4.text],@"商业楼栋编号":[super replaceString:textField2.text]}];
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

//无法调查保存
- (IBAction)wufaSurvey:(id)sender {
    if ([textField25.text isEqualToString:@""]) {
        ALERT(@"", @"请填写无法调查说明", @"确定");
        return;
    }else{
        buildingListModel.无法调查说明 = textField25.text;
    }
    
    buildingListModel.商业类型=[NetworkManager Datastrings:[buildingListTyperModel.toDictionary allValues]];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:buildingListModel.toDictionary];
    [dict setObject:@"tradeBuding" forKey:@"makeType"];
    if (self.taskId.length>1) {
        [dict setObject:self.taskId forKey:@"taskId"];
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
                        [[NetworkManager shar]updata:[number longLongValue] FormID:saveModel.ID TackId:self.taskId];
                    }
                }
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

- (IBAction)selectNumber1:(id)sender {
    Arraykeys=[[NSMutableArray alloc]init];
    Arrayvalues=[[NSMutableArray alloc]init];
    integerTag = 1000;
    [self netSysData:1 andTag:integerTag andName:[super replaceString:secarchName]];
    [[BaseView baseShar]_initPop:formSelectView Type:1];
    formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
        _searchBar.text = @"";
        secarchName = @"";
        _searchBar.showsCancelButton = NO;
        [_searchBar resignFirstResponder];
        buildingListModel.楼盘名称 = selectStr;
        buildingListModel.楼盘ID = [Arrayvalues objectAtIndex:Index];
        textField1.text = selectStr;
    };
}

- (IBAction)selectNumber2:(id)sender {
    formSelectTableView.formSelectArray=nil;
    Arraykeys=[[NSMutableArray alloc]init];
    Arrayvalues=[[NSMutableArray alloc]init];
    integerTag = 1001;
    [self netSysData:1 andTag:integerTag andName:[super replaceString:secarchName]];
    [[BaseView baseShar]_initPop:formSelectView Type:1];
    formSelectTableView.SelectIndex=^(NSString *selectStr,NSInteger Index){
        _searchBar.text = @"";
        secarchName = @"";
        _searchBar.showsCancelButton = NO;
        [_searchBar resignFirstResponder];
        buildingListModel.楼栋编号 = [Arraykeys objectAtIndex:Index];
        buildingListModel.系统名称 = selectStr;
        textField2.text = [Arraykeys objectAtIndex:Index];
        textField3.text = selectStr;
    };
}

//获取系统楼盘编号和系统楼盘名称
-(void)netSysData:(int)page andTag:(NSInteger)integerInt andName:(NSString *)name{
    
    __weak typeof(self)SelfWeek=self;
    NSDictionary *dict;
    if (integerInt == 1000) {
        if (self.taskId.length>1) {
            dict = @{@"makeType":@"tradeLoupan",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"taskId":self.taskId,@"louPanName":name} ;
        }else{
            dict = @{@"makeType":@"tradeLoupan",@"dateType":@"local",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":name};
        }
        [NetworkManager requestWithMethod:@"POST" bodyParameter:dict relativePath:@"appSelect!getLoupan.chtml" success:^(id responseObject) {
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
                        if (systemListModel.实际楼盘名称) {
                            [Arraykeys addObject:systemListModel.实际楼盘名称];
                        }
                        
                        [Arrayvalues addObject:systemListModel.ID];
                    }
                    formSelectTableView.formSelectArray=Arraykeys;
                }
            }
            
        } failure:^(NSError *error) {
            [SelfWeek tableviewEnd];
        }];
    }else{
        if (self.taskId.length>1) {
            dict = @{@"makeType":@"tradeBuding",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":[super replaceString:textField1.text],@"taskId":self.taskId,@"budingName":name};
        }else{
            dict = @{@"makeType":@"tradeBuding",@"dateType":@"system",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@10,@"louPanName":[super replaceString:textField1.text],@"budingName":name};
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
                        [Arraykeys addObject:systemListModel.楼栋编号];
                        [Arrayvalues addObject:systemListModel.系统楼栋名称];
                    }
                    formSelectTableView.formSelectArray=Arrayvalues;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
