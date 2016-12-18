//
//  SearchView3.h
//  CloudPaletteBar
//
//  Created by 李卫振 on 16/9/4.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHDatePicker.h"

@interface SearchView3 : UIView<UISearchBarDelegate>

@property (strong, nonatomic) MHDatePicker *selectDatePicker;


@property (strong, nonatomic)IBOutlet UIView *classifyView;
@property (strong, nonatomic)IBOutlet UIButton *categoryButton;
@property (strong, nonatomic)IBOutlet UIButton *startTime;

@property (strong, nonatomic)IBOutlet UIView *searchView;
@property (strong, nonatomic)IBOutlet UIButton *searchButton;
@property (strong, nonatomic)IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic)IBOutlet UIButton *imageButton;

@property (strong, nonatomic)IBOutlet UILabel *label1;
@property (strong, nonatomic)IBOutlet UILabel *label2;
@property (strong, nonatomic)IBOutlet UILabel *label3;

@property (strong, nonatomic)void (^PulldownButton)(NSString *upDown);
@property (strong, nonatomic)void (^SearchData)(NSString *categoryStr, NSString *startStr);

-(void)loadOtherView;


@end
