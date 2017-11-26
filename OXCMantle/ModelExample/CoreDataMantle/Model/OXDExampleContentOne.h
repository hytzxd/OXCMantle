//
//  OXDExampleContentOne.h
//  OXCMantle
//
//  Created by 张旭东 on 2017/11/26.
//  Copyright © 2017年 张旭东. All rights reserved.
//

#import "OXModel.h"

@interface OXDExampleContentOne : OXModel
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,strong) NSArray<NSString *> *contents;
@end
