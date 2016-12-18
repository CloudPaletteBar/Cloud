//
//  ProgectManageView2.m
//  CloudPaletteBar
//
//  Created by Apple on 15/10/26.
//  Copyright © 2015年 cloudnetwork. All rights reserved.
//

#import "ProgectManageView2.h"

@implementation ProgectManageView2

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)progectView2
{
    return [[ProgectManageView2 alloc] initWithProject2];
}

-(instancetype)initWithProject2{
    
    if (self = [super init]) {
        
        NSBundle *rootBundle = [NSBundle mainBundle];
        self = [[rootBundle loadNibNamed:@"ProgectManageView2" owner:nil options:nil] lastObject];
        
        [self layerView:_nameTextField];
        [self layerView:_projectTypeBut];
        [self layerView:_startTimeBut];
        [self layerView:_overTimeBut];
        [self layerView:_queryBut];
        _cleckButon.transform=CGAffineTransformMakeRotation(M_PI/1);
    }
    
    return self;
}

-(void)layerView:(UIView *)view
{
    [view.layer setCornerRadius:4.0];
}

-(void)selectorButton2:(UIButton *)sender
{
    switch (sender.tag) {
        case 1000:
        {
            
        }
            break;
            
        case 1001:
        {
            
        }
            break;
            
        case 1002:
        {
            
        }
            break;
            
        case 1003:
        {
            
        }
            break;
            
        case 1004:
        {
            if ([_delegate respondsToSelector:@selector(didSelectProgectManage2)]) {
                [_delegate didSelectProgectManage2];
            }
        }
            break;
            
        default:
            break;
    }
}


@end
