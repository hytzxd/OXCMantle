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
#import "OXDateTypeValidator.h"
#import "OXStringTypeValidator.h"
#import "OXNumberTypeValidator.h"


@implementation NSValueTransformer (MantleExtention)




+ (NSValueTransformer *)ox_mtl_JSONArrayTransformerWithBasicClass:(Class)basicClass{
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wunused-variable"
   

    
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
            OXBaseValidator *validator = nil;
            if ([basicClass isSubclassOfClass:NSString.class]) {
                validator = [OXStringTypeValidator new];
            } else if ([basicClass isSubclassOfClass:NSDate.class]){
                validator = [OXDateTypeValidator new];
            } else if ([basicClass isSubclassOfClass:NSNumber.class]){
                validator = [OXNumberTypeValidator new];
            }
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


+ (NSValueTransformer *)ox_mtl_basicClassyTransformerWithBasicClass:(Class)basicClass{
    return  [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error){
        if (value == nil) return nil;
        OXBaseValidator *validator = nil;
        if ([basicClass isSubclassOfClass:NSString.class]) {
            validator = [OXStringTypeValidator new];
        } else if ([basicClass isSubclassOfClass:NSDate.class]){
            validator = [OXDateTypeValidator new];
        } else if ([basicClass isSubclassOfClass:NSNumber.class]){
            validator = [OXNumberTypeValidator new];
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
