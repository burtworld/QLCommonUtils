//
//  UIColor+QLColor.m
//  QLCommonUtils
//
//  Created by Paramita on 2018/2/1.
//  Copyright © 2018年 Paramita. All rights reserved.
//

#import "UIColor+QLColor.h"
#import "NSData+QLHEX.h"

@implementation UIColor (QLColor)
+ (UIColor *)colorFormString:(NSString *)hexString {
    //    unsigned long red = strtoul([colorString UTF8String],0,16);
    //strtoul如果传入的字符开头是“0x”,那么第三个参数是0，也是会转为十六进制的,这样写也可以：
    if (hexString.length) {
        if ([hexString containsString:@"#"]) {
            hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
        }
        unsigned long value = strtoul([hexString UTF8String],0,0);
        return [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 \
                               green:((float)((value & 0xFF00) >> 8))/255.0 \
                                blue:((float)(value & 0xFF))/255.0 alpha:1.0];
    }
    return nil;
}
+ (UIColor *)randomColorWithName:(NSString *)name {
    if (name.length) {
        NSData *data = [name dataUsingEncoding:NSUTF8StringEncoding];
        NSData *subData = [data subdataWithRange:NSMakeRange(data.length - 1, 1)];
        NSString * subStr = [subData hexString];
        unsigned long random = strtoul([subStr UTF8String],0,16);
        random = random%16;
        NSArray * arrColor= @[
                              COLOR_OF_HEX(0xf2725e), COLOR_OF_HEX(0xb08677),  COLOR_OF_HEX(0x4f819f),
                              COLOR_OF_HEX(0xf6b45e), COLOR_OF_HEX(0x4da9eb),  COLOR_OF_HEX(0xe66c59),
                              COLOR_OF_HEX(0x5589a9), COLOR_OF_HEX(0x16c295), COLOR_OF_HEX(0xf7b55e), COLOR_OF_HEX(0xb38979),
                              COLOR_OF_HEX(0xf2725e), COLOR_OF_HEX(0xb08677),  COLOR_OF_HEX(0x4f819f),
                              COLOR_OF_HEX(0xEE9A49),  COLOR_OF_HEX(0xFF69B4),
                              ];
        return arrColor[random];
    }else{
        return COLOR_OF_HEX(0x5cb0f5);
    }
}

+ (UIColor *)randomColor {
    CGFloat red = (arc4random()%255)/255.0;
    CGFloat green = (arc4random()%255)/255.0;
    CGFloat blue = (arc4random()%255)/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end
