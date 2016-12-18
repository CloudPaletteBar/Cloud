//
//  FishTaskViewController.m
//  CloudPaletteBar
//
//  Created by test on 16/8/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import "FishTaskViewController.h"
#import "TaskCell.h"
#import "CloudPaletteBar.h"
#import "TaskDetailsViewController.h"
#import "UpcomingTasksModel.h"
#import "MJRefresh.h"
#import "NetworkManager.h"
#import "BaseView.h"

static NSString *Identifier=@"Identifier";

@interface FishTaskViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    UISearchBar *seachBar;
    UpcomingTasksModel *upcomingTasksModel;
    NSMutableArray *dataArray;
}
@end

@implementation FishTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray=[[NSMutableArray alloc]init];
    seachBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, screen_width, 44)];
    seachBar.delegate = self;
    seachBar.placeholder=@"请输入任务名称";
    [self.view addSubview:seachBar];
    self.baseTableView.frame=CGRectMake(0, 44, screen_width, screen_height-44);
    [self.baseTableView registerNib:[UINib nibWithNibName:@"TaskCell" bundle:nil] forCellReuseIdentifier:Identifier];
}

-(void)netWork:(int)page{
    __weak typeof(self)SelfWeek=self;
    [ NetworkManager requestWithMethod:@"POST" bodyParameter:@{@"taskName":seachBar.text,@"taskType":@"1",@"pageNo":[NSString stringWithFormat:@"%d",page],@"pageSize":@"10"} relativePath:@"appAction!myTask.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        upcomingTasksModel=[[UpcomingTasksModel alloc]initWithDictionary:responseObject error:nil];
        [SelfWeek.baseTableView.mj_header endRefreshing];
        [SelfWeek.baseTableView.mj_footer endRefreshing];
        if (upcomingTasksModel) {
            if (seachBar.text.length>0) {
                [dataArray removeAllObjects];
            }
            if (upcomingTasksModel.list.count) {
                if (page==1&&dataArray.count!=0) {
                    [dataArray removeAllObjects];
                    [dataArray addObjectsFromArray:upcomingTasksModel.list];
                }else{
                    [dataArray addObjectsFromArray:upcomingTasksModel.list];
                    
                }
                
            }else{
                
            }
        }else{
            [SelfWeek _initTitle:@"亲你的网络不给力啊"];
        }
        [SelfWeek.baseTableView reloadData];
    } failure:^(NSError *error) {
        [SelfWeek.baseTableView.mj_header endRefreshing];
        [SelfWeek.baseTableView.mj_footer endRefreshing];
        NSLog(@"%@",error.userInfo);
        [SelfWeek _initTitle:@"亲网络异常请稍后"];
    }];

}

-(void)_initTitle:(NSString *)title{
    [BaseView _init:title View:self.view];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    [cell cell_init:[dataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    TaskDetailsView
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TaskDetailsViewController *taskDetailsViewController=[storyboard instantiateViewControllerWithIdentifier:@"TaskDetailsView"];
    UpcomingTasksListModel *upcomingTasksListModel=[upcomingTasksModel.list objectAtIndex:indexPath.row];
    taskDetailsViewController.taskId=upcomingTasksListModel.TASKID;
    [self.navigationController pushViewController:taskDetailsViewController animated:YES];
    
}

//UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
    [self netWork:1];
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
