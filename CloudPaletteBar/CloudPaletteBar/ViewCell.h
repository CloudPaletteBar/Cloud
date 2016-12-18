//
//  ViewCell.h
//  demo
//
//  Created by liu_yakai on 16/10/11.
//  Copyright © 2016年 liu_yakai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellimage;
@property (weak, nonatomic) IBOutlet UIButton *deleButton;
@property(nonatomic,copy)void (^ Clock)(NSInteger index);

@end
