//
//  QLRTNavigationBar.m
//  QLCommonUtils
//
//  Created by Paramita on 2019/2/28.
//  Copyright © 2019 Paramita. All rights reserved.
//

#import "QLHJRTNavigationBar.h"

@implementation QLHJRTNavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithBackGroundImage:(UIImage *)bgImg {
    self = [super init];
    if (self) {
        [self setBackgroundImage:bgImg forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}

@end
