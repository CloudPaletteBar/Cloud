//
//  BuildingView2.m
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/9/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BuildingView2.h"

@implementation BuildingView2
{
    int number;
    NSArray *beanArray;
    NSMutableArray *buildingArray;
    __weak IBOutlet UITableView *buildingTableView;
}

- (IBAction)clickButton:(id)sender {
    
    if (_BuildingButton) {
        _BuildingButton(buildingArray,number);
    }
}

-(void)_initArray:(NSArray *)array andSelectArray:(NSArray *)array2 andIndex:(int)index{
    number = index;
    buildingTableView.delegate = self;
    buildingTableView.dataSource = self;
    beanArray = [NSArray arrayWithArray:array];
    buildingArray = [NSMutableArray arrayWithArray:array2];
    [buildingTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return beanArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indertifier = @"buildingView2TableViewCell";
    BuildingView2TableViewCell *cell = (BuildingView2TableViewCell *)[tableView dequeueReusableCellWithIdentifier:indertifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BuildingView2TableViewCell" owner:self options:nil] lastObject];
    }
    if (beanArray.count > 0) {
        [cell laodData:[beanArray objectAtIndex:indexPath.row]];
    }
    
    NSString *string2 = [beanArray objectAtIndex:indexPath.row];
    for (NSString *string in buildingArray) {
        if ([string isEqualToString:string2]) {
            cell.selectButton.selected = YES;
        }
    }
    
    cell.SelectViewButton=^(NSString *str){
        if (![buildingArray containsObject:str]) {
            [buildingArray addObject:str];
        }else{
            [buildingArray removeObject:str];
        }
        NSLog(@"%@",buildingArray);
    };
    return cell;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
