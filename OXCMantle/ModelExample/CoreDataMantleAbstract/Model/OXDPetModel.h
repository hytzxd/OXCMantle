//
//  OXDPetModel.h
//  OXCMantle
//
//  Created by xudongzhang on 2017/11/27.
//  Copyright © 2017年 张旭东. All rights reserved.
//

#import "OXModel.h"
typedef NS_ENUM(NSInteger,OXDPetModelType) {
    OXDExampleContentTypeNone,
    OXDPetModelTypeDog,
    OXDPetModelTypeCat,
    OXDPetModelTypeFish,
};
@interface OXDPetModel : OXModel
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSNumber *type;
@property (nonatomic ,strong) OXModel *petModel;
@end
