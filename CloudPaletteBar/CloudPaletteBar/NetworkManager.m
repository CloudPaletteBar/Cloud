//
//  NetworkManager.m
//  CloudPaletteBar
//
//  Created by mhl on 16/8/10.
//  Copyright © 2016年 test. All rights reserved.
//

#import "NetworkManager.h"
#import "CloudPaletteBar.h"
#import "UIImageView+WebCache.h"


@interface NetworkManager() {
    FMDatabase *database;
}
@end

@implementation NetworkManager
static NetworkManager *networkManager;
+(NetworkManager *)shar{
    if (networkManager==nil) {
        networkManager=[[NetworkManager alloc]init];
    }
    return networkManager;
}
//时间戳转时间字符串
+(NSString *)countTimeStr{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NetworkManager timeStr] doubleValue]];
    return  [formatter stringFromDate:date];
}
//获取当前时间并转时间戳
+(NSString *)timeStr{
    return  [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
}
//时间戳转时间
+(NSString *)str:(NSString *)strg{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[strg intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
    
}

+ (void)requestWithMethod:(NSString *)method bodyParameter:(NSDictionary *)bodyDic relativePath:(NSString *)url success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *dic;
    //    if (bodyDic) {
    dic=[[NSMutableDictionary alloc]initWithDictionary:bodyDic];
    //    }
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"homes"]!=NULL) {
        
        [[NSUserDefaults standardUserDefaults]objectForKey:@"homes"];
        [dic setObject:[[[NSUserDefaults standardUserDefaults]objectForKey:@"homes"]valueForKey:@"token"] forKey:@"token"];
    }
    
    //    拼接url
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,url]];
    //    url进行编码
    NSString * encodingString = [URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    是否支持xml webserver
    //    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    //    获取cooke
    //    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionCookies"];
    //
    //    if(cookiesdata) {
    //        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
    //        NSHTTPCookie *cookie;
    //        for (cookie in cookies) {
    //            if ([cookie.name isEqualToString:@"token"]) {
    //                 NSLog(@"%@",cookie);
    //                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    //            }
    //
    //
    //        }
    //    }
    NSLog(@"%@",dic);
    // 设置请求超时时间
    manager.requestSerializer.timeoutInterval = 60;
    [manager POST:encodingString parameters:dic/*[NetworkManager dictionaryToJson:bodyDic]*/ progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@",result);
        id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([[jsonObject objectForKey:@"message"]isEqualToString:@"对不起,您的登陆已经失效！"]) {
            //创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"loginVCCC" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
        }
        success(jsonObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        failure(error);
    }];
}

//字典转json
+(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
//json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingAllowFragments
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//读取plish文件内容
+(NSMutableArray *)_readInit:(NSString *)plishName{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",plishName] ofType:@"plist"];
    return [[NSMutableArray alloc] initWithContentsOfFile:plistPath];//直接打印数据。
}

//创建数据库
-(FMDatabase *)sqliteDataBuse
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"mydatabase.sqlite"];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"mydatabase" ofType:@"sqlite"];
    
    NSLog(@"%@",dbPath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:dbPath])
    {
        NSError *error;
        if(![fileManager copyItemAtPath:imagePath toPath:dbPath error:&error])
        {
            NSLog(@"%@", [error localizedDescription]);
        }
        NSLog(@"复制sqlite到路径：%@成功。",imagePath);
    }
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    //     });
    return database;
    
}

-(void)close{
    if (database)
    {
        [database close];
        database = nil;
    }
}


//从相册和拍照获取图片保存到沙盒
-(void)getImageSavePath:(NSDictionary *)info InforSaveImageModel:(SaveImageModel *)saveImageModell success:(void (^)(SaveImageModel * responseSaveImageModel))success{
    //获取存放的照片
    //获取Documents文件夹目录
    __weak typeof(self)SelfWeak=self;
    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        //指定新建文件夹路径
        //        NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"PhotoFile"];
        //        [[NSFileManager defaultManager] createDirectoryAtPath:imageDocPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSString * filePath=[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%.f.png", [[NSDate date]timeIntervalSince1970]]];
        NSLog(@"%@",filePath);
        [UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage])writeToFile: filePath    atomically:YES];
        
        saveImageModell.imagePath=filePath;
        saveImageModell.imageType=@"0";
        success(saveImageModell);
        [SelfWeak saveMessage:saveImageModell];
    });
    
}

