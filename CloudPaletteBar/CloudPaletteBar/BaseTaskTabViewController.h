//
//  BaseTabViewController.h
//  CloudPaletteBar
//
//  Created by test on 16/8/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTaskTabViewController : UIViewController
@property(nonatomic,strong)UITableView *baseTableView;
@property(nonatomic,strong)NSMutableArray *baseArray;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
