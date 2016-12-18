//
//  HistoricalRecordViewController.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/10.
//  Copyright © 2016年 test. All rights reserved.
//

#import "HistoricalRecordViewController.h"
#import "OfficeQuestionnaireModel.h"
#import "NetworkManager.h"
#import "MyReviewCell.h"
#import "SearchView3.h"
#import "HistoricalRecordModel.h"
#import "CloudPaletteBar.h"
#import "BusinessFormsViewController.h"
#import "IndustryFromsViewController.h"
#import "FormViewController.h"
#import "LowFormViewController.h"
#import "OrdinaryFormViewController.h"


@interface HistoricalRecordViewController ()
{
    CGFloat searchViewW;
    HistoricalRecordModel *historicalRecordModel;
    NSArray *keyArray;
}

@property (assign, nonatomic)CGFloat searchViewH;
@property (strong, nonatomic)SearchView3 *searchView;

@end

static NSString *Identifier=@"Identifier";

@implementation HistoricalRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseArray=[[NSMutableArray alloc]init];
    keyArray=[NetworkManager _readInit:@"HistoricalRecord"];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"MyReviewCell" bundle:nil] forCellReuseIdentifier:Identifier];
    self.baseTableView.frame = CGRectMake(0,startingH2, MainScreenWidth, MainScreenheight-startingH2);
    
    [self searchV];

}

