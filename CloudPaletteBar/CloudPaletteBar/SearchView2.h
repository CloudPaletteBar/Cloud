//
//  SearchView2.h
//  CloudPaletteBar
//
//  Created by mhl on 16/8/17.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHDatePicker.h"

@interface SearchView2 : UIView<UITextFieldDelegate, UISearchBarDelegate>

@property (strong, nonatomic) MHDatePicker *selectDatePicker;

//有新增按钮的view
@property (strong, nonatomic)IBOutlet UIView *classifyView2;
@property (strong, nonatomic)IBOutlet UITextField *textField1;
@property (strong, nonatomic)IBOutlet UIButton *textButton;
@property (strong, nonatomic)IBOutlet UITextField *textField2;



@property (strong, nonatomic)IBOutlet UIView *searchView2;
@property (strong, nonatomic)IBOutlet UIButton *searchButton2;
@property (strong, nonatomic)IBOutlet UISearchBar *searchBar2;
@property (strong, nonatomic)IBOutlet UIButton *imageButton;
@property (strong, nonatomic)IBOutlet UIButton *imageButton2;

@property (strong, nonatomic)IBOutlet UIButton *addedButton;

@property (strong, nonatomic)IBOutlet UILabel *label1;
@property (strong, nonatomic)IBOutlet UILabel *label2;
@property (strong, nonatomic)IBOutlet UILabel *label3;



@property (strong, nonatomic)void (^PulldownButton)(NSString *upDown);
@property (strong, nonatomic)void (^addedPush)();

@property (strong, nonatomic)void (^SearchData)(NSString *nameStr, NSString *areaStr);


-(void)loadOtherView;



@end
