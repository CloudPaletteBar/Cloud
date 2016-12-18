//
//  SelectFormPickerView.h
//  CloudPaletteBar
//
//  Created by test on 16/8/17.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectFormPickerView : UIView
@property (weak, nonatomic) IBOutlet UIPickerView *selectPickView;
@property(nonatomic,strong)NSArray *trafficArray;
-(void)_init:(NSArray *)array;

@property(nonatomic,copy)void (^ Clock)(NSString *str);
@end
