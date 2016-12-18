//
//  StoreMarketView.m
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/10/5.
//  Copyright © 2016年 test. All rights reserved.
//

#import "StoreMarketView.h"
#import "MJRefresh.h"
#import "BaseView.h"
#import "ShopsViewTableViewCell.h"

@implementation StoreMarketView
{
    int page;
    NSMutableArray *buildingArray1, *buildingArray2;
    
    __weak IBOutlet UIButton *chaifenButton1;
    __weak IBOutlet UIButton *chaifenButton2;
    
    __weak IBOutlet UIButton *hebingButton1;
    __weak IBOutlet UIButton *hebingButton2;
    
}

-(void)layerView:(UIView *)view{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.0;
}

-(void)footerView{
    
    [self layerView:chaifenButton1];
    [self layerView:chaifenButton2];
    [self layerView:hebingButton1];
    [self layerView:hebingButton2];
    
    
    _shopsTableView.tableFooterView=[[UIView alloc]init];
    _shopsTableView.delegate = self;
    _shopsTableView.dataSource = self;
    buildingArray1 = [NSMutableArray arrayWithCapacity:1];
    buildingArray2 = [NSMutableArray arrayWithCapacity:1];
    _formSelectArray = [NSMutableArray arrayWithCapacity:1];
}

-(void)_initOrderUP:(void (^)(int Page))UP Down:(void (^)(int Page))Down{
    
    // 下拉刷新
    self.shopsTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page=1;
        UP(page);
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.shopsTableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.shopsTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page=page+1;
        Down(page);
        
    }];
    [self.shopsTableView.mj_header beginRefreshing];
    
}


-(void)setFormSelectArray:(NSArray *)formSelectArray{
    _formSelectArray=formSelectArray;
    [self.shopsTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _formSelectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indertifier = @"shopsViewTableViewCell";
    ShopsViewTableViewCell *cell = (ShopsViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:indertifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShopsViewTableViewCell" owner:self options:nil] lastObject];
    }
    if (_formSelectArray.count > 0) {
        [cell laodData:[_formSelectArray objectAtIndex:indexPath.row]];
    }
    
    cell.SelectViewButton=^(NSString *str, NSString *str2){
        if (![buildingArray1 containsObject:str]) {
            [buildingArray1 addObject:str];
            [buildingArray2 addObject:str2];
        }else{
            [buildingArray1 removeObject:str];
            [buildingArray2 removeObject:str2];
        }
        NSLog(@"%@==%@",buildingArray1,buildingArray2);
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//取消
-(IBAction)cancelButton:(id)sender{
    [[BaseView baseShar]dissMissPop:YES];
}

//合并确定
-(IBAction)determineButton:(id)sender{
    if (self.SelectIndex) {
        self.SelectIndex(buildingArray1,buildingArray2);
    }
}

//拆分确定
-(IBAction)breakButton:(id)sender{
    if (self.SelectIndex2) {
        self.SelectIndex2(buildingArray1, self.numberTextField.text);
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
