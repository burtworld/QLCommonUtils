//
//  QLHJControlManager.h
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/13.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QLHJControlManager : NSObject
+ (UITabBarItem *)creatTabBarItemWithTittle:(NSString *)tittle
                                     andImg:(UIImage *)img
                                   andImg_h:(UIImage *)img_h
                                     nColor:(UIColor *)nColor
                                     sColor:(UIColor *)sColor;
+ (UITextField *)creatTextFieldWithFrame:(CGRect)rect
                                 andText:(NSString *)text
                          andPlaceHolder:(NSString *)placeHolder
                             andLeftView:(UIView *)leftView
                            andRightView:(UIView *)rightView
                      andBackGroundImage:(UIImage *)bgImg
                                delegate:(id<UITextFieldDelegate>)delegate;
+ (UIButton *)creatColorBtnWithFrame:(CGRect)frame
                               color:(UIColor *)color
                           andTittle:(NSString *)title
                              target:(id)target
                         andSelector:(SEL)selector;
+ (UIButton *)creatImageAboveTittleButtonWithFrame:(CGRect)frame
                                             image:(UIImage *)image
                                           image_h:(UIImage *)image_h
                                            tittle:(NSString *)tittle
                                             bgImg:(UIImage *)imageBg
                                      hightedBgImg:(UIImage *)imageBg_h
                                       tittleColor:(UIColor *)tittleColor
                                              font:(UIFont *)font
                                            target:(id)target
                                       andSelector:(SEL)selector;
+ (UIButton *)creatButtonWithFrame:(CGRect)frame
                         andTittle:(NSString *)tittle
                            andImg:(UIImage *)img
                          andImg_h:(UIImage *)img_h
                    andTittleColor:(UIColor *)tittleColor
                           andFont:(UIFont *)font
                            target:(id)target
                       andSelector:(SEL)selector;
+ (UIButton *)creatButtonWithframe:(CGRect)frame
                      andNormalImg:(UIImage *)nImage
                      andSelectImg:(UIImage *)sImage
                         andNTitle:(NSString *)nTitle
                         andSTitle:(NSString *)sTitle
                            target:(id)target
                       andSelector:(SEL)selector;
+ (UILabel *)creatLableWithFrame:(CGRect)frame
                       andTittle:(NSString *)tittle
                    andTextColor:(UIColor *)textColor
                         andFont:(UIFont *)font
                andTextAlignment:(NSTextAlignment)alignment;
@end

@interface LineLable : UILabel
@property (retain, nonatomic) UIColor * lineColor;
@end

@interface QLHJPickView : UIView

@property (retain, nonatomic) UIPickerView * pickView;
- (void)showInView:(UIView *)view animation:(BOOL)animation;
- (id)initWithDataSource:(id<UIPickerViewDataSource>)dataSource delegate:(id<UIPickerViewDelegate>)delegate;

- (id)initWithDataSource:(id<UIPickerViewDataSource>)dataSource delegate:(id<UIPickerViewDelegate>)delegate completeMethod:(SEL)method target:(id)target;

- (void)hide:(BOOL)animationed;
@end



