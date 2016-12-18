//
//  UploadCell.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import "UploadCell.h"
#import "CloudPaletteBar.h"

@implementation UploadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)C_Init:(BOOL)star ViewTag:(NSInteger)viewtag ImageName:(NSString *)imageName{
    if (star) {
        [self.cellactiView startAnimating];
    }else{
        self.cellactiView.hidden=YES;
        [self.cellactiView stopAnimating];
    }
    NSLog(@"%@",imageName);
    self.cellImageView.image=[UIImage imageWithContentsOfFile:imageName];
}

@end