-(void)savaIamge:(UIImage *)imageSave OrderType:(NSString *)orderType ArrayIDS:(NSMutableArray *)arrayids ImageType:(NSString *)imageType NameImage:(int)nameImage success:(void (^)(NSMutableArray * arryaIDs))success{
    //获取存放的照片
    //获取Documents文件夹目录
    __weak typeof(self)SelfWeak=self;
    //    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_async(queue, ^{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //指定新建文件夹路径
    //        NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"PhotoFile"];
    //        [[NSFileManager defaultManager] createDirectoryAtPath:imageDocPath withIntermediateDirectories:YES attributes:nil error:nil];
    SaveImageModel *saveImageModel=[[SaveImageModel alloc]init];
    NSLog(@"%d",nameImage);
    int num = (arc4random() % 10000000);
    NSString *timeDate = [NSString stringWithFormat:@"%.6d", num];
    NSLog(@"%@&&&&&&&", timeDate);
    NSString * filePath=[NSString stringWithFormat:@"%@/%@%@.png", documentPath,imageType,timeDate];
    NSLog(@"%@!!!!!!",filePath);
    [UIImagePNGRepresentation(imageSave) writeToFile:filePath atomically:YES];
    saveImageModel.imagePath=filePath;
    saveImageModel.imageName=[NSString stringWithFormat:@"%@%@.png", imageType,timeDate];
    saveImageModel.imageType=imageType;
    saveImageModel.imageState=@"0";
    saveImageModel.orderType=orderType;
    [SelfWeak saveMessage:saveImageModel ArrayIDS:arrayids success:^(NSMutableArray * IDs) {
        success(IDs);
    }];
    
    //        [UIImagePNGRepresentation(imageSave)writeToFile: filePath    atomically:YES];
    //    });
    
}

//将图片路径任务id和图片的上传状态保存到本地数据库
-(void)saveMessage:(SaveImageModel *)saveImageModell ArrayIDS:(NSMutableArray *)arrayids success:(void (^)(NSMutableArray * IDs))success{
    FMDatabase * db;
    if (!db) {
        db=[self sqliteDataBuse];
    }
    //    NSLog(@"%@",[NSString stringWithFormat:@"insert into upImage  (ImagePath,tackId,ImageType,imageState,imageName,orderType,ID) values('%@','%@','%@','%@','%@','%@','%@')",saveImageModell.imagePath,saveImageModell.tackId,saveImageModell.imageType,saveImageModell.imageState,saveImageModell.imageName,saveImageModell.orderType,saveImageModell.ID]);
    BOOL res=[db executeUpdate:[NSString stringWithFormat:@"insert into upImage  (ImagePath,tackId,ImageType,imageState,imageName,orderType,ID) values('%@','%@','%@','%@','%@','%@','%@')",saveImageModell.imagePath,saveImageModell.tackId,saveImageModell.imageType,saveImageModell.imageState,saveImageModell.imageName,saveImageModell.orderType,saveImageModell.ID]];
    
    if (res) {
        
        long long int i=db.lastInsertRowId;
        [arrayids addObject:[NSNumber numberWithUnsignedLongLong:i]];
        NSLog(@"%lld",i);
        NSLog(@"插入成功");
        success(arrayids);
    }
    //    [self close];
}
//跟新本地数据库通过图片路径跟新图片的上传状态
-(void)upDataMessage:(SaveImageModel *)saveImageModell {
    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        FMDatabase *db;
        if (!db) {
            db=[self sqliteDataBuse];
        }
        BOOL res=[db executeUpdate:[NSString stringWithFormat:@"update upImage set (ImageType='%@') where ImagePath='%@'",saveImageModell.imageType,saveImageModell.imagePath]];
        if (res) {
            NSLog(@"插入成功");
        }
        //        [self close];
    });
}
//查询本地图片
-(void )selectDataMessage:(NSString *)imageName success:(void (^)(NSArray *arrays))success{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    //    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_async(queue, ^{
    FMDatabase *db;
    if (!db) {
        db=[self sqliteDataBuse];
    }
    FMResultSet *s=[db executeQuery:[NSString stringWithFormat:@"select * from upImage where rowid in(%@)",imageName]];
    NSLog(@"%@",imageName);
    NSLog(@"%@",[NSString stringWithFormat:@"select * from upImage where rowid in(%@)",imageName]);
    //        ImagePath,userId,ImageType,imageState,imageName
    while ([s next]) {
        SaveImageModel *saveImageModel=[[SaveImageModel alloc]init];
        saveImageModel.imagePath=[s stringForColumn:@"ImagePath"];
        saveImageModel.tackId=[s stringForColumn:@"tackId"];
        saveImageModel.imageType=[s stringForColumn:@"ImageType"];
        saveImageModel.imageState=[s stringForColumn:@"imageState"];
        saveImageModel.imageName=[s stringForColumn:@"imageName"];
        saveImageModel.orderType=[s stringForColumn:@"orderType"];
        saveImageModel.ID=[s stringForColumn:@"ID"];
        [array addObject:saveImageModel];
    }
    //        [self close];
    success(array);
    //    });
    
}


