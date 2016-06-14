//
//  OXValidatorReflection.h
//  OXCMantle
//
//  Created by 张旭东 on 16/6/11.
//  Copyright © 2016年 张旭东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OXBaseValidator.h"
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
+ (OXPropertyType)oxc_propertypeWithName:(NSString *)propertyName clazz:(Class)clazz;
+ (OXBaseValidator *)oxc_validatorForPropertyType:(OXPropertyType)propertyType;
+ (OXPropertyType)oxc_propertyTypeForBasicClassStr:(NSString *)clazzStr;
@end
