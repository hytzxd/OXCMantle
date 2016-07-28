//
//  NSValueTransformer+MantleExtention.m
//  Oxen
//
//  Created by Matthew on 6/23/14.
//  Released under the MIT license
//

#import "NSValueTransformer+MantleExtention.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "MTLJSONAdapter.h"
#import "MTLModel.h"
#import "MTLValueTransformer.h"
#import "OXStringTypeValidator.h"

@implementation NSValueTransformer (MantleExtention)

+ (NSValueTransformer *)oxc_mtl_JSONArrayTransformerWithBasicClass:(Class)basicClass{
   return  [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error){
        NSArray *dictionaries = value;
        if (dictionaries == nil) return nil;
        
        NSAssert([dictionaries isKindOfClass:NSArray.class], @"Expected a array of object, got: %@", dictionaries);
        
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictionaries.count];
        for (id JSONObject in dictionaries) {
            if (JSONObject == NSNull.null) {
                [models addObject:NSNull.null];
                continue;
            }
            if (value == nil) return nil;
            OXPropertyType propertyType = [OXValidatorReflection oxc_propertyTypeForBasicClassStr:NSStringFromClass(basicClass)];
            NSAssert(OXPropertyUnknown != propertyType, @"只接受基本的数据类型 OXPropertyType 中包含的类型");
            if (OXPropertyUnknown == propertyType) {
                continue;
            }
            OXBaseValidator *validator = [OXValidatorReflection oxc_validatorForPropertyType:propertyType];
            NSError* err;
            id model = JSONObject;
            [validator validateValue:&model error:&err];
            [models addObject:model];
        }
        
        return models;
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
         NSArray *models = value;
        if (models == nil) return nil;
        
        NSAssert([models isKindOfClass:NSArray.class], @"Expected a array of object, got: %@", models);
        
        NSMutableArray *dictionaries = [NSMutableArray arrayWithCapacity:models.count];
        for (id model in models) {
            if (model == NSNull.null) {
                [dictionaries addObject:NSNull.null];
                continue;
            }
            [dictionaries addObject:[model description]];
        }
        
        return dictionaries;
    }];
}


+ (NSValueTransformer *)oxc_mtl_basicClassyTransformerWithBasicType:(OXPropertyType)propertyType{
    return  [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error){
//        if (value == nil) return nil;
        OXBaseValidator *validator = [OXValidatorReflection oxc_validatorForPropertyType:propertyType];
        if (!validator) {
            return nil;
        }
        NSError* err;
        id model = value;
        [validator validateValue:&model error:&err];
        return model;
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
       
        if (value == nil) return nil;
        OXBaseValidator  *validator = [OXStringTypeValidator new];
        id model = value;
        [validator validateValue:&model error:nil];
        return [model description];
    }];
    
}


@end


@implementation NSValueTransformer (OXCDiscarded)

+ (NSValueTransformer *)mtl_JSONArrayTransformerWithBasicClass:(Class)basicClass{
    return [self oxc_mtl_JSONArrayTransformerWithBasicClass:basicClass];
}

@end