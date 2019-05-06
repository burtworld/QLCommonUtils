//
//  QLHJBaseViewController.m
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/20.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import "QLHJBaseViewController.h"
#import "QLHJAPPManager.h"


@interface QLHJBaseViewController ()

@end

@implementation QLHJBaseViewController

- (instancetype)initWithBarImage:(UIImage *)image {
    self = [super init];
    if (self) {
        self.barImage = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (self.barImage) {
         [self.navigationController.navigationBar setBackgroundImage:self.barImage forBarMetrics:UIBarMetricsDefault];
    }
   
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    self.rt_disableInteractivePop = NO;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //开启ios右滑返回
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    }
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    //返回按钮的设置
    self.navigationItem.leftBarButtonItems = nil;
    self.navigationItem.leftBarButtonItem = nil;
    UIButton * button= [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * buttonImage = [UIImage imageNamed:@"icon_back.png"];
    
    if (buttonImage) {
        [button setImage:buttonImage forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
        [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:button];
        return leftItem;
    }
    return nil;
}

- (void)backAction:(UIButton *)sender {
    [self backActionByQLHJ:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    QLLOG_WARNING(@"收到内存警告");
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
