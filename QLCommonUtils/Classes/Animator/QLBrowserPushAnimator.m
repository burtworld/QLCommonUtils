//
//  QLBrowserPushAnimator.m
//  AFNetworking
//
//  Created by Paramita on 2019/11/11.
//

#import "QLBrowserPushAnimator.h"

@implementation QLBrowserPushAnimator



- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    if (!self.orgView) {
        return;
    }
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //ToVC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toViewController.view.hidden = YES;
    [containerView addSubview:toViewController.view];
    
    //FromVC
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect rect = [self.orgView.superview convertRect:self.orgView.frame toView:nil];

    //图片背景白色的空白view
    UIView *imgBgWhiteView = [[UIView alloc] initWithFrame:rect];
    imgBgWhiteView.backgroundColor =[UIColor whiteColor];
    [containerView addSubview:imgBgWhiteView];
    
    //有渐变的黑色背景
    UIView *bgView = [[UIView alloc] initWithFrame:containerView.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0;
    [containerView addSubview:bgView];
    
    //过渡的图片
    UIImageView *transitionImgView = [[UIImageView alloc] initWithImage:self.placeHolderImage];
    transitionImgView.layer.masksToBounds = YES;
    transitionImgView.contentMode = UIViewContentModeScaleAspectFill;
    transitionImgView.frame = imgBgWhiteView.bounds;
    [imgBgWhiteView addSubview:transitionImgView];
    
    CGRect dstRect = [self getCenterRectInWindow:self.placeHolderImage];
    //这就是动画啦啦啦
//    __weak typeof(self)weakself = self;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        transitionImgView.frame = dstRect;
        bgView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        toViewController.view.hidden = NO;
        
        [imgBgWhiteView removeFromSuperview];
        [bgView removeFromSuperview];
        [transitionImgView removeFromSuperview];
        
        //        设置transitionContext通知系统动画执行完毕
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}


//返回imageView在window上全屏显示时的frame
- (CGRect)getCenterRectInWindow:(UIImage *)image{
    CGSize size = image.size;
    CGSize newSize;
    /// 判断横屏或者竖屏
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if (screenSize.width < screenSize.width) {
        newSize.width = screenSize.width;
        newSize.height = newSize.width / size.width * size.height;
        CGFloat imageY = (screenSize.height - newSize.height) * 0.5;
        if (imageY < 0) {
            imageY = 0;
        }
        CGRect rect =  CGRectMake(0, imageY, newSize.width, newSize.height);
        return rect;
    }else{
        
        newSize.height = screenSize.height;
        newSize.width = newSize.height *size.width/size.height;
        CGFloat imageY = (screenSize.height - newSize.height) * 0.5;
        if (imageY < 0) {
            imageY = 0;
        }
        CGRect rect =  CGRectMake(0, imageY, newSize.width, newSize.height);
        return rect;
    }
    
}

@end
