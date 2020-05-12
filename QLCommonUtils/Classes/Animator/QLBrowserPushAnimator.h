//
//  QLBrowserPushAnimator.h
//  AFNetworking
//
//  Created by Paramita on 2019/11/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QLBrowserPushAnimator : NSObject<UIViewControllerAnimatedTransitioning>

/// 初始的view,即事件发生的view.
@property (retain, nonatomic) UIView * orgView;

/// 等待图片
@property (retain, nonatomic) UIImage *placeHolderImage;
@end

NS_ASSUME_NONNULL_END
