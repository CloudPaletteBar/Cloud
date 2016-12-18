//
//  SearchView.h
//  搜索
//
//  Created by mhl on 16/8/15.
//  Copyright © 2016年 mhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHDatePicker.h"

@interface SearchView : UIView<UITextFieldDelegate, UISearchBarDelegate>

@property (strong, nonatomic) MHDatePicker *selectDatePicker;


@property (strong, nonatomic)IBOutlet UIView *classifyView;
@property (strong, nonatomic)IBOutlet UITextField *nameField;
@property (strong, nonatomic)IBOutlet UIButton *areaButton;
@property (strong, nonatomic)IBOutlet UIButton *categoryButton;
@property (strong, nonatomic)IBOutlet UIButton *startTime;
@property (strong, nonatomic)IBOutlet UIButton *endTime;

@property (strong, nonatomic)IBOutlet UIView *searchView;
@property (strong, nonatomic)IBOutlet UIButton *searchButton;
@property (strong, nonatomic)IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic)IBOutlet UIButton *imageButton;

@property (strong, nonatomic)IBOutlet UILabel *label1;
@property (strong, nonatomic)IBOutlet UILabel *label2;
@property (strong, nonatomic)IBOutlet UILabel *label3;


@property (strong, nonatomic)void (^PulldownButton)(NSString *upDown);

@property (strong, nonatomic)void (^SearchData)(NSString *nameStr, NSString *areaStr, NSString *categoryStr, NSString *startStr, NSString *endStr);


-(void)loadOtherView;


@end
