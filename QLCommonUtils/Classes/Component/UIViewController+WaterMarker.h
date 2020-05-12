//
//  UIViewController+WaterMarker.h
//  Sgcc
//
//  Created by Paramita on 2019/5/7.
//  Copyright © 2019 Paramita. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (WaterMarker)
@property (nonatomic, retain, readonly) UIImageView *waterMarkerView;

- (void)showWaterMakerWithTexts:(NSArray *)texts;

- (void)showWaterMakerWithTexts:(NSArray *)texts textColor:(UIColor *)color font:(UIFont *)font;
@end

