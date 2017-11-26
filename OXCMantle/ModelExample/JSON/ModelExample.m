//
//  ModelExample.m
//  OXCen
//
//  Created by 张旭东 on 15/7/25.
//  Copyright (c) 2015年 zhangxudong. All rights reserved.
//

#import "ModelExample.h"
@implementation ModelExample
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    NSMutableDictionary* keys = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary mtl_identityPropertyMapWithModel:self]];
    keys[@"ID"] = @"id";
    return keys;
}
+ (NSValueTransformer *)namesJSONTransformer{
    return [NSValueTransformer oxc_mtl_JSONArrayTransformerWithBasicClass:[NSString class]];
}
+ (NSValueTransformer *)examplesJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[ModelExample class]];
}
+ (NSValueTransformer *)exampleTypeJSONTransformer {
    return  [NSValueTransformer
             mtl_valueMappingTransformerWithDictionary:
                          @{@(ModelExampleTypeEnable):@(ModelExampleTypeEnable),
                            @(ModelExampleTypeDisable):@(ModelExampleTypeDisable)}
                                         defaultValue:@(ModelExampleTypeUnknow)
                                reverseDefaultValue: @(ModelExampleTypeUnknow)];
            

}

- (NSString *)test1{
    return @"1";
}
- (NSString *)test2{
    return @"1";
}
- (NSString *)test3{
    return @"1";
}
- (NSString *)test4{
    return @"1";
}
@end
