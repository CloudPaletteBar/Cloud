//
//  FormSelectView.h
//  CloudPaletteBar
//
//  Created by test on 16/8/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormSelectView : UIView
@property(nonatomic,assign)NSInteger selectIndex;
- (void)addSubVc:(NSArray *)vc subTitles:(NSArray *)titles LineArray:(NSMutableArray *)lineArray ImageNameArray:(NSMutableArray *)imageNameArray;

@property(nonatomic,copy)void (^ ClockTitle)(NSInteger index);
@end
