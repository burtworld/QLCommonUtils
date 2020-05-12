//
//  UIViewController+WaterMarker.m
//  Sgcc
//
//  Created by Paramita on 2019/5/7.
//  Copyright © 2019 Paramita. All rights reserved.
//

#import "UIViewController+WaterMarker.h"
#import "QLHJWaterMarker.h"
#import <Masonry/Masonry.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "UIColor+QLColor.h"
//#import "UIColor+Function.h"

static const char WaterMarkerViewKey = '\0';

static NSArray *textArray = nil;

@implementation UIViewController (WaterMarker)


- (void)setWaterMarkerView:(UIImageView *)waterMarkerView {
    [self willChangeValueForKey:@"waterMarkerView"];
    objc_setAssociatedObject(self, &WaterMarkerViewKey, waterMarkerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"waterMarkerView"];
}

- (UIImageView *)waterMarkerView {
    return objc_getAssociatedObject(self, &WaterMarkerViewKey);
}

- (void)showWaterMakerWithTexts:(NSArray *)texts {
    if (!texts) {
        NSLog(@"请输入水印背景文字");
        return;
    }
    textArray = texts;
    [self.waterMarkerView removeFromSuperview];
    self.waterMarkerView = nil;
    if (!self.waterMarkerView) {
        self.waterMarkerView = [UIImageView new];
        self.waterMarkerView.backgroundColor = [UIColor clearColor];
        self.waterMarkerView.contentMode = UIViewContentModeCenter;
        self.waterMarkerView.opaque = YES;
        [self.view addSubview:self.waterMarkerView];
        [self.waterMarkerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UIImage *imgs = [QLHJWaterMarker getWaterMarkImage:CGSizeMake(width, height) texts:texts font:nil textColor:[COLOR_OF_HEX(0xAEAEAE) colorWithAlphaComponent:54/255.0] bgColor:nil];
    self.waterMarkerView.image = imgs;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interfaceDidRotate:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)interfaceDidRotate:(NSNotification *)notification {
    NSLog(@"重绘水印");
    [self showWaterMakerWithTexts:textArray];
}


- (void)showWaterMakerWithTexts:(NSArray *)texts textColor:(UIColor *)color font:(UIFont *)font {
    if (!texts) {
        NSLog(@"请输入水印背景文字");
        return;
    }
    if (!self.waterMarkerView) {
        self.waterMarkerView = [UIImageView new];
        self.waterMarkerView.backgroundColor = [UIColor clearColor];
        self.waterMarkerView.contentMode = UIViewContentModeCenter;
        self.waterMarkerView.opaque = YES;
        [self.view addSubview:self.waterMarkerView];
        [self.waterMarkerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    
    CGFloat width = MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    UIImage *imgs = [QLHJWaterMarker getWaterMarkImage:CGSizeMake(width, width) texts:texts font:font textColor:color bgColor:nil];
    self.waterMarkerView.image = imgs;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
