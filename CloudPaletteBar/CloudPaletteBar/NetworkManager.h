//
//  NetworkManager.h
//  CloudPaletteBar
//
//  Created by mhl on 16/8/10.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "FMDB.h"
#import "SaveImageModel.h"

@interface NetworkManager : NSObject

+(NetworkManager *)shar;


/**
 根据条件进行网络请求
 
 @param method  请求方式 如GET，PUT，POST，Delete
 @param headDic http头参数
 @param bodyDic body参数
 @param url     相对路径
 @param success block对象 responseObject 请求成功时，返回的数据
 @param failure block对象 error 请求失败时的状态信息
 @return
 *******************************************/
+ (void)requestWithMethod:(NSString *)method bodyParameter:(NSDictionary *)bodyDic relativePath:(NSString *)url success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+(NSArray *)_readInit:(NSString *)plishName;
//json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//获取当前时间并转时间戳
+(NSString *)timeStr;

-(void)close;
//打开数据库并拷贝数据库到本地
-(FMDatabase *)sqliteDataBuse;
//插入数据库数据指图片的路径和任务id
-(void)saveMessage:(SaveImageModel *)saveImageModell;
//更新id本地数据库
-(void)updata:(long long int)rowID FormID:(NSString *)formID TackId:(NSString *)tackId;
//跟新本地数据库通过图片路径跟新图片的上传状态
-(void)upDataMessage:(SaveImageModel *)saveImageModell;
//从相册和拍照获取图片保存到沙盒
-(void)getImageSavePath:(NSDictionary *)info InforSaveImageModel:(SaveImageModel *)saveImageModell success:(void (^)(SaveImageModel * responseSaveImageModel))success;

//保存图片到本地
-(void)savaIamge:(UIImage *)imageSave OrderType:(NSString *)orderType ArrayIDS:(NSMutableArray *)arrayids ImageType:(NSString *)imageType NameImage:(int)nameImage success:(void (^)(NSMutableArray * arryaIDs))success;
//查询本地图片
-(void )selectDataMessage:(NSString *)imageName success:(void (^)(NSArray *arrays))success;
//下载图片
-(void)downImage:(NSString *)url success:(void (^)(UIImage * response))success;
//压缩裁剪图片
- (UIImage *)cutImage:(UIImage*)image;
//正则
+ (BOOL)isEmailAddress:(NSString*)candidate RegularStr:(NSString *)regularStr;
//时间挫转换时间字符串
+(NSString *)countTimeStr;
//字符串截取从哪里
+(NSString *)interceptStrFrom:(NSString *)intercept PleStr:(NSString *)pleStr;

+(NSString *)interceptStrFrom1:(NSString *)intercept PleStr:(NSString *)pleStr;
//字符串截取到哪里
+(NSString *)interceptStrTo:(NSString *)intercept PleStr:(NSString *)pleStr;
//时间戳转时间
+(NSString *)str:(NSString *)strg;

//字符串转字典
+(NSDictionary *)stringDictionary:(NSString *)str;
//地理位置转数组
+(NSMutableArray *)address:(NSString *)str;
//数组转字符串
+(NSString *)Datastrings:(NSArray *)dataStrings;
//字符串转字典针对图片
+(NSDictionary *)stringDictionaryImge:(NSString *)str;
//字符串替换
+(NSString *)repl:(NSString *)rel Str:(NSString *)str;

/**
 *  图片上传
 *
 *  @param requestUrl  请求的url
 *  @param requstImage 上传的图片
 *  @param RequseParameter 请求携带的参数
 *  @param success     成功返回
 *  @param failure    失败返回
 */
+(void)ImageRequestAsynchronous:(NSString *)requestUrl RequstImage:(UIImage *)requstImage Cname:(NSString *)cname RequseParameter:(NSDictionary *)requseParameter success:(void (^)(id response))success SpeedProgress:(void (^)( float Progress))speedProgress failure:(void (^)( NSError * error))failure;

//判断两个图片是否一样
+(void)equalImages:(NSArray *)images ExistenceImages:(NSArray *)existenceImages;

+(NSString *)jiequStr:(NSString *)str rep:(NSString *)rep;

+(void)_initSdImage:(NSString *)url ImageView:(UIImageView *)iageView;
@end
