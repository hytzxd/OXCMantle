//
//  OXDPetFishModel.h
//  OXCMantle
//
//  Created by xudongzhang on 2017/11/27.
//  Copyright © 2017年 张旭东. All rights reserved.
//

#import "OXDPetAbstractModel.h"
#import "OXDPetFishFood.h"
@interface OXDPetFishModel : OXDPetAbstractModel
@property (nonatomic ,strong) NSArray <OXDPetFishFood *> *fishFoods;
@property (nonatomic ,copy) NSString *name;
@end
