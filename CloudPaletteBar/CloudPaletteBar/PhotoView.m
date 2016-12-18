//
//  PhotoView.m
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/8/28.
//  Copyright © 2016年 test. All rights reserved.
//

#import "PhotoView.h"

@implementation PhotoView

-(void)_init:(NSString *)title PhImage:(UIImage *)phImage{
    self.titleLable.text=title;
    if (![phImage isKindOfClass:[NSString class]]) {
        self.phImageView.image=phImage;
    }
    
}
- (IBAction)ClockButton:(id)sender {
    if (self.Clock) {
        self.Clock(self.tag);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication].delegate window]  endEditing:YES];
}
@end
