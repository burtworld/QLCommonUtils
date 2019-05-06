//
//  QLHJMaskView.m
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/13.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import "QLHJMaskView.h"
typedef void(^QLHJMaskViewBlock)(QLHJMaskView *maskView);

@interface QLHJMaskView()
@property (copy, nonatomic) QLHJMaskViewBlock block;
@end

@implementation QLHJMaskView

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame block:(void(^)(QLHJMaskView *maskView))block {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.block = block;
        self.alpha = 0;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (self.block) {
        self.block(self);
    }
}

@end
