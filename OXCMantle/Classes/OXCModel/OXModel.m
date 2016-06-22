
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
#import "NSDictionary+MTLMappingAdditions.h"
@implementation OXModel
#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return  [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer*)JSONTransformerForKey:(NSString*)key{
    OXPropertyType propertyType = [OXValidatorReflection oxc_propertypeWithName:key clazz:self.class];
    return [NSValueTransformer oxc_mtl_basicClassyTransformerWithBasicType:propertyType];
}
@end