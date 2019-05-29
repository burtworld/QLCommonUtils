//
//  IBDesignableImageView.h
//  designable
//
//  Created by minggo on 16/5/13.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface IBDesignableView : UIView
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property (retain, nonatomic) IBInspectable UIColor *borderColor;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@end


IB_DESIGNABLE
@interface IBDesignableButton : UIButton
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property (retain, nonatomic) IBInspectable UIColor *borderColor;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@end

IB_DESIGNABLE
@interface IBDesignableTextField : UITextField
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property (retain, nonatomic) IBInspectable UIColor *borderColor;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@end

IB_DESIGNABLE
@interface IBDesignableLab : UILabel
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property (retain, nonatomic) IBInspectable UIColor *borderColor;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@end


IB_DESIGNABLE
@interface IBDesignableImgV : UIImageView
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property (retain, nonatomic) IBInspectable UIColor *borderColor;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@end
