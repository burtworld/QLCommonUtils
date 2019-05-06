//
//  UIViewController+QLHJBaseVC.h
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/13.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLTransitionDismissPopStyleAnimator.h"
#import "QLTransitionPresenPushStyleAnimator.h"


typedef enum _BACK_TYPE {
    POP                     = 0,    //!<< pop
    POP_TO_ROOT             = 1,    //!<< pop to root
    DISMISS                 = 2,    //!<< dismiss
    DISMISS_TO_ACCESTOR     = 3,    //!<< dismiss accestor
}BACK_TYPE;

typedef void(^QLHJNavRightBarButtonAction)(BOOL isSelect);
typedef void(^QLHJDismissBackAction)(void);

@interface UIViewController (QLHJBaseVC)<UIViewControllerTransitioningDelegate,UIGestureRecognizerDelegate>

/// navigationBar right Item事件
@property (copy, nonatomic) QLHJNavRightBarButtonAction rightBarButtonItemBlock;

/// Dismiss结束后事件
@property (copy, nonatomic) QLHJDismissBackAction dismissAction;

/// 返回类型
@property (assign, nonatomic) BACK_TYPE backType;

/// present 模拟 push
@property (nonatomic, assign) BOOL presentSimulatPushStyle;

/// push 模拟 present
@property (nonatomic, assign) BOOL pushSimulatPushStyle;

/// 侧滑事件
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;


- (void)backButton;
- (void)backButtonWithImg:(UIImage *)img;
- (void)noBackButton;

//! 返回方法，如果需要监听返回事件，重写此方法
- (void)backActionByQLHJ:(BOOL)animation;
- (UIBarButtonItem *)addRightBarButtonWithImage:(UIImage *)img
                                   highlightImg:(UIImage *)hightlightImg
                                          title:(NSString *)title
                                      andAction:(void(^)(BOOL isSelect))action;
- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem;

- (UIToolbar *)addToolBar;
- (void)completeSelect:(UIButton *)sender;

- (void)presentViewController:(UIViewController *)viewControllerToPresent
                     animated:(BOOL)animated
                   completion:(void (^)(void))completion
                    pushStyle:(BOOL)isPushStyle;
@end