-(void)updata:(long long int)rowID FormID:(NSString *)formID TackId:(NSString *)tackId{
    //    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_async(queue, ^{
    FMDatabase *db;
    if (!db) {
        db=[self sqliteDataBuse];
    }
    BOOL update=[db executeUpdate:[NSString stringWithFormat:@"update upImage set ID='%@',tackId='%@' where rowid='%lld' ",formID,tackId,rowID]];
    NSLog(@"%@",[NSString stringWithFormat:@"update upImage set ID='%@',tackId='%@' where rowid='%lld' ",formID,tackId,rowID]);
    if (!update) {
        NSLog(@"更新失败");
    } else {
        NSLog(@"更新成功");
    }
    //        [self close];
    //    });
    
    
}


//-(void)selectMessage:(SaveImageModel *)saveImageModell{
//    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        BOOL res=[[self sqliteDataBuse] executeUpdate:[NSString stringWithFormat:@"select * from upImage where ImageType= '%@'",saveImageModell.imageType]];
//        if (res) {
//            NSLog(@"插入成功");
//        }
//        [self close];
//    });
//}

-(void)downImage:(NSString *)url success:(void (^)(UIImage * response))success{
    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage *image=[UIImage imageWithData:data];
        if (image) {
            success(image);
        }
        
    });
}

//图片压缩裁剪
- (UIImage *)cutImage:(UIImage*)image
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    newSize.height = image.size.width;
    //    newSize.width = image.size.height ;
    newSize.width = image.size.width ;
    imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
    return [UIImage imageWithCGImage:imageRef];
}

+ (BOOL)isEmailAddress:(NSString*)candidate RegularStr:(NSString *)regularStr
{
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularStr];
    return [emailTest evaluateWithObject:candidate];
}

//字符串截取到哪里
+(NSString *)interceptStrTo:(NSString *)intercept PleStr:(NSString *)pleStr{
    NSRange range = [intercept rangeOfString:pleStr];
    if (range.location<intercept.length) {
        return [intercept substringToIndex:range.location];
    }
    return intercept;
}
//字符串截取从哪里
+(NSString *)interceptStrFrom:(NSString *)intercept PleStr:(NSString *)pleStr{
    NSRange range = [intercept rangeOfString:@"+"];
    return [intercept substringFromIndex:range.location+1];
}
//字符串截取从哪里
+(NSString *)interceptStrFrom1:(NSString *)intercept PleStr:(NSString *)pleStr{
    NSRange range = [intercept rangeOfString:pleStr];
    return [intercept substringFromIndex:range.location];
}
/**
 *  图片上传
 *
 *  @param requestUrl  请求的url
 *  @param requstImage 上传的图片
 *  @param RequseParameter 请求携带的参数
 *  @param success     成功返回
 *  @param failure    失败返回
 */
