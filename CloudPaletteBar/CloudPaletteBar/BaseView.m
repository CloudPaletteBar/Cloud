//
//  BaseView.m
//  HYJDriver
//
//  Created by test on 16/2/22.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BaseView.h"
#import "Toast+UIView.h"
#import "MBProgressHUD.h"
#import "KLCPopup.h"

@interface BaseView ()
{
    MBProgressHUD *hud;
    KLCPopup *popup;
}

@end

static BaseView *baseView;
@implementation BaseView

+(BaseView *)baseShar{
    if (baseView==nil) {
        baseView=[[BaseView alloc]init];
        
    }
    return baseView;
}


+(void)_init:(NSString *)title View:(UIView *)view{
    [view makeToast:title duration:2 position:@"center"];
}
- (void)_initMBProgressHUD:(UIView *)view Title:(NSString *)title{
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.labelText = title;
   

}


-(void)_initMBProgressOneHUD:(UIView *)view Title:(NSString *)title{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.labelText = title;
    });
}

-(void)dissMiss{
    [hud hide:YES];
}

/**
 *  验证手机号码
 *
 *  @param verificationNumber 传进来电话号码字符串
 *
 *  @return 返回yes  No
 */
//正则匹配是不是手机号
+(BOOL)verifyPhoneNumber:(NSString *)verificationNumber{
    NSString *regex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[0-9]|18[0-9]|14[57])[0-9]{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:verificationNumber];
    
    if (!isMatch) {
        
        return NO;
        
    }
    return YES;
}
/**
 *  动画弹窗动画类
 *
 *  @param popView 动画的view
 *  @param type    动画类型（1，2，3，。。。。）KLCPopupShowTypeNone = 0,
	KLCPopupShowTypeFadeIn,
 KLCPopupShowTypeGrowIn,
 KLCPopupShowTypeShrinkIn,
 KLCPopupShowTypeSlideInFromTop,
 KLCPopupShowTypeSlideInFromBottom,
 KLCPopupShowTypeSlideInFromLeft,
 KLCPopupShowTypeSlideInFromRight,
 KLCPopupShowTypeBounceIn,
 KLCPopupShowTypeBounceInFromTop,
 KLCPopupShowTypeBounceInFromBottom,
 KLCPopupShowTypeBounceInFromLeft,
 KLCPopupShowTypeBounceInFromRight,
 */
-(void)_initPop:(UIView *)popView Type:(NSInteger)type{
    
    
    popup = [KLCPopup popupWithContentView:popView
                                            showType:type
                                         dismissType:KLCPopupDismissTypeNone
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    
   
        [popup show];

}

/**
 *  动画消失类
 *
 *  @param animated 是否动画消失yes   no
 */
-(void)dissMissPop:(BOOL)animated{
    [popup dismiss:animated];
}

+(void)animation:(UIView *)animationView ViewY:(CGFloat)viewY {
    [UIView animateWithDuration:0.2 animations:^{
        animationView.frame=CGRectMake(0, viewY, animationView.frame.size.width, animationView.frame.size.height);
    } completion:^(BOOL finished) {
        
        
    }];
}


//M_PI
+(void)animationTransform:(UIView *)animationView ViewAngle:(CGFloat)viewangle {
    [UIView animateWithDuration:0.2 animations:^{
        animationView.transform = CGAffineTransformMakeRotation(viewangle);
    } completion:^(BOOL finished) {
        
        
    }];
}





@end
