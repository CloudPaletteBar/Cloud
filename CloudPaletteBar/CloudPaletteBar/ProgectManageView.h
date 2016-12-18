//
//  ProgectManageView.h
//  CloudPaletteBar
//
//  Created by Apple on 15/10/25.
//  Copyright © 2015年 cloudnetwork. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ProgectManageDelegate;

@interface ProgectManageView : UIView

@property (strong, nonatomic) id delegate;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


+(instancetype)progectView;
-(instancetype)initWithProject;


-(IBAction)selectorButton:(id)sender;

@end


@protocol ProgectManageDelegate

-(void)didSelectProgectManage;

@end