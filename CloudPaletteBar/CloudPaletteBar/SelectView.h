//
//  SelectView.h
//  DriverSide
//
//  Created by test on 16/7/22.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarNumberModel.h"
#import "SelectHeatView.h"

@interface SelectView : UIView<UITableViewDelegate,UITableViewDataSource>{
    @public
    BOOL Open;
}
@property(nonatomic,strong)SelectHeatView *baseCommonSeachHeatView;
@property(nonatomic,strong)NSArray * dataArray;
@property(assign)CGFloat ViewHeightY;
@property(nonatomic,strong)NSString *buttonTitle;
-(void)_init;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UITableView *selectTableView;
@property(nonatomic,copy)void (^ ClockSelect)(CarNumberResultRelateVehicleListModel *VehicleListModel);
@end
