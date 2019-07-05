//
//  DataModel.h
//  CampusExchange
//
//  Created by 窗外` on 15/6/28.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSObject+QLDescription.h"
#import <objc/runtime.h>

@interface NSObject (ObjectCatagory)
- (NSDictionary *)toDictionary;
@end

@interface NSString (Propertys)
- (BOOL)isPropertyOfClass:(Class)cls;
@end

#pragma mark - BaseModel
@interface QLHJDataModel : NSObject
@property (retain, nonatomic) NSDictionary * orgDic;
- (id)initWithData:(NSDictionary *)data;
- (id)initWithData:(NSDictionary *)data arrayClassName:(NSDictionary *)arrayClassNameDic;
- (void)initializePropety:(NSDictionary *)data;
@end


