//
//  OXDExampleModel.h
//  OXCMantle
//
//  Created by 张旭东 on 2017/11/26.
//  Copyright © 2017年 张旭东. All rights reserved.
//

#import "OXModel.h"
#import "MTLManagedObjectAdapter.h"
#import "ExampleModel+CoreDataProperties.h"
#import "OXDExampleContentOne.h"
typedef NS_ENUM(NSInteger,OXDExampleContentType) {
    OXDExampleContentTypeNone,
    OXDExampleContentTypeOne,
    OXDExampleContentTypeTwo,
    OXDExampleContentTypeThree,
};
@interface OXDExampleModel : OXModel<MTLManagedObjectSerializing>
@property (nonatomic ,copy) NSString *qeustion;
@property (nonatomic ,copy) NSNumber *type;
@property (nonatomic ,strong) OXModel *content;
@property (nonatomic ,strong) ExampleModel *managedObj;
@end
