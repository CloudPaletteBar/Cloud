//
//  POHViewController.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/10/11.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POHViewController : UIViewController

@property(nonatomic,strong)NSMutableArray *PHOarray;
@property(nonatomic,strong)NSString *orderType;
@property(nonatomic,strong)NSString *imageType;
@property(nonatomic,strong)NSString * stakID;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,assign)NSInteger successfulIndex;

@property(nonatomic,copy)void (^ ClockSave)(NSArray *ArrayID,NSString *ImageUrl);
@property(assign)NSInteger selectMax;
@end
