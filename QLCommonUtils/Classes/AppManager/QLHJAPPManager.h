//
//  QLHJAPPManager.h
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/12.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+QLFunctions.h"

#pragma mark - 根据版本选定对齐方式、状态栏 字体、字体前景色、状态栏
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
#define QLHJTextAlignmentLeft           NSTextAlignmentLeft
#define QLHJTextAlignmentCenter         NSTextAlignmentCenter
#define QLHJTextAlignmentRight          NSTextAlignmentRight
#define QLHJLineBreakModeByCharWrapping NSLineBreakByCharWrapping
#define QLHJTextAttributeTextColor      NSForegroundColorAttributeName
#define QLHJTextAttributeFont           NSFontAttributeName
#define QLHJStatusBarStyleBlackOpaque   UIStatusBarStyleLightContent
#else
#define QLHJTextAlignmentLeft           UITextAlignmentLeft
#define QLHJTextAlignmentCenter         UITextAlignmentCenter
#define QLHJTextAlignmentRight          UITextAlignmentRight
#define QLHJLineBreakModeByCharWrapping UILineBreakModeCharacterWrap
#define QLHJTextAttributeTextColor      UITextAttributeTextColor
#define QLHJTextAttributeFont           UITextAttributeFont
#define QLHJStatusBarStyleBlackOpaque   UIStatusBarStyleBlackOpaque
#endif


#pragma mark - arc
#if __has_feature(objc_arc)
#define QLHJ_AUTORELEASE(exp) exp
#define QLHJ_RELEASE(exp) exp
#define QLHJ_RETAIN(exp) exp
#define QLHJ_BlockRelease(exp) exp
#define QLHJ_BlockCope(exp) exp
#else
#define QLHJ_AUTORELEASE(exp) [exp autorelease]
#define QLHJ_RELEASE(exp) [exp release]
#define QLHJ_RETAIN(exp) [exp retain]
#define QLHJ_BlockRelease(exp) Block_release(exp)
#define QLHJ_BlockCope(exp) Block_copy(exp)
#endif




#pragma mark - UIBarButtonItemStyleBordered
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
#define QLHJBarButtonItemStyleBordered UIBarButtonItemStylePlain
#else
#define QLHJBarButtonItemStyleBordered UIBarButtonItemStyleBordered
#endif


#pragma mark - 屏幕宽高
#define SCREEN_WIDTH                    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT                   [UIScreen mainScreen].bounds.size.height
#define kApplicationStatusBarHeight     [UIApplication sharedApplication].statusBarFrame.size.height //状态栏的高度
#define kQLSCALE_FACTOR (([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height) ? ([UIScreen mainScreen].bounds.size.width/667) : ([UIScreen mainScreen].bounds.size.width/375))

#pragma mark - 偏移像素
#define PADDING_70                      70.0f
#define PADDING_20                      20.0f
#define PADDING_15                      15.0f
#define PADDING_10                      10.0f
#define PADDING_5                       5.0f

#define SYSTEM_VERSION                  ([UIDevice currentDevice].systemVersion.floatValue)
#define VERSION_8_UP                    ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f ? YES : NO)
#define VERSION_7_UP                    (SYSTEM_VERSION >= 7.0f ? YES : NO)

#pragma mark - 路径
// 缓存路径
#define CACHE_PATH ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0])
// 文档路径
#define DOCUMENT_PATH ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0])
// 库路径
#define LIBERALY_PATH ([NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0])

// 数据库路径
#define DB_PATH [DOCUMENT_PATH stringByAppendingPathComponent:@"DB"]
// url缓存路径
#define URL_CACHE_PATH [DOCUMENT_PATH stringByAppendingPathComponent:@"urlCache"]
// 图片缓存
#define IMG_CACHE_PATH [DOCUMENT_PATH stringByAppendingPathComponent:@"imageCache"]
// MainApp路径
#define MainApp_PATH [DOCUMENT_PATH stringByAppendingPathComponent:@"MainApp"]

#define MainApp_Tem_PATH [NSTemporaryDirectory() stringByAppendingPathComponent:@"MainApp"]
// Apps路径
#define Apps_PATH [DOCUMENT_PATH stringByAppendingPathComponent:@"Apps"]
// 文档路径
#define DOC_PATH [DOCUMENT_PATH stringByAppendingPathComponent:@"docs"]


#define IS_IPHONE4 (([UIScreen mainScreen].bounds.size.height == 480 ? YES:NO ))
#define IS_IPHONE_PLUS (([UIScreen mainScreen].bounds.size.height == 568 ? YES:NO ))
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
#define SizeScale ((SCREEN_HEIGHT > 568) ? SCREEN_HEIGHT/568 : 1)


#define IS_IPHONE_X (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(812.f, 375.f), [UIScreen mainScreen].bounds.size))
#define iPhoneXSeries (([[UIApplication sharedApplication] statusBarFrame].size.height == 44.0f) ? (YES):(NO))


#define IPHONE_NAVIGATIONBAR_HEIGHT  (iPhoneXSeries ? 88 : 64)
#define IPHONE_STATUSBAR_HEIGHT      (iPhoneXSeries ? 44 : 20)
#define IPHONE_SAFEBOTTOMAREA_HEIGHT (iPhoneXSeries ? 34 : 0)
#define IPHONE_TOPSENSOR_HEIGHT      (iPhoneXSeries ? 32 : 0)



//#ifdef DEBUG
////调试状态
//#define MyString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
//#define QLLog(...) printf("\nQLLog:%s %d行:%s\n\n",[MyString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
//#define mydebug(format, ...) fprintf (stderr, format, ## __VA_ARGS__)
//#else
////发布状态
//#define QLLog(...){}
//#endif

#define kOpenLog ([QLHJAPPManager defaultManager].openLog)
#ifdef kOpenLog
#define NSLog(format, ...) fprintf(stderr,"[%s] %s\n",[[NSString getNowTimeString] UTF8String],[[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String])
#else
#define NSLog(format, ...) nil
#endif

#if DEBUG
#define QLLOG(format, ...) fprintf(stderr,"[%s] %s\n",[[NSString getNowTimeString] UTF8String],[[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String])
#else
#define QLLOG(format, ...) nil
#endif

//#if DEBUG
//#define NSLog(format, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String])
//#else
//#define NSLog(format, ...) nil
//#endif

#define NSLog_WARNING(discribe) QLLOG(@"%@ %@ ⚠️ SEL-%@ %@", [NSString getNowTimeString],self.class, NSStringFromSelector(_cmd), discribe)
#define NSLog_ERROR(discribe) QLLOG(@"%@ %@ ❌ SEL-%@ %@", [NSString getNowTimeString],self.class, NSStringFromSelector(_cmd), discribe)

#define QLHJWeakSelf(type)  __weak typeof(type) weak##type = type;

#define QLHJ_SAVE_MALLOC(p, s,size)            {   if (p) { free(p); p=NULL; } \
p = (char *)malloc(size); \
memset(p, s, size);}

#define kLayoutFacotr 0.4

@interface QLHJAPPManager : NSObject

@property (nonatomic, assign) BOOL openLog;

+ (instancetype)defaultManager;
+ (NSString*)deviceString;
+ (NSString *)appVersion;
+ (NSString *)appName;
+ (void)catchExceptionLog:(NSException *)exception;

//! 加载运行时动态库 返回成功或者失败
+ (BOOL)openDylibWithPath:(NSString *)path;

//! 将日志输出到文件
+ (void)redirectNSlogToDocumentFolder;

//! 是否lldb调试模式
+ (BOOL)existDebugger;

//!
+ (BOOL)checkOutSandBox;
@end
















