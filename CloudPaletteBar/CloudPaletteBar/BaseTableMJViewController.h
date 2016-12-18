//
//  BaseTableMJViewController.h
//  CloudPaletteBar
//
//  Created by test on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"

static const int startingH = 150;
static const int startingH2 = 96;

@interface BaseTableMJViewController : BaseViewController
@property(nonatomic,strong)UITableView *baseTableView;
@property(nonatomic,strong)NSMutableArray *baseArray;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


//上啦下拉调用此方法即可
-(void)netWork:(int)page;

@end
