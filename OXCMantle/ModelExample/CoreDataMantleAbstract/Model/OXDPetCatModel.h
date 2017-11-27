//
//  OXDPetCatModel.h
//  OXCMantle
//
//  Created by xudongzhang on 2017/11/27.
//  Copyright © 2017年 张旭东. All rights reserved.
//

#import "OXDPetAbstractModel.h"

@interface OXDPetCatModel : OXDPetAbstractModel
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,strong) NSArray <NSString *> *nickNames;
@end
