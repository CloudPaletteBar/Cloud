//
//  FormSelectTableView.m
//  CloudPaletteBar
//
//  Created by test on 16/8/16.
//  Copyright © 2016年 test. All rights reserved.
//

#import "FormSelectTableView.h"
#import "BaseView.h"
#import "NetworkManager.h"
#import "MJRefresh.h"
#import "NoDataView.h"

static NSString *Identifier=@"Identifier";

@interface FormSelectTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    int page;
}
@end

@implementation FormSelectTableView

-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier];
        self.delegate=self;
        self.dataSource=self;
    }
    return self;
}

-(void)_initOrderUP:(void (^)(int Page))UP Down:(void (^)(int Page))Down{
    
    // 下拉刷新
    self.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page=1;
        UP(page);
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page=page+1;
        Down(page);
        
    }];
    [self.mj_header beginRefreshing];
    
}


-(void)setFormSelectArray:(NSArray *)formSelectArray{
    __weak typeof(self)SelfWeek=self;
    self.tableFooterView=[[UIView alloc]init];
    if (formSelectArray==nil) {
        self.tableFooterView=[[UIView alloc]init];
        
    }else if (formSelectArray.count==0){
        self.tableFooterView=[[[NSBundle mainBundle]loadNibNamed:@"NoDataView" owner:self options:nil]lastObject];
    }
        _formSelectArray=formSelectArray;
    [SelfWeek reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _formSelectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    cell.textLabel.text=[_formSelectArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.SelectIndex) {
        self.SelectIndex([_formSelectArray objectAtIndex:indexPath.row],indexPath.row);
        [[BaseView baseShar]dissMissPop:YES];
    }
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
//}

@end
