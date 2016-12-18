//
//  BaseView.h
//  HYJDriver
//
//  Created by test on 16/2/22.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView
//提示窗体
+(void)_init:(NSString *)title View:(UIView *)view;
//网络请求窗体
- (void)_initMBProgressHUD:(UIView *)view Title:(NSString *)title;
//消失网络请求
-(void)dissMiss;

+(BaseView *)baseShar;

/**
 *  验证手机号码
 *
 *  @param verificationNumber 传进来电话号码字符串
 *
 *  @return 返回yes  No
 */
+(BOOL)verifyPhoneNumber:(NSString *)verificationNumber;

/**
 *  动画消失类
 *
 *  @param animated 是否动画消失yes   no
 */
-(void)dissMissPop:(BOOL)animated;

/**
 *  动画弹窗动画类
 *
 *  @param popView 动画的view
 *  @param type    动画类型（1，2，3，。。。。）
 */
-(void)_initPop:(UIView *)popView Type:(NSInteger)type;

/**
 *  动画
 *
 *  @param animationView 动画view
 *  @param viewY         动画的Y轴坐标
 */
+(void)animation:(UIView *)animationView ViewY:(CGFloat)viewY;

/**
 *  view旋转
 *
 *  @param animationView 旋转的view
 *  @param viewangle     旋转角度
 */
+(void)animationTransform:(UIView *)animationView ViewAngle:(CGFloat)viewangle;

-(void)_initMBProgressOneHUD:(UIView *)view Title:(NSString *)title;
@end
