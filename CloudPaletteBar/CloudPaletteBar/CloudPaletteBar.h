//
//  CloudPaletteBar.h
//  CloudPaletteBar
//
//  Created by test on 16/8/11.
//  Copyright © 2016年 test. All rights reserved.
//

#ifndef CloudPaletteBar_h
#define CloudPaletteBar_h

//获取屏幕的宽度和高度
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
//rgba值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//imageView set图片名字
#define OdeSetImageName(OdeimageName) [UIImage imageNamed:OdeimageName]
#define KeyApp [[UIApplication sharedApplication]delegate]

//主机地址
#define SERVER_URL @"http://202.104.132.71:8088/"
//#define SERVER_URL @"http://211.149.165.110:9000/"

#define TASK RGBA(22,167,248,1)

#define LOGIN @"登录中..."
#define LOGINError @"登录失败"
#define USERNAME @"请输入用户名"
#define PSWORD @"请输入密码"
#define CODEV @"请输入验证码"
#define NRTERROR @"网络异常"
#define NONETTITLE  @"亲网络异常请稍后"
#define NOJSONTITLE @"亲你的网络不给力啊"

#endif /* CloudPaletteBar_h */
