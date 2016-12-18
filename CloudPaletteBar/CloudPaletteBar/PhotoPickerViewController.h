//
//  PhotoPickerViewController.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/28.
//  Copyright © 2016年 test. All rights reserved.
//

#import "LQPhotoPickerViewController.h"

@interface PhotoPickerViewController : LQPhotoPickerViewController
@property (strong, nonatomic) UIScrollView *scrollView;
@property(nonatomic,copy)void (^ ClockPhon)(NSArray *phionImgeArray);


@property(nonatomic,copy)void (^ ClockSave)(NSArray *ArrayID,NSString *ImageUrl);
@end
