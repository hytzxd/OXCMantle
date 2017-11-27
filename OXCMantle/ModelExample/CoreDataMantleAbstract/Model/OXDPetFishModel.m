//
//  OXDPetFishModel.m
//  OXCMantle
//
//  Created by xudongzhang on 2017/11/27.
//  Copyright © 2017年 张旭东. All rights reserved.
//

#import "OXDPetFishModel.h"

@implementation OXDPetFishModel

+ (NSValueTransformer *)fishFoodsJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[OXDPetFishFood class]];
}

//该方法是必须实现的，返回此类对应的 Entity 类别。
+ (NSString *)managedObjectEntityName {
    return @"PetFishModel";
}
//该方法是必须实现的，返回一个字典，用于匹配 model property 和 entity property 的 key，即 model 和 Entity 属性的映射关系。
+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return [self JSONKeyPathsByPropertyKey];
}
//当 Entity 具有relationship的属性时，可以用该方法来进行匹配
+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
             @"fishFoods"  : [OXDPetFishFood class],
             };
}
@end
