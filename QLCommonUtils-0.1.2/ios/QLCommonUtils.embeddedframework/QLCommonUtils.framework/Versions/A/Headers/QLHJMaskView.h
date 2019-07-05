//
//  QLHJMaskView.h
//  QLCommonUtils
//
//  Created by Paramita on 2017/12/13.
//  Copyright © 2017年 Paramita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QLHJMaskView : UIControl
- (id)initWithFrame:(CGRect)frame block:(void(^)(QLHJMaskView *maskView))block;
@end