-(void)searchV{
    if (self.searchView == nil) {
        
        self.searchView = [[[NSBundle mainBundle]loadNibNamed:@"SearchView3" owner:self options:nil] lastObject];
        self.searchView.backgroundColor = [UIColor clearColor];
        [self.searchView loadOtherView];
        searchViewW = self.searchView.frame.size.width;
        self.searchViewH = 96;
        
        __weak typeof(self) searchBlock = self;
        self.searchView.PulldownButton = ^(NSString *upDown){
            if ([upDown isEqualToString:@"上"]) {
                searchBlock.searchView.frame = CGRectMake(0, 64, MainScreenWidth, 88+searchBlock.searchViewH);
                searchBlock.baseTableView.frame = CGRectMake(0, startingH2+88, MainScreenWidth, MainScreenheight-startingH2-88);
            }else{
                searchBlock.searchView.frame = CGRectMake(0, 64, MainScreenWidth, searchBlock.searchViewH);
                searchBlock.baseTableView.frame = CGRectMake(0, startingH2, MainScreenWidth, MainScreenheight-startingH2);
            }
        };
        
        self.searchView.SearchData = ^(NSString *categoryStr, NSString *startStr){
            NSLog(@"点击了搜索");
            [searchBlock netWork:1];
        };
        
        self.searchView.frame = CGRectMake(0, 64, MainScreenWidth, self.searchViewH);
        [self.view addSubview:self.searchView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.baseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    NSDictionary *keys=[keyArray objectAtIndex:0];
    HistoricalRecordListModel *historicalRecordListModel=[self.baseArray objectAtIndex:indexPath.row];
    [cell Cell1:historicalRecordListModel KeyDic:keys CellIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    HistoricalRecordListModel *historicalRecordListModel=[self.baseArray objectAtIndex:indexPath.row];
    /*#import "BusinessFormsViewController.h"
     #import "IndustryFromsViewController.h"
     #import "FormViewController.h"
     #import "LowFormViewController.h"
     #import "OrdinaryFormViewController.h"*/
    if ([historicalRecordListModel.TASKTYPE isEqualToString:@"tradeLoupan"]) {
        BusinessFormsViewController *views=(BusinessFormsViewController *)[self pushform:@"BusinessFormsViewID"];
        views.selectIndex=0;
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.ID] forKey:@"businessId"];
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.任务ID] forKey:@"taskId"];
        [kUserDefaults setObject:@"商业查看" forKey:@"商业查看"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"tradeBuding"]){
        BusinessFormsViewController *views=(BusinessFormsViewController *)[self pushform:@"BusinessFormsViewID"];
        views.selectIndex=1;
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.ID] forKey:@"businessId"];
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.任务ID] forKey:@"taskId"];
        [kUserDefaults setObject:@"商业查看" forKey:@"商业查看"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"tradeLouceng"]){
        BusinessFormsViewController *views=(BusinessFormsViewController *)[self pushform:@"BusinessFormsViewID"];
        views.selectIndex=2;
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.ID] forKey:@"businessId"];
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.任务ID] forKey:@"taskId"];
        [kUserDefaults setObject:@"商业查看" forKey:@"商业查看"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"tradeShangpu"]){
        BusinessFormsViewController *views=(BusinessFormsViewController *)[self pushform:@"BusinessFormsViewID"];
        views.selectIndex=3;
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.ID] forKey:@"businessId"];
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.任务ID] forKey:@"taskId"];
        [kUserDefaults setObject:@"商业查看" forKey:@"商业查看"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"officeLoupan"]){
        FormViewController *views=(FormViewController *)[self pushform:@"FormViewID"];
        views.selectIndex=0;
        views.selectSee=@"查看";
        views.formID=historicalRecordListModel.任务ID;
        [kUserDefaults setObject:historicalRecordListModel.ID forKey:@"officeId"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"officeBuding"]){
        FormViewController *views=(FormViewController *)[self pushform:@"FormViewID"];
        views.selectIndex=1;
        views.selectSee=@"查看";
        views.formID=historicalRecordListModel.任务ID;
        [kUserDefaults setObject:historicalRecordListModel.ID forKey:@"officeId"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"officeFangwu"]){
        FormViewController *views=(FormViewController *)[self pushform:@"FormViewID"];
        views.selectIndex=2;
        views.selectSee=@"查看";
        views.formID=historicalRecordListModel.任务ID;
        [kUserDefaults setObject:historicalRecordListModel.ID forKey:@"officeId"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"industryZongdi"]){
        IndustryFromsViewController *views=(IndustryFromsViewController *)[self pushform:@"IndustryFromsID"];
        views.selectIndex=0;
        [kUserDefaults setObject:@"工业查看" forKey:@"工业查看"];
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.ID] forKey:@"industryId"];
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.任务ID] forKey:@"taskIdIndustry"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"industryGongyeyuan"]){
        IndustryFromsViewController *views=(IndustryFromsViewController *)[self pushform:@"IndustryFromsID"];
        views.selectIndex=1;
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.ID] forKey:@"industryId"];
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.任务ID] forKey:@"taskIdIndustry"];
        [kUserDefaults setObject:@"工业查看" forKey:@"工业查看"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"industryLoupan"]){
        IndustryFromsViewController *views=(IndustryFromsViewController *)[self pushform:@"IndustryFromsID"];
        views.selectIndex=2;
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.ID] forKey:@"industryId"];
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.任务ID] forKey:@"taskIdIndustry"];
        [kUserDefaults setObject:@"工业查看" forKey:@"工业查看"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"industryBuding"]){
        IndustryFromsViewController *views=(IndustryFromsViewController *)[self pushform:@"IndustryFromsID"];
        views.selectIndex=3;
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.ID] forKey:@"industryId"];
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.任务ID] forKey:@"taskIdIndustry"];
        [kUserDefaults setObject:@"工业查看" forKey:@"工业查看"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"industryLouceng"]){
        IndustryFromsViewController *views=(IndustryFromsViewController *)[self pushform:@"IndustryFromsID"];
        views.selectIndex=4;
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.ID] forKey:@"industryId"];
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.任务ID] forKey:@"taskIdIndustry"];
        [kUserDefaults setObject:@"工业查看" forKey:@"工业查看"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"industryFangwu"]){
        IndustryFromsViewController *views=(IndustryFromsViewController *)[self pushform:@"IndustryFromsID"];
        views.selectIndex=5;
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.ID] forKey:@"industryId"];
        [kUserDefaults setObject:[super replaceString:historicalRecordListModel.任务ID] forKey:@"taskIdIndustry"];
        [kUserDefaults setObject:@"工业查看" forKey:@"工业查看"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"houseXiaoqu"]){
        LowFormViewController *views=(LowFormViewController *)[self pushform:@"LowFormViewID"];
        views.selectIndex=0;
        views.selectSee=@"查看";
        views.formID=historicalRecordListModel.任务ID;
        [kUserDefaults setObject:historicalRecordListModel.ID forKey:@"lowDensityId"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"houseBuding"]){
        LowFormViewController *views=(LowFormViewController *)[self pushform:@"LowFormViewID"];
        views.selectIndex=1;
        views.selectSee=@"查看";
        views.formID=historicalRecordListModel.任务ID;
        [kUserDefaults setObject:historicalRecordListModel.ID forKey:@"lowDensityId"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"houseFangwu"]){
        LowFormViewController *views=(LowFormViewController *)[self pushform:@"LowFormViewID"];
        views.selectIndex=2;
        views.selectSee=@"查看";
        views.formID=historicalRecordListModel.任务ID;
        [kUserDefaults setObject:historicalRecordListModel.ID forKey:@"lowDensityId"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"houseDLoupan"]){
        OrdinaryFormViewController *views=(OrdinaryFormViewController *)[self pushform:@"OrdinaryFormViewID"];
        views.selectIndex=0;
        views.selectSee=@"查看";
        views.formID=historicalRecordListModel.任务ID;
        [kUserDefaults setObject:historicalRecordListModel.ID forKey:@"ordinaryId"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"houseDBuding"]){
        OrdinaryFormViewController *views=(OrdinaryFormViewController *)[self pushform:@"OrdinaryFormViewID"];
        views.selectIndex=1;
        views.selectSee=@"查看";
        views.formID=historicalRecordListModel.任务ID;
        [kUserDefaults setObject:historicalRecordListModel.ID forKey:@"ordinaryId"];
        [self.navigationController pushViewController:views animated:YES];
    }else if ([historicalRecordListModel.TASKTYPE isEqualToString:@"houseDFangwu"]){
        OrdinaryFormViewController *views=(OrdinaryFormViewController *)[self pushform:@"OrdinaryFormViewID"];
        views.selectIndex=2;
        views.selectSee=@"查看";
        views.formID=historicalRecordListModel.任务ID;
        [kUserDefaults setObject:historicalRecordListModel.ID forKey:@"ordinaryId"];
        [self.navigationController pushViewController:views animated:YES];
    }
