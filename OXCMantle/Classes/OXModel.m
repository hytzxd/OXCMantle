
//
//  OXModel.m
//  Oxen
//
//  Created by Matthew on 6/16/14.
//  Released under the MIT license
//

#import "OXModel.h"
#import "OXValidatorReflection.h"
#import "NSValueTransformer+MantleExtention.h"
@implementation OXModel
#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    NSMutableDictionary *keys = [[NSMutableDictionary alloc]initWithCapacity:[[self propertyKeys]count]];
    for (NSString *propertyKey in  [self propertyKeys]) {
        keys[propertyKey] = propertyKey;
    }
    return keys ;
}

+ (NSValueTransformer*)JSONTransformerForKey:(NSString*)key{
    OXPropertyType propertyType = [OXValidatorReflection oxc_propertypeWithName:key clazz:self.class];
    return [NSValueTransformer oxc_mtl_basicClassyTransformerWithBasicType:propertyType];
}
@end