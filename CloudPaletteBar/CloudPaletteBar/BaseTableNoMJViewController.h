//
//  BaseTableNoMJViewController.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableNoMJViewController : BaseViewController
@property(nonatomic,strong)UITableView *baseTableView;
@property(nonatomic,strong)NSMutableArray *baseArray;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