//    [self performSegueWithIdentifier:@"BusinessFormsVC1" sender:nil];
}

-(UIViewController *)pushform:(NSString *)xibName{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *ViewController=[storyboard instantiateViewControllerWithIdentifier:xibName];
    return ViewController;
}

//UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"fasfas");
}

-(void)netWork:(int)page{
    __weak typeof(self)SelfWeek=self;
    NSLog(@"%@",self.searchView.startTime.titleLabel.text);
    [ NetworkManager requestWithMethod:@"POST" bodyParameter:@{@"type":self.searchView.categoryButton.titleLabel.text,@"":self.searchView.startTime,@"pageNo":[NSString stringWithFormat:@"%d",page]} relativePath:@"appAction!checkList.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        historicalRecordModel=[[HistoricalRecordModel alloc]initWithDictionary:responseObject error:nil];
        [SelfWeek.baseTableView.mj_header endRefreshing];
        [SelfWeek.baseTableView.mj_footer endRefreshing];
        if (historicalRecordModel) {
            if ([historicalRecordModel.status isEqualToString:@"1"]) {
                if (historicalRecordModel.list.count) {
                    if (page==1&&self.baseArray.count!=0) {
                        [self.baseArray removeAllObjects];
                        [self.baseArray addObjectsFromArray:historicalRecordModel.list];
                    }else{
                        [self.baseArray addObjectsFromArray:historicalRecordModel.list];
                    }
                }else{
                    
                }

            }else{
                [SelfWeek _initTitle:NOJSONTITLE];
            }
            
        }else{
            [SelfWeek _initTitle:NOJSONTITLE];
        }
        [SelfWeek.baseTableView reloadData];
    } failure:^(NSError *error) {
        [SelfWeek.baseTableView.mj_header endRefreshing];
        [SelfWeek.baseTableView.mj_footer endRefreshing];
        NSLog(@"%@",error.userInfo);
        [SelfWeek _initTitle:NONETTITLE];
    }];

}

-(void)_initTitle:(NSString *)title{
    [BaseView _init:title View:self.view];
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
