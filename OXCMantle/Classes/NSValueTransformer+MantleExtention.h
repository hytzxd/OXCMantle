//
//  NSValueTransformer+MantleExtention.h
//  Oxen
//
//  Created by Matthew on 6/23/14.
//  Released under the MIT license
//

#import <Foundation/Foundation.h>
//扩展加入了 系统自己的类
@interface NSValueTransformer (MantleExtention)
+ (NSValueTransformer *)mtl_JSONArrayTransformerWithBasicClass:(Class)basicClass;
@end
