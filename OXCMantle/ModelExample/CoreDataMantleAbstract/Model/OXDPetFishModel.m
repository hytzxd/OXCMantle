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
@end
