//
//  QLHJBaseNavigationController.m
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/21.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import "QLHJBaseNavigationController.h"
#import "QLHJAPPManager.h"
#import "UIImage+QLExtensions.h"

@interface QLHJBaseNavigationController ()

@end

@implementation QLHJBaseNavigationController

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
 
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController color:(UIColor *)color{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.barColor = color;
        self.barImage = [[UIImage imageWithColor:self.barColor size:CGSizeMake(2, 2)] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 0.5, 1, 0.5)];
        [self customStyle];
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController image:(UIImage *)image{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.barImage = image;
        [self customStyle];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self customStyle];
}

- (void)customStyle {
    
    if (VERSION_7_UP) {
        if (self.barImage) {
            [self.navigationBar setBackgroundImage:self.barImage forBarMetrics:UIBarMetricsDefault];
        }else if (self.barColor != nil){
            UIImage * img = [[UIImage imageWithColor:self.barColor size:CGSizeMake(2, 2)] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 0.5, 1, 0.5)];
            [self.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
        }
        self.view.backgroundColor = [UIColor whiteColor];
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
//        self.navigationBar.barStyle = UIBarStyleDefault;
//        self.interactivePopGestureRecognizer.delegate = nil;
    }else{
        
        UIImage * img = [[UIImage imageWithColor:self.barColor size:CGSizeMake(2, 2)] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 0.5, 1, 0.5)];
        [self.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.barStyle = QLHJStatusBarStyleBlackOpaque;
    }
    self.transferNavigationBarAttributes = YES;
}

//支持旋转
-(BOOL)shouldAutorotate{
    return [self.topViewController shouldAutorotate];
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}


//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
