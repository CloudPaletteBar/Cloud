//
//  TaskDetailsViewController.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import "TaskDetailsViewController.h"
#import "TaskDetailsFootView.h"
#import "NetworkManager.h"
#import "TaskDetailsModel.h"
#import "CloudPaletteBar.h"
#import "TaskDetailsCell.h"
#import "BusinessQuestionnaireViewController.h"
#import "IndustryQuestionnaireViewController.h"
#import "OfficeQuestionnaireViewController.h"
#import "LowDensityQuestionnaireViewController.h"
#import "OrdinaryQuestionnaireViewController.h"

@interface TaskDetailsViewController ()
{
    TaskDetailsModel *taskDetailsModel;
}
@end

static NSString *Identifier=@"Identifier";
static NSString *Identifier2=@"Identifier2";

@implementation TaskDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"任务详情";
    self.baseArray=[NSMutableArray arrayWithArray:[NetworkManager _readInit:@"TaskDetailsPlish"]];
    [self.baseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"TaskDetailsCell" bundle:nil] forCellReuseIdentifier:Identifier2];

    
    self.baseTableView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenheight);
    NSLog(@"%@",self.taskId);
    [self taskNet];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.baseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   NSString *key=[self.baseArray objectAtIndex:indexPath.row];
    if (indexPath.row==self.baseArray.count-1) {
        TaskDetailsCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier2 forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell _init:key Cell:[taskDetailsModel.list objectAtIndex:0]];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        TaskDetailsListModel *taskDetailsListModel;
        if (taskDetailsModel.list.count>0) {
            
            taskDetailsListModel=[taskDetailsModel.list objectAtIndex:0];
            NSLog(@"%@",taskDetailsListModel.toDictionary);
            cell.textLabel.text=[NSString stringWithFormat:@"%@:%@",key,[taskDetailsListModel.toDictionary objectForKey:key]];
            if ([key isEqualToString:@"开始时间"]) {
                cell.textLabel.text=[NSString stringWithFormat:@"%@:%@",key,[NetworkManager interceptStrTo:taskDetailsListModel.开始时间 PleStr:@" "]];
            }else if ([key isEqualToString:@"结束时间"]){
                cell.textLabel.text=[NSString stringWithFormat:@"%@:%@",key,[NetworkManager interceptStrTo:taskDetailsListModel.结束时间 PleStr:@" "]];
            }
        }else{
            cell.textLabel.text=key;
        }
        return cell;
    }
   
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([[[[NSUserDefaults standardUserDefaults]objectForKey:@"homes"] objectForKey:@"usertype"] isEqualToString:@"2"]) {
        TaskDetailsFootView *taskDetailsFootView=[[[NSBundle mainBundle]loadNibNamed:@"TaskDetailsFootView" owner:self options:nil] lastObject];
        __weak typeof(self)SelfWeek=self;
        taskDetailsFootView.TaskExecuteTask=^(){
            NSLog(@"执行任务");
            [SelfWeek push];
        };
        return taskDetailsFootView;
    }else
        return nil;
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([[[[NSUserDefaults standardUserDefaults]objectForKey:@"homes"] objectForKey:@"usertype"] isEqualToString:@"2"]) {
        return 50;
    }
    return 0;
}

-(void)taskNet{
    __weak typeof(self)SelfWeek=self;
    [[BaseView baseShar]_initMBProgressHUD:self.view Title:@"请稍后..."];
    [ NetworkManager requestWithMethod:@"POST" bodyParameter:@{@"taskId":self.taskId} relativePath:@"appAction!showTask.chtml" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        taskDetailsModel=[[TaskDetailsModel alloc]initWithDictionary:responseObject error:nil];
        if (taskDetailsModel) {
            if ([taskDetailsModel.status isEqualToString:@"1"]) {
                [self.baseTableView reloadData];
            }else{
                [SelfWeek _initTitle:NOJSONTITLE];
            }
            
        }else{
            [SelfWeek _initTitle:NOJSONTITLE];
        }
        [[BaseView baseShar]dissMiss];
    } failure:^(NSError *error) {
        [[BaseView baseShar]dissMiss];
        NSLog(@"%@",error.userInfo);
        [SelfWeek _initTitle:NONETTITLE];
    }];

}

-(void)_initTitle:(NSString *)title{
    [BaseView _init:title View:self.view];
}

-(void)push{
    TaskDetailsListModel *taskDetailsListModel;
    if (taskDetailsModel.list.count>0) {
        
        taskDetailsListModel=[taskDetailsModel.list objectAtIndex:0];
        if ([taskDetailsListModel.项目类型 isEqualToString:@"商业类型"]) {
            BusinessQuestionnaireViewController *businessQuestionnaireViewController=(BusinessQuestionnaireViewController *)[self PushContoller:@"BusinessQuestionnaireViewID"];
            //                传任务id
            businessQuestionnaireViewController.taskId = taskDetailsListModel.ID;
            [self.navigationController pushViewController:businessQuestionnaireViewController animated:YES];
        }else if ([taskDetailsListModel.项目类型 isEqualToString:@"工业类型"]){
            IndustryQuestionnaireViewController *industryQuestionnaireViewController=(IndustryQuestionnaireViewController *)[self PushContoller:@"IndustryQuestionnaireViewID"];
            industryQuestionnaireViewController.taskId = taskDetailsListModel.ID;
            [self.navigationController pushViewController:industryQuestionnaireViewController animated:YES];
        }else if ([taskDetailsListModel.项目类型 isEqualToString:@"办公类型"]){
            OfficeQuestionnaireViewController *officeQuestionnaireViewController=(OfficeQuestionnaireViewController *)[self PushContoller:@"OfficeQuestionnaireViewID"];
            NSLog(@"%@",taskDetailsListModel.ID);
            officeQuestionnaireViewController.QID=taskDetailsListModel.ID;
            [self.navigationController pushViewController:officeQuestionnaireViewController animated:YES];
        }else{
            if ([taskDetailsListModel.调查子类 isEqualToString:@"普通住宅" ]) {
                OrdinaryQuestionnaireViewController *ordinaryQuestionnaireViewController=(OrdinaryQuestionnaireViewController *)[self PushContoller:@"OrdinaryQuestionnaireViewID"];
                NSLog(@"%@",taskDetailsListModel.ID);
                ordinaryQuestionnaireViewController.QID=taskDetailsListModel.ID;
                [self.navigationController pushViewController:ordinaryQuestionnaireViewController animated:YES];
            }else{
                LowDensityQuestionnaireViewController *lowDensityQuestionnaireViewController=(LowDensityQuestionnaireViewController *)[self PushContoller:@"LowDensityQuestionnaireViewID"];
                NSLog(@"%@",taskDetailsListModel.ID);
                lowDensityQuestionnaireViewController.QID=taskDetailsListModel.ID;
                [self.navigationController pushViewController:lowDensityQuestionnaireViewController animated:YES];
            }
            
        }
        //                传任务id
            }else{
                [self _initTitle:NONETTITLE];
            }

}

-(UIViewController *)PushContoller:(NSString *)nibName{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:nibName];
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
