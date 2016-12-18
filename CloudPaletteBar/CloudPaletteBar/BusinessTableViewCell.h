//
//  BusinessTableViewCell.h
//  CloudPaletteBar
//
//  Created by mhl on 16/8/17.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  BusinessDelegate;


@interface BusinessTableViewCell : UITableViewCell


@property (strong, nonatomic)IBOutlet UIView *businessView;



@property (weak, nonatomic) IBOutlet UIView *industrialParkView;
@property (strong, nonatomic)IBOutlet UIButton *industrialParkButton;
@property (strong, nonatomic)IBOutlet UILabel *industrialLabel;

@property (strong, nonatomic)IBOutlet UILabel *buildingLabel;
@property (strong, nonatomic)IBOutlet UIButton *buildingButton;
@property (weak, nonatomic) IBOutlet UIView *buildingView;

@property (strong, nonatomic)IBOutlet UILabel *buildingLabel2;
@property (strong, nonatomic)IBOutlet UIButton *buildingButton2;
@property (weak, nonatomic) IBOutlet UIView *buildingView2;

@property (strong, nonatomic)IBOutlet UILabel *floorLabel;
@property (strong, nonatomic)IBOutlet UIButton *floorButton;
@property (weak, nonatomic) IBOutlet UIView *floorsView;

@property (strong, nonatomic)IBOutlet UILabel *buildingLabel3;
@property (strong, nonatomic)IBOutlet UIButton *buildingButton3;
@property (weak, nonatomic) IBOutlet UIView *buildingView3;


@property (strong, nonatomic)id delegate;

//@property (strong, nonatomic)void (^selectButton)(NSInteger tag);


-(void)disappearIndex:(int)index andArray:(NSArray *)array;


@end


@protocol BusinessDelegate <NSObject>

-(void)didSelectLocation:(BusinessTableViewCell *)aTableCell andSelectButton:(UIButton *)sender;


@end
