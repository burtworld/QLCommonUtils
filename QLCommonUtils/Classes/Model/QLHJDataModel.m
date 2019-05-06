//
//  DataModel.m
//  CampusExchange
//
//  Created by 窗外` on 15/6/28.
//
//

#import "QLHJDataModel.h"
#import <objc/runtime.h>
#import "NSString+QLReplace.h"



@implementation NSObject (ObjectCatagory)

- (NSArray *)propertyKeys
{
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    NSMutableArray *keys = [NSMutableArray array];
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    
    free(properties);
    return keys;
}
//! 将Model转换为字典
- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    for (NSString *key in [self propertyKeys]) {
        id propertyValue = [self valueForKey:key];
        propertyValue = propertyValue ? propertyValue : @"";
        
        if ([propertyValue isKindOfClass:[QLHJDataModel class]]) {
            QLHJDataModel *model = (QLHJDataModel *)propertyValue;
            propertyValue = [model toDictionary];
        }
        else if ([propertyValue isKindOfClass:[NSArray class]]) {
            NSMutableArray *ary = [NSMutableArray array];
            for (id item in propertyValue) {
                if ([item isKindOfClass:[QLHJDataModel class]]) {
                    QLHJDataModel *model = (QLHJDataModel *)item;
                    [ary addObject:[model toDictionary]];
                }else{
                    [ary addObject:item];
                }
            }
            propertyValue = ary;
        }
        
        [dic setValue:propertyValue forKey:key];
    }
    
    return dic;
}




@end

@implementation NSString (Propertys)

- (BOOL)isPropertyOfClass:(Class)cls {
    BOOL is = NO;
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if ([self isEqualToString:propertyName]) {
            is = YES;
            break;
        }
    }
    free(properties);
    return is;
}

@end

#pragma mark model基类
@interface QLHJDataModel ()
@property (retain, nonatomic) NSDictionary *arrayClassNameDic;
@end

@implementation QLHJDataModel

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]])
            [self reflectDataFromOtherObject:data];
    }
    return self;
}

- (id)initWithData:(NSDictionary *)data arrayClassName:(NSDictionary *)arrayClassNameDic
{
    self = [super init];
    if (self) {
        self.arrayClassNameDic = arrayClassNameDic;
        if ([data isKindOfClass:[NSDictionary class]])
            [self reflectDataFromOtherObject:data];
    }
    return self;
}

- (void)initializePropety:(NSDictionary *)data {
    if ([data isKindOfClass:[NSDictionary class]])
        [self reflectDataFromOtherObject:data];
}

- (BOOL)reflectDataFromOtherObject:(NSDictionary *)dic
{
    self.orgDic = dic;
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);

    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString *propertyType = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];

        if ([[dic allKeys] containsObject:propertyName]) {
            id value = [dic valueForKey:propertyName];
            if (![value isKindOfClass:[NSNull class]] && value != nil) {
                if ([value isKindOfClass:[NSDictionary class]]) {
                    id pro = [self createInstanceByClassName:[self getClassName:propertyType]];
                    [pro reflectDataFromOtherObject:value];
                    [self setValue:pro forKey:propertyName];
                    
                }
                else if ([value isKindOfClass:[NSArray class]]) {
                    NSMutableArray *ary = [NSMutableArray array];
                    for (id obj in value) {
                        if ([obj isKindOfClass:[NSDictionary class]] && self.arrayClassNameDic) {
                            NSString * className = self.arrayClassNameDic[propertyName];
                            if (className) {
                                QLHJDataModel* pro = [self createInstanceByClassName:className];
                                pro.arrayClassNameDic = self.arrayClassNameDic;
                                [pro reflectDataFromOtherObject:obj];
                                [ary addObject:pro];
                            }else{
                                [ary addObject:obj];
                            }
                        }else{
                            [ary addObject:obj];
                        }
                    }
                    [self setValue:ary forKey:propertyName];
                }
                else {
                    [self setValue:value forKey:propertyName];
                }
            }
        }
    }

    free(properties);
    return true;
}



- (NSString *)getClassName:(NSString *)attributes
{
    NSString *type = [attributes substringFromIndex:[attributes rangeOfString:@"\""].location + 1];
    type = [type substringToIndex:[type rangeOfString:@"\""].location];
    return type;
}

- (id)createInstanceByClassName:(NSString *)className {
    
//    NSBundle *bundle = [NSBundle mainBundle];
//
//    Class aClass = [bundle classNamed:className];
//    id anInstance = [[aClass alloc] init];
    if (NSClassFromString(className)!= nil) {
        id anInstance = [[NSClassFromString(className) alloc] init];
        return anInstance;
    }
    return nil;
}

- (id)createInstanceByClassName:(NSString *)className value:(NSDictionary *)value{
    NSBundle *bundle = [NSBundle mainBundle];
    Class aClass = [bundle classNamed:className];
    id anInstance = [[aClass alloc] init];
    return anInstance;
}

//- (NSString *)description
//{
//    NSString *className = [[NSString alloc] initWithUTF8String:object_getClassName([self class])];
//    NSDictionary *dic = [self toDictionary];
//    NSString *description = [NSString stringWithFormat:@"%@  %@", className, [NSString logDic:dic]];
//    return description;
//}

- (NSString *)description {
    NSString *className = [[NSString alloc] initWithUTF8String:object_getClassName([self class])];
    NSDictionary *dic = [self toDictionary];
    NSString * str = [dic description];
    
    NSString *description = [NSString stringWithFormat:@"\n*******************************\n%@:  %@\n*******************************\n", className, str ? str : dic];
    return description;
}

@end









