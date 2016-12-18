//
//  ProgectManageView.m
//  CloudPaletteBar
//
//  Created by Apple on 15/10/25.
//  Copyright © 2015年 cloudnetwork. All rights reserved.
//

#import "ProgectManageView.h"

@implementation ProgectManageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)progectView
{
    return [[ProgectManageView alloc] initWithProject];
}

-(instancetype)initWithProject{
    
    if (self = [super init]) {
        
        NSBundle *rootBundle = [NSBundle mainBundle];
        self = [[rootBundle loadNibNamed:@"ProgectManageView" owner:nil options:nil] lastObject];
        
        self.searchBar.barTintColor = [UIColor colorWithRed:218.0f/255.0 green:219.0f/255.0 blue:221.0f/255.0 alpha:0.9];
    }
    
    return self;
}

-(void)selectorButton:(id)sender
{
    if ([_delegate respondsToSelector:@selector(didSelectProgectManage)]) {
        [_delegate didSelectProgectManage];
    }
}


@end
