//
//  UploadCell.h
//  CloudPaletteBar
//
//  Created by liu_yakai on 16/9/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cellactiView;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
-(void)C_Init:(BOOL)star ViewTag:(NSInteger)viewtag ImageName:(NSString *)imageName;
@end
