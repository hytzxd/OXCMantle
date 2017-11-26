//
//  OXDExampleModel.m
//  OXCMantle
//
//  Created by 张旭东 on 2017/11/26.
//  Copyright © 2017年 张旭东. All rights reserved.
//

#import "OXDExampleModel.h"
#import "OXDExampleContentOne.h"
#import "OXDExamleContentThree.h"
#import "OXDExampleContentTwo.h"
@implementation OXDExampleModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *dict = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    [dict setValue:nil forKey:@"managedObj"];
    return dict;
}
//该方法是必须实现的，返回此类对应的 Entity 类别。
+ (NSString *)managedObjectEntityName {
    return @"ExampleModel";
}
//该方法是必须实现的，返回一个字典，用于匹配 model property 和 entity property 的 key，即 model 和 Entity 属性的映射关系。
+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return [self JSONKeyPathsByPropertyKey];
}
+ (NSValueTransformer *)contentJSONTransformer{
  
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[OXDExampleContentOne class]];
}
//类似于 model 和 JSON 之间的转换，该方法用于 model 和 entity 之间的属性值转换。
//+ (NSValueTransformer *)entityAttributeTransformerForKey:(NSString *)key {
//    
//}

@end
