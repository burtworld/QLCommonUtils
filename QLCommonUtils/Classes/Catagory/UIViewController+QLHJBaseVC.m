//
//  UIViewController+QLHJBaseVC.m
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/13.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import "UIViewController+QLHJBaseVC.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "NSString+QLFunctions.h"
#import "QLHJAPPManager.h"

@implementation UIViewController (QLHJBaseVC)
static const char QLHJRightBarButtonBlockKey = '\0';
- (void)setRightBarButtonItemBlock:(QLHJNavRightBarButtonAction)rightBarButtonItemBlock {
    [self willChangeValueForKey:@"rightBarButtonItemBlock"];
    objc_setAssociatedObject(self, &QLHJRightBarButtonBlockKey, rightBarButtonItemBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"rightBarButtonItemBlock"];
}

- (QLHJNavRightBarButtonAction)rightBarButtonItemBlock {
    return objc_getAssociatedObject(self, &QLHJRightBarButtonBlockKey);
}

static const char QLHJDismissKey = '\0';
-  (void)setDismissAction:(QLHJDismissBackAction)dismissAction {
    [self willChangeValueForKey:@"dismissAction"];
    objc_setAssociatedObject(self, &QLHJDismissKey, dismissAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"dismissAction"];
}

- (QLHJDismissBackAction)dismissAction {
    return objc_getAssociatedObject(self, &QLHJDismissKey);
}

static const char QLHJBackTypeKey = '\0';
- (void)setBackType:(BACK_TYPE)backType {
    [self willChangeValueForKey:@"backType"];
    objc_setAssociatedObject(self, &QLHJBackTypeKey, [NSNumber numberWithInt:backType], OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"backType"];
}

- (BACK_TYPE)backType {
    NSNumber *type = objc_getAssociatedObject(self, &QLHJBackTypeKey);
    return [type intValue];
}

- (void)backButton
{
    //返回按钮的设置
    self.navigationItem.leftBarButtonItems = nil;
    self.navigationItem.leftBarButtonItem = nil;
    UIButton * button= [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * buttonImage = [UIImage imageNamed:@"icon_back.png"];
    if (buttonImage) {
        [button setImage:buttonImage forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
        [button addTarget:self action:@selector(backActionByQLHJ) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:button];
        [self addLeftBarButtonItem:leftItem];
    }
}

- (void)backButtonWithImg:(UIImage *)img
{
    //返回按钮的设置
    self.navigationItem.leftBarButtonItems = nil;
    self.navigationItem.leftBarButtonItem = nil;
    UIButton * button= [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * buttonImage = img;
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(backActionByQLHJ) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    [self addLeftBarButtonItem:leftItem];
}

- (void)noBackButton {
    //返回按钮的设置
    NSLog(@"无返回按钮");
    self.navigationItem.leftBarButtonItems = nil;
    self.navigationItem.leftBarButtonItem = nil;
    UIButton * button= [UIButton buttonWithType:UIButtonTypeCustom];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    [self addLeftBarButtonItem:leftItem];
}

- (void)backActionByQLHJ {
    if (self.backType == POP) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.backType == POP_TO_ROOT) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (self.backType == DISMISS) {
        if (self.dismissAction) {
            [self dismissViewControllerAnimated:YES completion:self.dismissAction];
        }else{
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
    }else if (self.backType == DISMISS_TO_ACCESTOR) {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        negativeSpacer.width = -20;
        self.navigationItem.leftBarButtonItems=@[negativeSpacer,leftBarButtonItem];
//        self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    }
    else
    {
        //        negativeSpacer.width = -20;
        self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    }
}

- (void)addRightBarButtonWithImage:(UIImage *)img
                      highlightImg:(UIImage *)hightlightImg
                             title:(NSString *)title
                         andAction:(void(^)(BOOL isSelect))action {
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        CGFloat width = [title getWidthWithFont:FONT_14 andHeight:44.0f] + 10;
        rightButton.titleLabel.font = FONT_14;
        [rightButton setTitle:title forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        rightButton.frame = CGRectMake(0, 0, width, 44.0f);
    }
    if (img) {
        CGFloat width = img.size.width > 44 ? : 44;
        rightButton.frame = CGRectMake(0, 0, width, img.size.height);
        [rightButton setImage:img forState:UIControlStateNormal];
    }
    if (hightlightImg) {
        [rightButton setImage:hightlightImg forState:UIControlStateHighlighted];
    }
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [self addRightBarButtonItem:rightBarButtonItem];
    if (action != NULL) {
        self.rightBarButtonItemBlock = action;
    }
}
- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        negativeSpacer.width = -10;
        self.navigationItem.rightBarButtonItems=@[negativeSpacer,rightBarButtonItem];
    } else {
        negativeSpacer.width = -10;
        self.navigationItem.rightBarButtonItem=rightBarButtonItem;
    }
}
- (void)rightButtonAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (self.rightBarButtonItemBlock !=NULL) {
        self.rightBarButtonItemBlock(btn.selected);
    }
}

#define TOOLBAR_HEIGHT 40.0f
#pragma mark - addToolBar
- (UIToolbar *)addToolBar {
    UIToolbar * toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TOOLBAR_HEIGHT)];
    toolBar.backgroundColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:0.8];
    
    UIBarButtonItem * barButtonItem1 = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:QLHJBarButtonItemStyleBordered target:self action:@selector(cancleSelect:)];
    UIBarButtonItem * barButtonItem2 = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:QLHJBarButtonItemStyleBordered target:self action:@selector(completeSelect:)];
    UIBarButtonItem * barButtonItemSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items = @[barButtonItem1,barButtonItemSpace,barButtonItem2];
    return toolBar;
}

- (void)cancleSelect:(UIButton *)sender {
    [self.view endEditing:YES];
}

- (void)completeSelect:(UIButton *)sender {
    [self.view endEditing:YES];
}
@end
