//
//  OXDPetModel.h
//  OXCMantle
//
//  Created by xudongzhang on 2017/11/27.
//  Copyright © 2017年 张旭东. All rights reserved.
//

#import "OXModel.h"
#import "MTLManagedObjectAdapter.h"
#import "PetModel+CoreDataProperties.h"
#import "OXDPetAbstractModel.h"

@interface OXDPetModel : OXModel<MTLManagedObjectSerializing>
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,strong) OXDPetAbstractModel *petModel;
@property (nonatomic ,strong) PetModel *managedObj;
@end
