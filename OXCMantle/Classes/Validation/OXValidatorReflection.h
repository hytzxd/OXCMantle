//
//  OXValidatorReflection.h
//  OXCMantle
//
//  Created by 张旭东 on 16/6/11.
//  Copyright © 2016年 张旭东. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, OXPropertyType){
    OXPropertyUnknown = 0,
    OXPropertyTypeString,
    OXPropertyTypeBool,
    OXPropertyTypeNumber,
    OXPropertyTypeInteger,
    OXPropertyTypeFloat,
    OXPropertyTypeArray,
    OXPropertyTypeMutableArray,
    OXPropertyTypeDictionary,
    OXPropertyTypeMutableDictionary,
    OXPropertyTypeUnsignedInteger,
    OXPropertyTypeDate,
    OXPropertyTypeDouble,
    OXPropertyTypeLong,
    OXPropertyTypeUnsignedLong,
};


@interface OXValidatorReflection : NSObject
+ (OXPropertyType)propertypeWithName:(NSString *)propertyName clazz:(Class)clazz;
@end
