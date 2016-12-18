//
//  BusinessTableViewCell.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/17.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BusinessTableViewCell.h"
#import "MacroDefinition.h"

const int int40 = 40;
const int int44= 44;
const int int120 = 120;
const int int160 = 160;
const int int200 = 200;
const int int240 = 240;
const int int280 = 280;
const int int320 = 320;


@implementation BusinessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)disappearIndex:(int)index andArray:(NSArray *)array{
    switch (index) {
        case 0:{
            _industrialParkView.hidden = YES;
            _buildingView.hidden = YES;
            _buildingView2.hidden = YES;
            _floorsView.hidden = YES;
            _buildingView3.hidden = YES;
            _businessView.frame = CGRectMake((MainScreenWidth-int120)/2, 0, int120, int44);
        }
            break;
        case 1:{
            _industrialParkView.hidden = YES;
            _buildingView.hidden = YES;
            _buildingView2.hidden = YES;
            _floorsView.hidden = YES;
            
            _buildingLabel3.text = [array objectAtIndex:0];
            _buildingView3.frame = CGRectMake(int120, 0, int40, int44);
            _businessView.frame = CGRectMake((MainScreenWidth-int160)/2, 0,int160, int44);
        }
            break;
        case 2:{
            _industrialParkView.hidden = YES;
            _buildingView.hidden = YES;
            _buildingView2.hidden = YES;
            
            _floorsView.frame = CGRectMake(int120, 0, int40, int44);
            _floorLabel.text = [array objectAtIndex:1];
            _buildingLabel3.text = [array objectAtIndex:0];
            _buildingView3.frame = CGRectMake(int160, 0, int40, int44);
            _businessView.frame = CGRectMake((MainScreenWidth-int200)/2, 0, int200, int44);
        }
            break;
        case 3:{
            _industrialParkView.hidden = YES;
            _buildingView.hidden = YES;
            
            _floorLabel.text = [array objectAtIndex:1];
            _buildingLabel3.text = [array objectAtIndex:0];
            _buildingLabel2.text = [array objectAtIndex:2];
            _buildingView2.frame = CGRectMake(int120, 0, int40, int44);
            _floorsView.frame = CGRectMake(int160, 0, int40, int44);
            _buildingView3.frame = CGRectMake(int200, 0, int40, int44);
            _businessView.frame = CGRectMake((MainScreenWidth-int240)/2, 0, int240, int44);
        }
            break;
        case 4:{
            _industrialParkView.hidden = YES;
            
            _floorLabel.text = [array objectAtIndex:1];
            _buildingLabel3.text = [array objectAtIndex:0];
            _buildingLabel2.text = [array objectAtIndex:2];
            _buildingLabel.text = [array objectAtIndex:3];
            _buildingView.frame = CGRectMake(int120, 0, int40,int44);
            _buildingView2.frame = CGRectMake(int160, 0, int40, int44);
            _floorsView.frame = CGRectMake(int200, 0, int40, int44);
            _buildingView3.frame = CGRectMake(int240, 0, int40, int44);
            _businessView.frame = CGRectMake((MainScreenWidth-int280)/2, 0, int280, int44);
        }
            break;
        case 5:{
            _floorLabel.text = [array objectAtIndex:1];
            _buildingLabel3.text = [array objectAtIndex:0];
            _buildingLabel2.text = [array objectAtIndex:2];
            _buildingLabel.text = [array objectAtIndex:3];
            _industrialLabel.text = [array objectAtIndex:4];
            _industrialParkView.frame = CGRectMake(int120, 0, int40, int44);
            _buildingView.frame = CGRectMake(int160, 0, int40, int44);
            _buildingView2.frame = CGRectMake(int200, 0, int40, int44);
            _floorsView.frame = CGRectMake(int240, 0, int40, int44);
            _buildingView3.frame = CGRectMake(int280, 0, int40, int44);
            _businessView.frame = CGRectMake((MainScreenWidth-int320)/2, 0, int320, int44);
        }
            break;
            
        default:
            break;
    }
}

-(IBAction)clickButton:(UIButton *)sender{
    
    if ([_delegate respondsToSelector:@selector(didSelectLocation:andSelectButton:)]) {
        [_delegate didSelectLocation:self andSelectButton:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
