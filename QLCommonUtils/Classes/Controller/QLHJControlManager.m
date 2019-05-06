//
//  QLHJControlManager.m
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/13.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import "QLHJControlManager.h"

#import "NSString+QLFunctions.h"
#import "QLHJAPPManager.h"
#import "UIImage+QLExtensions.h"
#import "QLHJMaskView.h"
#import "UIColor+QLColor.h"

@implementation QLHJControlManager
+ (UITabBarItem *)creatTabBarItemWithTittle:(NSString *)tittle
                                     andImg:(UIImage *)img
                                   andImg_h:(UIImage *)img_h
                                     nColor:(UIColor *)nColor
                                     sColor:(UIColor *)sColor{
    UITabBarItem * item = nil;
    if (SYSTEM_VERSION >= kCFCoreFoundationVersionNumber_iOS_7_0) {
        item = [[UITabBarItem alloc]initWithTitle:tittle image:img selectedImage:img_h];
        [item setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item setSelectedImage:[img_h imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }else{
        item = [[UITabBarItem alloc]init];
        item.title = tittle;
        
        item.selectedImage = img_h;
        item.image = img;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
        [item setFinishedSelectedImage:img_h withFinishedUnselectedImage:img];
#endif
    }
    if (nColor) {
        [item setTitleTextAttributes:@{QLHJTextAttributeTextColor : nColor} forState:UIControlStateNormal];
    }
    
    if (sColor) {
        [item setTitleTextAttributes:@{QLHJTextAttributeTextColor : sColor} forState:UIControlStateSelected];
    }
    [item setTitlePositionAdjustment:UIOffsetMake(item.titlePositionAdjustment.horizontal,item.titlePositionAdjustment.vertical)];
    return item;
}

+ (UITextField *)creatTextFieldWithFrame:(CGRect)rect
                                 andText:(NSString *)text
                          andPlaceHolder:(NSString *)placeHolder
                             andLeftView:(UIView *)leftView
                            andRightView:(UIView *)rightView
                      andBackGroundImage:(UIImage *)bgImg
                                delegate:(id<UITextFieldDelegate>)delegate{
    UITextField * textField = [[UITextField alloc]initWithFrame:rect];
    if (text) {
        textField.text = text;
    }
    if (placeHolder) {
        textField.placeholder = placeHolder;
    }
    if (leftView) {
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.leftView = leftView;
    }
    if (rightView) {
        textField.rightViewMode = UITextFieldViewModeAlways;
        textField.rightView = rightView;
    }else{
        [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    }
    
    if (bgImg) {
        textField.background = bgImg;
    }
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.backgroundColor = [UIColor clearColor];
    textField.font = FONT_14;
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = delegate;
    return textField;
}
+ (UIButton *)creatColorBtnWithFrame:(CGRect)frame
                               color:(UIColor *)color
                           andTittle:(NSString *)title
                              target:(id)target
                         andSelector:(SEL)selector{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.titleLabel.font = FONT_14;
    btn.layer.cornerRadius = 5.0f;
    btn.clipsToBounds = YES;
    if (color) {
        UIImage * image = [UIImage imageWithColor:color size:CGSizeMake(2, 2)];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (selector) {
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

+ (UIButton *)creatImageAboveTittleButtonWithFrame:(CGRect)frame
                                             image:(UIImage *)image
                                           image_h:(UIImage *)image_h
                                            tittle:(NSString *)tittle
                                             bgImg:(UIImage *)imageBg
                                      hightedBgImg:(UIImage *)imageBg_h
                                       tittleColor:(UIColor *)tittleColor
                                              font:(UIFont *)font
                                            target:(id)target
                                       andSelector:(SEL)selector {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setBackgroundColor:[UIColor clearColor]];
    if (tittle.length) {
        [btn setTitle:tittle forState:UIControlStateNormal];
    }
    
    if (tittleColor) {
        [btn setTitleColor:tittleColor forState:UIControlStateNormal];
    }
    if (font) {
        btn.titleLabel.font = font;
    }else{
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    
    if (imageBg) {
        [btn setBackgroundImage:imageBg forState:UIControlStateNormal];
    }
    if (imageBg_h) {
        [btn setBackgroundImage:imageBg_h forState:UIControlStateHighlighted];
    }
    if (image) {
        [btn setImage:image forState:UIControlStateNormal];
    }
    if (image_h) {
        [btn setImage:image_h forState:UIControlStateHighlighted];
    }
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    CGSize size = QLHJ_MULTILINE_TEXTSIZE(tittle, btn.titleLabel.font, CGSizeMake(CGFLOAT_MAX, 22), QLHJLineBreakModeByCharWrapping);
    
    if (frame.size.height >= (image.size.height + size.height)) {
        float offsetY = (frame.size.height - image.size.height - size.height)/2 - 5;
        [btn setImageEdgeInsets:UIEdgeInsetsMake(offsetY, (btn.frame.size.width - image.size.width)/2, 0, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(image.size.height + offsetY + 5, (btn.frame.size.width - size.width) / 2  -  image.size.width, 0, 0)];
    }else{
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, (btn.frame.size.width - image.size.width)/2, 0, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(image.size.height, (btn.frame.size.width - size.width) / 2  -  image.size.width, 0, 0)];
    }
    
    if (selector) {
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}

+ (UIButton *)creatButtonWithFrame:(CGRect)frame
                         andTittle:(NSString *)tittle
                            andImg:(UIImage *)img
                          andImg_h:(UIImage *)img_h
                    andTittleColor:(UIColor *)tittleColor
                           andFont:(UIFont *)font
                            target:(id)target
                       andSelector:(SEL)selector{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:tittle forState:UIControlStateNormal];
    if (img) {
        [btn setBackgroundImage:img forState:UIControlStateNormal];
    }
    if (img_h) {
        [btn setBackgroundImage:img_h forState:UIControlStateHighlighted];
    }
    if (font) {
        btn.titleLabel.font = font;
    }
    
    [btn setTitleColor:tittleColor forState:UIControlStateNormal];
    btn.frame = frame;
    if (selector) {
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}

+ (UIButton *)creatButtonWithframe:(CGRect)frame
                      andNormalImg:(UIImage *)nImage
                      andSelectImg:(UIImage *)sImage
                         andNTitle:(NSString *)nTitle
                         andSTitle:(NSString *)sTitle
                            target:(id)target
                       andSelector:(SEL)selector{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (nImage) {
        [btn setImage:nImage forState:UIControlStateNormal];
    }
    if (sImage) {
        [btn setImage:sImage forState:UIControlStateSelected];
    }
    if (nTitle) {
        [btn setTitle:nTitle forState:UIControlStateNormal];
    }
    if (sTitle) {
        [btn setTitle:sTitle forState:UIControlStateSelected];
    }
    if (selector) {
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}

//!  默认为无色
+ (UILabel *)creatLableWithFrame:(CGRect)frame
                       andTittle:(NSString *)tittle
                    andTextColor:(UIColor *)textColor
                         andFont:(UIFont *)font
                andTextAlignment:(NSTextAlignment)alignment {
    UILabel * lab = [[UILabel alloc]initWithFrame:frame];
    lab.text = tittle;
    lab.textColor = textColor;
    lab.backgroundColor = [UIColor clearColor];
    lab.font = font;
    lab.textAlignment = alignment;
    return lab;
}
@end

@implementation LineLable
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGSize size = QLHJ_MULTILINE_TEXTSIZE(self.text, self.font, CGSizeMake(CGFLOAT_MAX, self.frame.size.height), QLHJLineBreakModeByCharWrapping);
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake( 0, self.frame.size.height/2)];
    [path addLineToPoint:CGPointMake(size.width, self.frame.size.height/2 )];
    path.lineWidth = 0.5f;
    
    UIColor * color = nil;
    if (self.lineColor) {
        color = self.lineColor;
    }else{
        color = COLOR_OF_HEX(0xB3B3B3);
    }
    [color set];
    [path stroke];
    //    CGContextSetStrokeColorWithColor(ref, color.CGColor);
    //
    //    CGContextMoveToPoint(ref, 0, self.frame.size.height/2);
    //    CGContextAddLineToPoint(ref, size.width, self.frame.size.height/2);
    //    CGContextStrokePath(ref);
    
}


@end

#define TOOLBAR_HEIGHT 40.0f
#define PICKVIEW_HEIGHT 216.0f
#define MaskViewAlpha 0.2f
@interface QLHJPickView ()
@property (retain, nonatomic) QLHJMaskView * maskControl;
@property (assign, nonatomic) SEL method;
@property (retain, nonatomic) id<UIPickerViewDataSource> pickViewDataSource;
@property (retain, nonatomic) id<UIPickerViewDelegate> pickViewDelegate;
@property (retain, nonatomic) id methodTarget;
@end

@implementation QLHJPickView

- (id)initWithDataSource:(id<UIPickerViewDataSource>)dataSource delegate:(id<UIPickerViewDelegate>)delegate {
    self = [super init];
    if (self) {
        self.pickViewDataSource = dataSource;
        self.pickViewDelegate = delegate;
        [self initialization];
    }
    return self;
}

- (id)initWithDataSource:(id<UIPickerViewDataSource>)dataSource delegate:(id<UIPickerViewDelegate>)delegate completeMethod:(SEL)method target:(id)target {
    self = [super init];
    if (self) {
        self.pickViewDataSource = dataSource;
        self.pickViewDelegate = delegate;
        self.method = method;
        self.methodTarget = target;
        [self initialization];
    }
    return self;
}

- (void)initialization {
    [self addToolBar];
    self.pickView = [[UIPickerView alloc]init];
    self.pickView.frame = CGRectMake(0, TOOLBAR_HEIGHT, SCREEN_WIDTH, PICKVIEW_HEIGHT);
    self.pickView.backgroundColor = [UIColor whiteColor];
    self.pickView.showsSelectionIndicator = YES;
    self.pickView.dataSource = self.pickViewDataSource;
    self.pickView.delegate = self.pickViewDelegate;
    [self addSubview:self.pickView];
    [self.pickView selectRow:0 inComponent:0 animated:NO];
    QLHJWeakSelf(self);
    self.maskControl = [[QLHJMaskView alloc]initWithFrame:CGRectZero block:^(QLHJMaskView *maskView) {
        [weakself hide:YES];
    }];
    self.maskControl.backgroundColor = [UIColor blackColor];
}

- (void)addToolBar {
    UIToolbar * toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TOOLBAR_HEIGHT)];
    toolBar.backgroundColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:0.8];
    UIBarButtonItem * barButtonItem1 = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleSelectPickView:)];
    UIBarButtonItem * barButtonItem2 = nil;
    if (self.methodTarget && self.method) {
        barButtonItem2 = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self.methodTarget action:self.method];
    }else{
        barButtonItem2 = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(completeSelectPickView:)];
    }
    UIBarButtonItem * barButtonItemSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items = @[barButtonItem1,barButtonItemSpace,barButtonItem2];
    [self addSubview:toolBar];
}