+(void)ImageRequestAsynchronous:(NSString *)requestUrl RequstImage:(UIImage *)requstImage Cname:(NSString *)cname RequseParameter:(NSDictionary *)requseParameter success:(void (^)(id response))success SpeedProgress:(void (^)( float Progress))speedProgress failure:(void (^)( NSError * error))failure{
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,requestUrl]];
    NSString * encodingString = [URL.absoluteString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",encodingString);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"multipart/form-data",nil];
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSString *boundary = @"wfWiEWrgEFA9A78512weF7106A";
    NSString *str=[NSString stringWithFormat:@"boundary=%@",boundary];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"multipart/form-data; %@; charset=utf-8",str] forHTTPHeaderField:@"Content-Type"];     // 设置请求超时时间
    manager.requestSerializer.timeoutInterval = 60;
    [manager POST:encodingString parameters:requseParameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件参数
        NSData *data=UIImageJPEGRepresentation(requstImage, 0.3);
        //这个就是参数
        if (data) {
            NSLog(@"$$$$$%@$$$$$",requstImage);
            [formData appendPartWithFileData:data name:cname fileName:@"123.png" mimeType:@"image/png"];
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        speedProgress(1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"####%@",jsonObject);
        success(jsonObject);
        //请求成功
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        NSLog(@"请求失败：%@",error.userInfo);
    }];
}

//判断两个图片是否一样
+(void)equalImages:(NSArray *)images ExistenceImages:(NSArray *)existenceImages{
    
    NSMutableSet *set1=[NSMutableSet setWithArray:images];
    NSMutableSet *set2=[NSMutableSet setWithArray:existenceImages];
    [set1 minusSet:set2];
    NSLog(@"minus :%@", set1);
}

//字符串转字典
+(NSDictionary *)stringDictionary:(NSString *)str{
    NSArray *strArray = [str componentsSeparatedByString:@","];
    NSMutableArray *keys=[[NSMutableArray alloc]init];
    for (NSString *stre in strArray) {
        [keys addObject:stre];
    }
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:strArray forKeys:keys];
    return dic;
    
    
}
//地理位置转数组
+(NSMutableArray *)address:(NSString *)str{
    if (str.length>1) {
        NSString *temp2 = [str substringFromIndex:[str length]-1];
        if ([temp2 isEqualToString:@","]) {
            str = [str substringToIndex:[str length]-1];
        }
        NSArray *strArray = [str componentsSeparatedByString:@","];
        return [[NSMutableArray alloc]initWithArray:strArray];
    }
    return nil;
    
}
//数组转字符串
+(NSString *)Datastrings:(NSArray *)dataStrings{
    return [dataStrings componentsJoinedByString:@","];
}

//字符串转字典针对图片
+(NSDictionary *)stringDictionaryImge:(NSString *)str{
    NSArray *strArray = [str componentsSeparatedByString:@","];
    NSMutableArray *keys=[[NSMutableArray alloc]init];
    for (int i=0; i<strArray.count; i++) {
        [keys addObject:[NSString stringWithFormat:@"zhaopian%d",i]];
    }
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:strArray forKeys:keys];
    return dic;
}

+(NSString *)repl:(NSString *)rel Str:(NSString *)str{
    return [str stringByReplacingOccurrencesOfString:rel withString:@""];
}
//字符串截取
+(NSString *)jiequStr:(NSString *)str rep:(NSString *)rep{
    //    NSRange range = [str rangeOfString:rep];//匹配得到的下标
    //    if (range.location<=str.length) {
    //        return  [str substringToIndex:range.location];//截取范围类的字符串
    //    }
    //    return nil;
    
    NSRange startRange = [str rangeOfString:@"/uploadFile"];
    NSRange endRange = [str rangeOfString:@".png"];
    NSRange range = NSMakeRange(startRange.location, endRange.location - startRange.location +endRange.length);
    if (range.length>0&&range.length<str.length) {
        NSString *result = [str substringWithRange:range];
        NSLog(@"%@====",result);
        if (result.length>1) {
            return result;
        }
    }
    return nil;
}

+(void)_initSdImage:(NSString *)url ImageView:(UIImageView *)iageView{
    [iageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,url]] placeholderImage:nil];
}


@end
