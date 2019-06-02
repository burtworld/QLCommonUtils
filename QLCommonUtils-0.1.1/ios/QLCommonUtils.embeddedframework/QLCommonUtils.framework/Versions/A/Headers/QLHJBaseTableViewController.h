//
//  QLHJBaseTableViewController.h
//  QLCommonUtils
//
//  Created by paramita on 2018/11/21.
//  Copyright © 2018 Paramita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+QLHJBaseVC.h"
#import <RTRootNavigationController/RTRootNavigationController.h>
NS_ASSUME_NONNULL_BEGIN

@interface QLHJBaseTableViewController : UITableViewController<RTNavigationItemCustomizable>
@property (nonatomic,strong) UIImage *barImage;

/// 使用RTRootViewController
- (instancetype)initWithBarImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