- (void)cancleSelectPickView:(UIBarButtonItem *)barButtonItem {
    [self hide:YES];
}

- (void)completeSelectPickView:(UIBarButtonItem *)barButtonItem {
    [self hide:YES];
}

#pragma mark - View Show and hide
- (void)showInView:(UIView *)view animation:(BOOL)animation{
    self.frame = CGRectMake(0, view.frame.size.height, SCREEN_WIDTH, TOOLBAR_HEIGHT + PICKVIEW_HEIGHT);
    if (animation) {
        [view addSubview:self];
        self.maskControl.frame = view.bounds;
        self.maskControl.alpha = 0.0001;
        self.alpha = 0;
        [view insertSubview:self.maskControl belowSubview:self];
        
        [UIView animateWithDuration:0.3f animations:^{
            self.frame = CGRectMake(0, view.frame.size.height - TOOLBAR_HEIGHT - PICKVIEW_HEIGHT, SCREEN_WIDTH, TOOLBAR_HEIGHT + PICKVIEW_HEIGHT);
            self.maskControl.alpha = MaskViewAlpha;
            self.alpha = 1.0f;

        } completion:^(BOOL finished) {
            
        }];
    }else{
        [view addSubview:self];
        self.maskControl.frame = view.bounds;
        self.maskControl.alpha = MaskViewAlpha;
        [view insertSubview:self.maskControl belowSubview:self];
    }
}

- (void)hide:(BOOL)animationed {
    if (animationed) {
        [UIView animateWithDuration:0.3f animations:^{
            self.maskControl.alpha = 0.001;
            self.frame = CGRectMake(0, self.frame.origin.y + TOOLBAR_HEIGHT + PICKVIEW_HEIGHT, SCREEN_WIDTH, TOOLBAR_HEIGHT + PICKVIEW_HEIGHT);
            self.alpha = 0.001;
        } completion:^(BOOL finished) {
            [self.maskControl removeFromSuperview];
            [self removeFromSuperview];
        }];
    }else{
        self.maskControl.alpha = 0;
        [self.maskControl removeFromSuperview];
        [self removeFromSuperview];
    }
}


@end
