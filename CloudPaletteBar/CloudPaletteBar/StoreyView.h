//
//  StoreyView.h
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/10/5.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreyView : UIView<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)void (^BuildingButton)(NSArray *arr1,NSArray *arr2, NSArray *arr3);


-(void)_initArray:(NSArray *)array andArray1:(NSArray *)array1 andArray2:(NSArray *)array2 andArray3:(NSArray *)array3;

@end
