//
//  BaseTableNoMJViewController.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BaseTableNoMJViewController.h"



static NSString *Identifier=@"Identifier";
@interface BaseTableNoMJViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseTableNoMJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseTableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.baseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier];
    self.baseTableView.tableFooterView=[[UIView alloc]init];
    self.baseTableView.delegate=self;
    self.baseTableView.dataSource=self;
    [self.view addSubview:self.baseTableView];
    
    self.baseTableView.backgroundColor = [UIColor whiteColor];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

//调整cell的分割线
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.baseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    UITableView *cell=[super tableView:tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
//    cell.textLabel.text=[self.baseArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.view endEditing:YES];
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
