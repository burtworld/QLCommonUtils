//
//  QLHJBaseNavigationController.h
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/21.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RTRootNavigationController/RTRootNavigationController.h>


@interface QLHJBaseNavigationController : RTRootNavigationController
- (id)initWithRootViewController:(UIViewController *)rootViewController color:(UIColor *)color;
- (id)initWithRootViewController:(UIViewController *)rootViewController image:(UIImage *)image;
@property (retain, nonatomic) UIColor * barColor;
@property (nonatomic,strong) UIImage *barImage;
@end
