//
//  HomeCell.h
//  CloudPaletteBar
//
//  Created by test on 16/8/11.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginModel.h"

@interface HomeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberLable;

@property (weak, nonatomic) IBOutlet UILabel *cellLable;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
-(void)_initCell:(NSString *)title ImageName:(NSString *)imageName Number:(NSString *)numbre;
@end
