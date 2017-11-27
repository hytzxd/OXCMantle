//
//  OXDPetCatModel.m
//  OXCMantle
//
//  Created by xudongzhang on 2017/11/27.
//  Copyright © 2017年 张旭东. All rights reserved.
//

#import "OXDPetCatModel.h"

@implementation OXDPetCatModel
+ (NSValueTransformer *)nickNamesJSONTransformer{
    return [NSValueTransformer oxc_mtl_JSONArrayTransformerWithBasicClass:[NSString class]];
}
@end
