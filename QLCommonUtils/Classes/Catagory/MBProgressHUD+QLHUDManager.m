//
//  MBProgressHUD+HUDManager.m
//  TestProject
//
//  Created by Paramita on 16/11/7.
//  Copyright © 2016年 Paramita. All rights reserved.
//

#import "MBProgressHUD+QLHUDManager.h"
#import <SDWebImage/UIImage+GIF.h>

@implementation MBProgressHUD (QLHUDManager)

//+ (void)load {
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD setRingRadius:30];
//    [SVProgressHUD setRingThickness:3];
//}

+ (void)promptWithText:(NSString *)text andDetailText:(NSString *)detailText autoHidden:(int)delay{
    if (![text isKindOfClass:[NSString class]]) {
        return;
    }
    
    if (text.length || detailText.length) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            [SVProgressHUD showInfoWithStatus:text];
//            [SVProgressHUD dismissWithDelay:delay ? delay : 2.0f];
            UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;

            MBProgressHUD * hud = [[MBProgressHUD alloc]initWithView:keyWindow];
            hud.label.font = [UIFont systemFontOfSize:14.0f];
            hud.mode = MBProgressHUDModeText;
            hud.removeFromSuperViewOnHide = YES;
            hud.margin = 8.0f;
            CGFloat height = [UIScreen mainScreen].bounds.size.height;
            hud.offset = CGPointMake(0.f, height/2 - 100);
            if (text.length) {
                hud.label.font = [UIFont systemFontOfSize:14.0f];
                hud.label.text = text;
                hud.label.numberOfLines = 0;
            }

            if (detailText.length) {
                hud.detailsLabel.font = [UIFont systemFontOfSize:14.0f];
                hud.detailsLabel.text = text;
                hud.detailsLabel.numberOfLines = 0;
            }
            hud.userInteractionEnabled = NO;
            hud.bezelView.opaque = YES;
            [keyWindow addSubview:hud];
            [keyWindow bringSubviewToFront:hud];

            [hud showAnimated:YES];
            if (delay > 0) {
                [hud hideAnimated:YES afterDelay:delay];
            }
        });
    }
}

+ (void)promptWithText:(NSString *)text andDetailText:(NSString *)detailText {
    [[self class] promptWithText:text andDetailText:detailText autoHidden:2.0f];
}

+ (void)promptWithText:(NSString *)text {
    [[self class] promptWithText:text andDetailText:nil];
}

+ (void)showLoadingToView:(UIView *)view text:(NSString *)text detailText:(NSString *)detailText {
    dispatch_async(dispatch_get_main_queue(), ^{
//        [SVProgressHUD showWithStatus:text];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

        hud.label.text = text;
        // Set the details label text. Let's make it multiline this time.
        if (detailText) {
            hud.detailsLabel.text = detailText;
        }
        hud.square = YES;
        hud.removeFromSuperViewOnHide = YES;
    });
}

+ (void)showWithGIF:(NSString *)gifurl view:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:NO];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"33e30c18ec6aa4f5a93b3fc1c00007e3" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    UIImageView * imgV  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    imgV.backgroundColor = [UIColor redColor];
    imgV.image = image;
    hud.customView = imgV;
    // Looks a bit nicer if we make it square.
    hud.square = YES;
//    // Optional label text.
    hud.label.text = NSLocalizedString(@"Done", @"HUD done title");
}

/**
 *@brief 在view上添加一个加载提示
 *@param view 添加HUD的view
 */
+ (void)showLoadingToView:(UIView *)view text:(NSString *)text{
    [[self class] showLoadingToView:view text:text detailText:nil];
}

+ (void)showLoadingToView:(UIView *)view {
    [[self class] showLoadingToView:view text:@"加载中"];
}

//! 移除view上的所有HUD
+ (void)hideHUDForView:(UIView *)view {
//    [SVProgressHUD dismiss];
//    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
//    [hud hideAnimated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        while ([MBProgressHUD HUDForView:view] != nil) {
            [MBProgressHUD hideHUDForView:view animated:YES];
        }
    });
}
@end
