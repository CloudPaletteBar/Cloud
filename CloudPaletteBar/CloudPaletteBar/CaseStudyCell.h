//
//  CaseStudyCell.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseStudyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellLable;
@property (weak, nonatomic) IBOutlet UILabel *cellNumber;
-(void)_initCell:(NSString *)title Index:(NSInteger)index;
@end
