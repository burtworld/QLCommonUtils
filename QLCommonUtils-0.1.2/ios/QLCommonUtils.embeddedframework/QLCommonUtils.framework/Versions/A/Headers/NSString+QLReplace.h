//
//  NSString+Replace.h
//  YRCollaborativeOA
//
//  Created by Paramita on 2016/12/1.
//  Copyright © 2016年 Paramita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLHJDataModel.h"

@interface NSString (QLReplace)

- (NSString *)foundSymbol:(NSString *)symbol replace:(QLHJDataModel *)replaceItem;
- (NSString *)foundSymbol:(NSString *)symbol replaceWithUrlItem:(QLHJDataModel *)urlItem otherItem:(QLHJDataModel *)oterhItem;
- (NSString *)foundSymbol:(NSString *)symbol replaceWithUrlItem:(NSDictionary *)dic;
- (NSMutableDictionary *)configUrl;
- (NSString *)addFromApp;

- (NSString *)flattenHTML;



@end
