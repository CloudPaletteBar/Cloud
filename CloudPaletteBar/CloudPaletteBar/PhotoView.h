//
//  PhotoView.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/28.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIButton *titleButton;
-(void)_init:(NSString *)title PhImage:(UIImage *)phImage;
@property (weak, nonatomic) IBOutlet UIImageView *phImageView;
@property(nonatomic,copy)void (^ Clock)(NSInteger ClockTag);
@end
