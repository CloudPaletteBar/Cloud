//
//  StoreMarketView.h
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/10/5.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreMarketView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *formSelectArray;
@property(nonatomic,strong)IBOutlet UITableView *shopsTableView;

@property (weak, nonatomic) IBOutlet UIView *breakView;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;


-(void)_initOrderUP:(void (^)(int Page))UP Down:(void (^)(int Page))Down;
@property(nonatomic,copy)void (^ SelectIndex)(NSArray *array,NSArray *array2);
@property(nonatomic,copy)void (^ SelectIndex2)(NSArray *array, NSString *str);

-(void)footerView;


@end
