//
//  SegmentMenuVc.h
//  CloudPaletteBar
//
//  Created by test on 16/8/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentMenuVc : UIView


@property(nonatomic,assign)NSInteger selectIndex;
/** 导入数据 */
- (void)addSubVc:(NSArray *)vc subTitles:(NSArray *)titles;
@end
