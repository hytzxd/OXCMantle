//
//  OXValidatorReflection.m
//  OXCMantle
//
//  Created by 张旭东 on 16/6/11.
//  Copyright © 2016年 张旭东. All rights reserved.
//

#import "OXValidatorReflection.h"
#import "OXEXTRuntimeExtensions.h"
#import "OXValidationFunctions.h"
#import "NSString+ValidationUtils.h"
#import <objc/runtime.h>
@implementation OXValidatorReflection
+ (OXPropertyType)propertypeWithName:(NSString *)propertyName clazz:(Class)clazz{
    objc_property_t property = class_getProperty(clazz, propertyName.UTF8String);
    if (property == NULL){
        return OXPropertyUnknown;
    }
    OX_mtl_propertyAttributes *attributes = mtl_copyPropertyAttributes(property);
    NSString *classStr = NSStringFromClass(attributes->objectClass);
    free(attributes);
    NSNumber *typeVlaue = [[self oxpropertyTypeDict] objectForKey:classStr];
    OXPropertyType type = [typeVlaue integerValue];
    return type;
}

+ (NSDictionary <NSString *, NSNumber *>  *)oxpropertyTypeDict{
    static  NSDictionary <NSString *, NSNumber *> *propertyTypesDict = nil;
    if (0 == propertyTypesDict.allKeys.count) {
        propertyTypesDict = @{@"Unknown" : @(OXPropertyUnknown),
                               @"NSString" : @(OXPropertyTypeString),
                               [NSString stringWithFormat:@"%s",@encode(BOOL)] : @(OXPropertyTypeBool),
                               @"NSNumber" : @(OXPropertyTypeNumber),
                               [NSString stringWithFormat:@"%s",@encode(int)] : @(OXPropertyTypeInteger),
                               [NSString stringWithFormat:@"%s",@encode(float)] : @(OXPropertyTypeFloat),
                               @"NSArray" : @(OXPropertyTypeArray),
                               @"NSMutableArray" : @(OXPropertyTypeMutableArray),
                               @"NSDictionary" : @(OXPropertyTypeDictionary),
                               @"NSMutableDictionary" : @(OXPropertyTypeMutableDictionary),
                               [NSString stringWithFormat:@"%s",@encode(unsigned int)] : @(OXPropertyTypeUnsignedInteger),
                               @"NSDate" : @(OXPropertyTypeDate),
                               [NSString stringWithFormat:@"%s",@encode(double)] : @(OXPropertyTypeDouble),
                               [NSString stringWithFormat:@"%s",@encode(long)] : @(OXPropertyTypeLong),
                               [NSString stringWithFormat:@"%s",@encode(unsigned long)] : @(OXPropertyTypeUnsignedLong),
                              };

    }
    return propertyTypesDict;
}


+ (void)addValidatorForProperty:(NSString *)propertyName type:(OXPropertyType)propertyType clazz:(Class)clazz{
    IMP implementation;
    switch (propertyType){
        case OXPropertyTypeString:
            implementation = (IMP)validateStringProperty;
            break;
        case OXPropertyTypeBool:
            implementation = (IMP)validateBoolProperty;
            break;
        case OXPropertyTypeNumber:
            implementation = (IMP)validateNumberProperty;
            break;
        case OXPropertyTypeInteger:
            implementation = (IMP)validateIntegerProperty;
            break;
        case OXPropertyTypeFloat:
            implementation = (IMP)validateFloatProperty;
            break;
        case OXPropertyTypeArray:
        case OXPropertyTypeMutableArray:
            implementation = (IMP)validateArrayProperty;
            break;
        case OXPropertyTypeDictionary:
        case OXPropertyTypeMutableDictionary:
            implementation = (IMP)validateDictionaryProperty;
            break;
        case OXPropertyTypeUnsignedInteger:
            implementation = (IMP)validateUnsignedIntegerProperty;
            break;
        case OXPropertyTypeDate:
            implementation = (IMP)validateDateProperty;
            break;
        case OXPropertyTypeDouble:
            implementation = (IMP)validateDoubleProperty;
            break;
        case OXPropertyTypeLong:
            implementation = (IMP)validateLongProperty;
            break;
        case OXPropertyTypeUnsignedLong:
            implementation = (IMP)validateUnsignedLongProperty;
            break;
        default:
            implementation = nil;
            break;
    }
    if (implementation){
        NSString *methodName = [self generateValidationMethodName:propertyName];
        class_addMethod(clazz, NSSelectorFromString(methodName), implementation, "c@:^@^@");
    }
}

+(NSString *)generateValidationMethodName:(NSString *)key{
    return [NSString stringWithFormat:@"validate%@:error:", [NSString capitalizeFirstCharacter:key]];
}



@end
