
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
    
    OXPropertyType propertyType = [OXValidatorReflection propertypeWithName:key clazz:self.class];
    if (OXPropertyUnknown == propertyType ||OXPropertyTypeArray == propertyType ||  OXPropertyTypeDictionary == propertyType) {
        return nil;
    }
    return [NSValueTransformer ox_mtl_basicClassyTransformerWithBasicClass:NSClassFromString(key)];
}
@end