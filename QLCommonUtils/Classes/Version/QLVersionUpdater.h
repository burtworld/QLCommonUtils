//
//  VersionUpdater.h
//  YiBaoFu
//
//  Created by mac on 15/4/28.
//  Copyright (c) 2015年 qlhj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



typedef void(^VersionBlock)(NSString * newVersion,NSString * notes,NSURL * appUrl,BOOL force);

@interface QLVersionUpdater : NSObject
@property (copy, nonatomic) VersionBlock block;
+ (void)foundAppStoreNewVersionWithAppId:(NSString *)appId block:(VersionBlock)block;
+ (void)gotoAppStoreWithAppId:(NSString *)appId;
+ (void)foundNewVersionWithOrganId:(NSString *)organId configVersion:(NSString *)configVersion Block:(VersionBlock)block;
@end
