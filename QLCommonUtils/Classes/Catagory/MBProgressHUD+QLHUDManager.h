//
//  MBProgressHUD+HUDManager.h
//  TestProject
//
//  Created by Paramita on 16/11/7.
//  Copyright © 2016年 Paramita. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
   
@interface MBProgressHUD (QLHUDManager)
+ (void)promptWithText:(NSString *)text andDetailText:(NSString *)detailText;
+ (void)promptWithText:(NSString *)text;

+ (void)showLoadingToView:(UIView *)view text:(NSString *)text detailText:(NSString *)detailText;
+ (void)showLoadingToView:(UIView *)view text:(NSString *)text;
+ (void)showLoadingToView:(UIView *)view;
+ (void)showWithGIF:(NSString *)gifurl view:(UIView *)view;
+ (void)hideHUDForView:(UIView *)view;

@end
