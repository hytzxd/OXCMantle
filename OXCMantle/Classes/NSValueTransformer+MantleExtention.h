//
//  NSValueTransformer+MantleExtention.h
//  Oxen
//
//  Created by Matthew on 6/23/14.
//  Released under the MIT license
//

#import <Foundation/Foundation.h>
#import "OXValidatorReflection.h"

//扩展加入了 系统自己的类
@interface NSValueTransformer (MantleExtention)
+ (NSValueTransformer *)oxc_mtl_JSONArrayTransformerWithBasicClass:(Class)basicClass;
+ (NSValueTransformer *)oxc_mtl_basicClassyTransformerWithBasicType:(OXPropertyType)propertyType;
@end

@interface NSValueTransformer (OXCDiscarded)
+ (NSValueTransformer *)mtl_JSONArrayTransformerWithBasicClass:(Class)basicClass __attribute__((unavailable("oxc_mtl_JSONArrayTransformerWithBasicClass:")));;
@end