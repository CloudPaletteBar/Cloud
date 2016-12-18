//
//  MyReviewViewController.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/10.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MyReviewViewController.h"
#import "OfficeQuestionnaireModel.h"
#import "NetworkManager.h"
#import "MyReviewCell.h"
#import "SearchView.h"
#import "OrdinaryFormViewController.h"
#import "LowFormViewController.h"
#import "FormViewController.h"
#import "IndustryFromsViewController.h"
#import "BusinessFormsViewController.h"



static NSString *Identifier=@"Identifier";

@interface MyReviewViewController ()
{
    CGFloat         searchViewW;
    NSString        *userName;
}
@property (assign, nonatomic)CGFloat searchViewH;
@property (strong, nonatomic)SearchView *searchView;

@end

@implementation MyReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseArray=[[NSMutableArray alloc]init];
    userName = userNameDefaults;
    
    [self.baseTableView registerNib:[UINib nibWithNibName:@"MyReviewCell" bundle:nil] forCellReuseIdentifier:Identifier];
    
    self.baseTableView.frame = CGRectMake(0,startingH2, MainScreenWidth, MainScreenheight-startingH2);
    [self searchV];
}

-(void)searchV{
    if (self.searchView == nil) {
        
        self.searchView = [[[NSBundle mainBundle]loadNibNamed:@"SearchView" owner:self options:nil] lastObject];
        self.searchView.backgroundColor = [UIColor clearColor];
        [self.searchView loadOtherView];
        searchViewW = self.searchView.frame.size.width;
        self.searchViewH = 96;
        
        __weak typeof(self) searchBlock = self;
        self.searchView.PulldownButton = ^(NSString *upDown){
            if ([upDown isEqualToString:@"上"]) {
                searchBlock.searchView.frame = CGRectMake(0, 64, MainScreenWidth, 208+searchBlock.searchViewH);
                searchBlock.baseTableView.frame = CGRectMake(0, startingH2+208, MainScreenWidth, MainScreenheight-startingH2-208);
            }else{
                searchBlock.searchView.frame = CGRectMake(0, 64, MainScreenWidth, searchBlock.searchViewH);
                searchBlock.baseTableView.frame = CGRectMake(0, startingH2, MainScreenWidth, MainScreenheight-startingH2);
            }
        };
        
        self.searchView.SearchData = ^(NSString *nameStr, NSString *areaStr, NSString *categoryStr, NSString *startStr, NSString *endStr){
            NSLog(@"点击了搜索");
        };
        
        self.searchView.frame = CGRectMake(0, 64, MainScreenWidth, self.searchViewH);
        [self.view addSubview:self.searchView];
        
        self.searchView.label1.text = @"楼栋编号";
        self.searchView.label2.text = @"实际楼栋名称";
        self.searchView.label3.text = @"项目类型";
    }
}

-(void)netWork:(int)page{
    
    __weak typeof(self)SelfWeek=self;
    [ NetworkManager requestWithMethod:@"POST" bodyParameter:@{@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10",@"user":userName} relativePath:@"appAction!checkList.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        OfficeQuestionnaireModel *officeQuestionnaireModel=[[OfficeQuestionnaireModel alloc]initWithDictionary:responseObject error:nil];
        [SelfWeek tableviewEnd];
        if (officeQuestionnaireModel) {
            if (officeQuestionnaireModel.list.count) {
                if (page==1) {
                    [SelfWeek.baseArray removeAllObjects];
                    [SelfWeek.baseArray addObjectsFromArray:officeQuestionnaireModel.list];
                }else{
                    [SelfWeek.baseArray addObjectsFromArray:officeQuestionnaireModel.list];
                }
            }else{
                [BaseView _init:@"已经没数据了" View:SelfWeek.view];
            }
        }else{
            [BaseView _init:@"亲你的网络不给力哦" View:SelfWeek.view];
        }
        [SelfWeek.baseTableView reloadData];
    } failure:^(NSError *error) {
        [SelfWeek tableviewEnd];
        [BaseView _init:@"亲网络异常请稍后" View:SelfWeek.view];
    }];
}

-(void)tableviewEnd{
    [self.baseTableView.mj_header endRefreshing];
    [self.baseTableView.mj_footer endRefreshing];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.baseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    [cell _initCell:[self.baseArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    OfficeQuestionnaireListModel *officeListModel = [self.baseArray objectAtIndex:indexPath.row];
    
    if ([officeListModel.TYPE isEqualToString:@"办公"]) {
        FormViewController *formVC = [[FormViewController alloc]init];
        [self.navigationController pushViewController:formVC animated:YES];
    }else if ([officeListModel.TYPE isEqualToString:@"工业"]){
        IndustryFromsViewController *industryVC = [[IndustryFromsViewController alloc]init];
        [self.navigationController pushViewController:industryVC animated:YES];
    }else if ([officeListModel.TYPE isEqualToString:@"低密度住宅"]){
        LowFormViewController *lowVC = [[LowFormViewController alloc]init];
        [self.navigationController pushViewController:lowVC animated:YES];
    }else if ([officeListModel.TYPE isEqualToString:@"普通住宅"]){
        OrdinaryFormViewController *ordinaryVC = [[OrdinaryFormViewController alloc]init];
        [self.navigationController pushViewController:ordinaryVC animated:YES];
    }else{
        BusinessFormsViewController *businessVC = [[BusinessFormsViewController alloc]init];
        [self.navigationController pushViewController:businessVC animated:YES];
    }
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
