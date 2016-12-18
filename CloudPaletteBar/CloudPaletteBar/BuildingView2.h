//
//  BuildingView2.h
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/9/6.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuildingView2TableViewCell.h"

@interface BuildingView2 : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)void (^BuildingButton)(NSArray *arr,int number);

-(void)_initArray:(NSArray *)array andSelectArray:(NSArray *)array2 andIndex:(int)index;

@end
