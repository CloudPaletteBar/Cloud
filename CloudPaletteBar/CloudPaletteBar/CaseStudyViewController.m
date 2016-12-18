//
//  CaseStudyViewController.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/10.
//  Copyright © 2016年 test. All rights reserved.
//

#import "CaseStudyViewController.h"
#import "NetworkManager.h"
#import "CaseStudyCell.h"

static NSString *Identifier=@"Identifier";

@interface CaseStudyViewController ()

@end

@implementation CaseStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"CaseStudyCell" bundle:nil] forCellReuseIdentifier:Identifier];
    self.baseArray=[NetworkManager _readInit:@"CaseStudyPlish"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    UITableView *cell=[super tableView:tableView cellForRowAtIndexPath:indexPath];
    CaseStudyCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    [cell _initCell:[self.baseArray objectAtIndex:indexPath.row] Index:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            //商业调查表
            [self performSegueWithIdentifier:@"BusinessVC" sender:nil];
        }
            break;
        case 1:{
            //工业调查表
            [self performSegueWithIdentifier:@"IndustryVC" sender:nil];
        }
            break;
        case 2:{
            //办公调查表
            [self performSegueWithIdentifier:@"OfficeVC" sender:nil];
        }
            break;
        case 3:{
            //低密度住宅调查表
            [self performSegueWithIdentifier:@"LowDensityVC" sender:nil];
        }
            break;
        case 4:{
            //普通住宅调查表
            [self performSegueWithIdentifier:@"OrdinaryVC" sender:nil];
        }
            break;
    }
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
