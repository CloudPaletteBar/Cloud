//
//  HouseSelectView.m
//  CloudPaletteBar
//
//  Created by test on 16/8/22.
//  Copyright © 2016年 test. All rights reserved.
//

#import "HouseSelectView.h"
#import "CloudPaletteBar.h"

@implementation HouseSelectView

-(id)initWithCoder:(NSCoder *)aDecoder {
    self =[super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}


-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier DataArray:(NSArray *)dataArray{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        self.frame=CGRectMake(0, 0, screen_width, 44);
        self.titleLable=[[UILabel alloc]init];
        [self.contentView addSubview:self.titleLable];
        self.titleLable.font=[UIFont systemFontOfSize:15];
//        self.seameted=[[UISegmentedControl alloc]initWithItems:dataArray];
//        self.seameted.selectedSegmentIndex=0;
//        [self addSubview:self.seameted];
        self.cellLable=[[UILabel alloc]init];
        
        self.cellLable.textAlignment=NSTextAlignmentCenter;
        self.cellLable.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.cellLable];
        self.dVSwitch = [DVSwitch switchWithStringsArray:dataArray];
        self.dVSwitch.font = [UIFont systemFontOfSize:14];
        self.dVSwitch.sliderColor = TASK;
        self.dVSwitch.backgroundColor=[UIColor whiteColor];
        self.dVSwitch.layer.borderWidth=1.0;
        self.dVSwitch.layer.borderColor=[TASK CGColor];
        [self.contentView addSubview:self.dVSwitch];
        __weak typeof(self)weakSelf=self;
        [self.dVSwitch setWillBePressedHandler:^(NSUInteger index) {
            if (weakSelf.ClockSelect) {
                weakSelf.ClockSelect(index,weakSelf.tag);
            }
        }];

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

- (CGSize)stringSizeWithFont:(UIFont *)font Title:(NSString *)str{
    CGSize stringSize = [str boundingRectWithSize:CGSizeMake( MAXFLOAT,44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
    
    return stringSize;
}

-(void)_init:(NSArray *)titles Title:(NSString *)title SelectIndex:(NSInteger)selectIndex{
    CGSize stringSize=[self stringSizeWithFont:[UIFont systemFontOfSize:15] Title:title];
        self.titleLable.frame = CGRectMake(8, 0, stringSize.width, 44);
    self.titleLable.text=title;
}
-(void)_init:(NSString *)title SelectIndex:(NSInteger)selectIndex{
    CGSize stringSize1=[self stringSizeWithFont:[UIFont systemFontOfSize:15] Title:self.cellLable.text];
    self.cellLable.frame=CGRectMake(0, 0, screen_width, stringSize1.height);
    CGSize stringSize=[self stringSizeWithFont:[UIFont systemFontOfSize:15] Title:title];
    self.titleLable.frame = CGRectMake(8, stringSize1.height-2, stringSize.width, 44);
    self.dVSwitch.frame=CGRectMake(stringSize.width+11, stringSize1.height+3, screen_width-stringSize.width-19, 35);
    
    self.dVSwitch.selectedIndex=selectIndex;
    self.titleLable.text=title;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}
@end
