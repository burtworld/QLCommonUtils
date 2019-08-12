//
//  QLHJBaseViewController.h
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/20.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+QLHJBaseVC.h"
#import <RTRootNavigationController/RTRootNavigationController.h>
#import <RTRootNavigationController/UIViewController+RTRootNavigationController.h>


@interface QLHJBaseViewController : UIViewController<RTNavigationItemCustomizable>
@property (nonatomic,strong) UIImage *barImage;

/// 使用RTRootViewController
- (instancetype)initWithBarImage:(UIImage *)image;

- (void)getScreenInfo:(void(^)(NSString *screenInfo,NSString *detail))block;
@end
