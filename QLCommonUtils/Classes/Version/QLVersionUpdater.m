//
//  VersionUpdater.m
//  YiBaoFu
//
//  Created by mac on 15/4/28.
//  Copyright (c) 2015年 qlhj. All rights reserved.
//

#import "QLVersionUpdater.h"

@interface QLVersionUpdater () <UIAlertViewDelegate>
@property (retain, nonatomic) NSString * url;
@property (retain, nonatomic) NSString * message;
@end

@implementation QLVersionUpdater


+ (void)foundAppStoreNewVersionWithAppId:(NSString *)appId block:(VersionBlock)block {
    if (!appId.length) {
        if (block) {
            block (nil, nil,nil, NO);
            return;
        }
    }
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    NSString * urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", appId];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"GET"];
    
    [request setTimeoutInterval:60.0f];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask * tast = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error && block) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block (nil, nil,nil, NO);
                return;
            });
        }
        if (data) {
            NSDictionary *appInfoDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (error || [[appInfoDict valueForKey:@"resultCount"] intValue] == 0) {
                return;
            }
            NSString * releaseNote = [[[appInfoDict objectForKey:@"results"] objectAtIndex:0] objectForKey:@"releaseNotes"];
            NSString *newVersion = [[[appInfoDict objectForKey:@"results"] objectAtIndex:0] objectForKey:@"version"];
            if ([currentVersion compare:newVersion options:NSNumericSearch] != NSOrderedAscending) {
                block(nil,@"当前已是最新版本",nil,NO);
                return;
            }
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?ls=1&mt=8", appId]];
            if (block) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(newVersion,releaseNote,url,NO);
                });
                
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
               if (block) {
                   block(nil,@"当前已是最新版本",nil,NO);
               }
            });
            
        }
    }];
    [tast resume];
}

+ (void)gotoAppStoreWithAppId:(NSString *)appId {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?ls=1&mt=8", appId]];
    [[UIApplication sharedApplication] openURL:url];
}

+ (void)foundNewVersionWithOrganId:(NSString *)organId configVersion:(NSString *)configVersion Block:(VersionBlock)block {

//    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
//    NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
//    
//    NSDictionary * params = @{
//                              @"cmd" : @"checkVersion",
//                              @"version" : @"1.6.0",
//                              @"system" : @"1",
//                              @"organId" : organId.length ? organId : @"",
//                              @"configVersion" : configVersion.length ? configVersion : @""
//                              };
//    
//    [[QLHJAPPNetwork network] postAFDataWithUrlStr:nil andParams:params andResultBlock:^(BOOL success, id responseData, NSString *message) {
//        if (success) {
//            if ([responseData isKindOfClass:[NSDictionary class]]) {
//                NSString * newVersion = responseData[@"appVer"];
//                BOOL updateType = [responseData[@"updateType"] boolValue];
//                NSString * urlStr = responseData[@"url"];
//                NSURL * url = [NSURL URLWithString:urlStr];
//                if ([currentVersion compare:newVersion options:NSNumericSearch] != NSOrderedAscending) {
//                    return;
//                }
//                [QLHJAPPContext context].appUpdateModel = [[AppUpdateModel alloc]initWithData:responseData];
//                if (block) {
//                    block(newVersion,message,url,updateType);
//                }
//            }
//        }else{
//            [QLHJAPPManager promotWithText:message];
//        }
//    }];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        NSURL*url = [NSURL URLWithString:self.url];
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
