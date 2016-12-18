//
//  MacroDefinition.h
//  CloudPaletteBar
//
//  Created by mhl on 16/8/10.
//  Copyright © 2016年 test. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h


#define MainScreenBounds [UIScreen mainScreen].bounds
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
#define MainScreenheight [UIScreen mainScreen].bounds.size.height

#define kUserDefaults [NSUserDefaults standardUserDefaults]

#define userNameDefaults [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];


#define ALERT(title,msg,buttonTitle){UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:buttonTitle otherButtonTitles:nil];[alert show];}


#define SetImageName(imageName) [UIImage imageNamed:imageName];


//打印
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#endif


// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有R,G,B,A的颜色设置
#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]


#endif /* MacroDefinition_h */
