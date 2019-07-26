//
//  QLHJAPPManager.m
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/12.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import "QLHJAPPManager.h"
#import "sys/utsname.h"
#import <UIKit/UIKit.h>
#include <dlfcn.h>
#import <sys/types.h>
#import <sys/sysctl.h>
#import <sys/stat.h>


@implementation QLHJAPPManager
+ (instancetype)defaultManager{
    static QLHJAPPManager * manger = nil;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        manger = [QLHJAPPManager new];
    });
    return manger;
}

- (instancetype)init {
    self = [super init];
    if (self) {
#ifdef DEBUG
        self.openLog = YES;
#endif
    }
    return self;
}

+ (NSString*)deviceString
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    
    
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}

+ (NSString *)appVersion {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    return currentVersion;
}

+ (NSString *)appName {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleDisplayName"];
    return currentVersion;
}

+ (void)catchExceptionLog:(NSException *)exception {
    NSArray * arr = [exception callStackSymbols];   // 获取当前调用栈信息
    NSString * reason = [exception reason];         // 漰溃原因
    NSString * name = [exception name];             // 异常类型
    NSString * crashLoginInfo = [NSString stringWithFormat:@"异常类型exception type:%@\n\n漰溃原因:%@\n\n当前调用栈信息:%@\n\n",name,reason,arr];
    // 保存到本地
    NSString * documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, 0)[0];
    documentPath = [documentPath stringByAppendingPathComponent:@"bugLogs"];

    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString * nowTime = [formatter stringFromDate:[NSDate date]];
    documentPath = [documentPath stringByAppendingPathComponent:nowTime];
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:documentPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    [[NSFileManager defaultManager] createFileAtPath:documentPath contents:[crashLoginInfo dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
//    NSString * urlStr = [NSString stringWithFormat:@"mailto://%@?subject=软件崩溃报告&body=\n\n错误详情：%@",email，crashLoginInfo];
//    NSURL * url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    [[UIApplication sharedApplication] openURL:url];
}
+ (BOOL)openDylibWithPath:(NSString *)path
{
    void* libHandle = NULL;
    libHandle = dlopen([path cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
    if (libHandle == NULL) {
        char *error = dlerror();
//        QLErrorLog(@"dlopen error:",error);
        NSLog(@"dlopen error:%s",error);
        return NO;
    } else {
        NSLog(@"dlopen load framework success.");

        return YES;
    }
}

+ (void)redirectNSlogToDocumentFolder
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dataFormatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.log",dateString];// 注意不是NSData!
    
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];

    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}

+ (BOOL)existDebugger {
    int name[4];//指定查询信息的数组
    struct kinfo_proc info;//查询的返回结果
    size_t info_size = sizeof(info);
    info.kp_proc.p_flag = 0;
    
    name[0] = CTL_KERN;
    name[1] = KERN_PROC;
    name[2] = KERN_PROC_PID;
    name[3] = getpid();
    if (sysctl(name, 4, &info, &info_size, NULL, 0) == -1) {
        NSLog(@"sysctl error ...");
        return NO;
    }
    return ((info.kp_proc.p_flag & P_TRACED) != 0);
}

+ (BOOL)checkOutSandBox {
    //使用stat系列函数检测Cydia等工具
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    NSString *applications = @"/User/Applications/";
    NSString *Mobile = @"/Library/MobileSubstrate/MobileSubstrate.dylib";
    NSString *bash = @"/bin/bash";
    NSString *sshd =@"/usr/sbin/sshd";
    NSString *sd = @"/etc/apt";
    BOOL exist = NO;
    if([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        exist = YES;
    }
    
    if([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        exist = YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:applications]){
        exist = YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:Mobile]){
        exist = YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:bash]){
        exist = YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:sshd]){
        exist = YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:sd]){
        exist = YES;
    }
    return exist;
}


@end
















