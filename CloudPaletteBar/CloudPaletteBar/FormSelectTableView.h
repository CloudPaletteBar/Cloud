//
//  FormSelectTableView.h
//  CloudPaletteBar
//
//  Created by test on 16/8/16.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormSelectTableView : UITableView

@property(nonatomic,strong)NSArray *formSelectArray;
@property(nonatomic,assign)NSInteger TagT;
//沙拉下啦
-(void)_initOrderUP:(void (^)(int Page))UP Down:(void (^)(int Page))Down;
@property(nonatomic,copy)void (^ SelectIndex)(NSString *selectStr,NSInteger Index);
@end
