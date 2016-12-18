//
//  SelectView.m
//  DriverSide
//
//  Created by test on 16/7/22.
//  Copyright © 2016年 test. All rights reserved.
//

#import "SelectView.h"
#import "SelectHeatView.h"
#import "CloudPaletteBar.h"


static NSString *reuseIdentifier=@"reuseIdentifier";

@interface  SelectView(){
    NSString *carNo;
}

@end

@implementation SelectView


-(void)_init{
    self.backgroundColor=[UIColor clearColor];
    Open=YES;
    [self.selectTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.selectTableView.delegate=self;
    self.selectTableView.dataSource=self;
    self.selectTableView.tableFooterView=[[UIView alloc]init];
    
}

-(void)setDataArray:(NSArray *)dataArray{
    
    _dataArray = dataArray;
    [self.selectTableView reloadData];
}

#pragma mark ----- UITableViewDelegate,UITableViewDataSource -----

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.baseCommonSeachHeatView=[[[NSBundle mainBundle]loadNibNamed:@"SelectHeatView" owner:self options:nil]lastObject];
    self.baseCommonSeachHeatView.frame=CGRectMake(0, 0, 100, 35);
    [self.baseCommonSeachHeatView.selectButton setTitle:[NSString stringWithFormat:@"  %@",self.buttonTitle] forState:UIControlStateNormal];
    [self.baseCommonSeachHeatView.selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (carNo) {
        [self.baseCommonSeachHeatView.selectButton setTitle:[NSString stringWithFormat:@"  %@",carNo] forState:UIControlStateNormal];
        [self.baseCommonSeachHeatView.selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    self.baseCommonSeachHeatView.ClockHeat=^(){
        if (Open==NO) {
            Open=YES;
        }else{
            Open=NO;
        }
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
        [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    };
    return self.baseCommonSeachHeatView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (Open==YES) {
        self.frame=CGRectMake(0, self.ViewHeightY, screen_width, 35);
        return 0;
        
    }
    Open=NO;
    self.frame=CGRectMake(0, self.ViewHeightY, screen_width, 316);
    return self.dataArray.count;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
    Open=YES;
    self.frame=CGRectMake(0, self.ViewHeightY, screen_width, 35);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
     CarNumberResultRelateVehicleListModel *carNumberResultRelateVehicleListModel=[self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text=carNumberResultRelateVehicleListModel.PlateNo;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     CarNumberResultRelateVehicleListModel *carNumberResultRelateVehicleListModel=[self.dataArray objectAtIndex:indexPath.row];
    carNo=carNumberResultRelateVehicleListModel.PlateNo;
    Open=YES;
    if (self.ClockSelect) {
        self.ClockSelect(carNumberResultRelateVehicleListModel);
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
    [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}


@end
