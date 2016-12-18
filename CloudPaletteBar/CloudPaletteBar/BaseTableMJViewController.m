//
//  BaseTableMJViewController.m
//  CloudPaletteBar
//
//  Created by test on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BaseTableMJViewController.h"
#import "MJRefresh.h"

@interface BaseTableMJViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int page;
}
@end

static NSString *Identifier=@"Identifier";

@implementation BaseTableMJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseTableView=[[UITableView alloc]initWithFrame:self.view.frame];
    [self.baseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier];
    self.baseTableView.tableFooterView=[[UIView alloc]init];
    self.baseTableView.delegate=self;
    self.baseTableView.dataSource=self;
    [self.view addSubview:self.baseTableView];
    [self _initOrder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    UITableView *cell=[super tableView:tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.baseTableView.mj_header beginRefreshing];
}

-(void)_initOrder {
    __weak typeof(self)weakSelf=self;
    
    // 下拉刷新
    self.baseTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page=1;
        [weakSelf netWork:page];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.baseTableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.baseTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf netWork:page++];
        
    }];
    
    
}
//上啦下拉调用此方法即可
-(void)netWork:(int)page{
    
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
