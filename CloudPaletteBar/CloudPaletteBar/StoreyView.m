//
//  StoreyView.m
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/10/5.
//  Copyright © 2016年 test. All rights reserved.
//

#import "StoreyView.h"
#import "BuildingView2TableViewCell.h"
#import "MacroDefinition.h"

@implementation StoreyView
{
    __weak IBOutlet UITableView *floorTableView;
    NSArray *beanArray;
    NSMutableArray *openArray;
    NSMutableArray *buildingArray1, *buildingArray2, *buildingArray3;
}

- (IBAction)clickButton:(id)sender {
    
    if (_BuildingButton) {
        _BuildingButton(buildingArray1,buildingArray2, buildingArray3);
    }
}


-(void)_initArray:(NSArray *)array andArray1:(NSArray *)array1 andArray2:(NSArray *)array2 andArray3:(NSArray *)array3{
    
    floorTableView.delegate = self;
    floorTableView.dataSource = self;
    beanArray = [NSArray arrayWithArray:array];
    openArray = [NSMutableArray arrayWithCapacity:3];
    buildingArray1 = [NSMutableArray arrayWithArray:array1];
    buildingArray2 = [NSMutableArray arrayWithArray:array2];
    buildingArray3 = [NSMutableArray arrayWithArray:array3];
    
    [self openarray];
    [floorTableView reloadData];
}
-(void)openarray{
    for (int i=0; i<3; i++) {
        [openArray addObject:@"no"];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[openArray objectAtIndex:section] isEqualToString:@"yes"]) {
        NSArray *array = [beanArray objectAtIndex:section];
        return array.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 43;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indertifier = @"buildingView2TableViewCell";
    BuildingView2TableViewCell *cell = (BuildingView2TableViewCell *)[tableView dequeueReusableCellWithIdentifier:indertifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BuildingView2TableViewCell" owner:self options:nil] lastObject];
    }
    if (beanArray.count > 0) {
        [cell laodData:[[beanArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    }
    
    switch (indexPath.section) {
        case 0:{
            NSString *string2 = [[beanArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            for (NSString *string in buildingArray1) {
                if ([string isEqualToString:string2]) {
                    cell.selectButton.selected = YES;
                }
            }
            cell.SelectViewButton=^(NSString *str){
                if (![buildingArray1 containsObject:str]) {
                    [buildingArray1 addObject:str];
                }else{
                    [buildingArray1 removeObject:str];
                }
                NSLog(@"%@",buildingArray1);
            };
        }
            break;
        case 1:{
            NSString *string2 = [[beanArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            for (NSString *string in buildingArray2) {
                if ([string isEqualToString:string2]) {
                    cell.selectButton.selected = YES;
                }
            }
            cell.SelectViewButton=^(NSString *str){
                if (![buildingArray2 containsObject:str]) {
                    [buildingArray2 addObject:str];
                }else{
                    [buildingArray2 removeObject:str];
                }
                NSLog(@"%@",buildingArray2);
            };
        }
            break;
        case 2:{
            NSString *string2 = [[beanArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            for (NSString *string in buildingArray3) {
                if ([string isEqualToString:string2]) {
                    cell.selectButton.selected = YES;
                }
            }
            cell.SelectViewButton=^(NSString *str){
                if (![buildingArray3 containsObject:str]) {
                    [buildingArray3 addObject:str];
                }else{
                    [buildingArray3 removeObject:str];
                }
                NSLog(@"%@",buildingArray3);
            };
        }
            break;
    }
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 43)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, MainScreenWidth, 43);
    button.tag = section;
    [button addTarget:self action:@selector(clickButton2:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [view addSubview:button];
    
    switch (section) {
        case 0:
            [button setTitle:@"商品零售业态" forState:UIControlStateNormal];
            break;
        case 1:
            [button setTitle:@"餐饮零售业态" forState:UIControlStateNormal];
            break;
        case 2:
            [button setTitle:@"服务零售业态" forState:UIControlStateNormal];
            break;
    }
    return view;
}

-(void)clickButton2:(UIButton *)sender{
    
    if ([[openArray objectAtIndex:sender.tag]isEqualToString:@"yes"]) {
        [openArray replaceObjectAtIndex:sender.tag withObject:@"no"];
    }else{
        [openArray replaceObjectAtIndex:sender.tag withObject:@"yes"];
    }
    
    [floorTableView beginUpdates];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:sender.tag];
    [floorTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [floorTableView endUpdates];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
