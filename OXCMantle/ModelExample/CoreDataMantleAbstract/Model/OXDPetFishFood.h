//
//  OXDPetFishFood.h
//  OXCMantle
//
//  Created by xudongzhang on 2017/11/27.
//  Copyright © 2017年 张旭东. All rights reserved.
//

#import "OXModel.h"
#import "MTLManagedObjectAdapter.h"
@interface OXDPetFishFood : OXModel<MTLManagedObjectSerializing>
@property (nonatomic ,copy) NSString *name;
@end
