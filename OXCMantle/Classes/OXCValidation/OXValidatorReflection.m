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

#import "OXStringTypeValidator.h"
#import "OXBooleanTypeValidator.h"
#import "OXIntegerTypeValidator.h"
#import "OXFloatTypeValidator.h"
#import "OXArrayTypeValidator.h"
#import "OXDictionaryTypeValidator.h"
#import "OXUnsignedIntegerTypeValidator.h"
#import "OXDoubleTypeValidator.h"
#import "OXDateTypeValidator.h"
#import "OXLongTypeValidator.h"
#import "OXUnsignedLongTypeValicdator.h"

BOOL validateStringProperty(id self, SEL _cmd, id *ioValue, NSError *__autoreleasing* outError){
    OXStringTypeValidator *validator = [OXStringTypeValidator new];
    
    return [validator validateValue:ioValue error:outError];
}

BOOL validateBoolProperty(id self, SEL _cmd, id *ioValue, NSError *__autoreleasing* outError){
    OXBooleanTypeValidator *validator = [OXBooleanTypeValidator new];
    
    return [validator validateValue:ioValue error:outError];
}

BOOL validateNumberProperty(id self, SEL _cmd, id *ioValue, NSError *__autoreleasing* outError){
    OXNumberTypeValidator *validator = [OXNumberTypeValidator new];
    
    return [validator validateValue:ioValue error:outError];
}

BOOL validateIntegerProperty(id self, SEL _cmd, id *ioValue, NSError *__autoreleasing* outError){
    OXIntegerTypeValidator *validator = [OXIntegerTypeValidator new];
    
    return [validator validateValue:ioValue error:outError];
}

BOOL validateUnsignedLongProperty(id self, SEL _cmd, id *ioValue, NSError *__autoreleasing* outError){
    OXUnsignedLongTypeValicdator *validator = [OXUnsignedLongTypeValicdator new];
    
    return [validator validateValue:ioValue error:outError];
}

BOOL validateLongProperty(id self, SEL _cmd, id *ioValue, NSError *__autoreleasing* outError){
    OXLongTypeValidator *validator = [OXLongTypeValidator new];
    
    return [validator validateValue:ioValue error:outError];
}

BOOL validateFloatProperty(id self, SEL _cmd, id *ioValue, NSError *__autoreleasing* outError){
    OXFloatTypeValidator *validator = [OXFloatTypeValidator new];
    
    return [validator validateValue:ioValue error:outError];
}

BOOL validateArrayProperty(id self, SEL _cmd, id *ioValue, NSError *__autoreleasing* outError){
    OXArrayTypeValidator *validator = [OXArrayTypeValidator new];
    
    return [validator validateValue:ioValue error:outError];
}

BOOL validateDictionaryProperty(id self, SEL _cmd, id *ioValue, NSError *__autoreleasing* outError){
    OXDictionaryTypeValidator *validator = [OXDictionaryTypeValidator new];
    
    return [validator validateValue:ioValue error:outError];
}

BOOL validateUnsignedIntegerProperty(id self, SEL _cmd, id *ioValue, NSError *__autoreleasing* outError){
    OXUnsignedIntegerTypeValidator *validator = [OXUnsignedIntegerTypeValidator new];
    
    return [validator validateValue:ioValue error:outError];
}

BOOL validateDoubleProperty(id self, SEL _cmd, id *ioValue, NSError *__autoreleasing* outError){
    OXDoubleTypeValidator *validator = [OXDoubleTypeValidator new];
    
    return [validator validateValue:ioValue error:outError];
}

BOOL validateDateProperty(id self, SEL _cmd, id *ioValue, NSError *__autoreleasing* outError){
    OXDateTypeValidator *validator = [OXDateTypeValidator new];
    
    return [validator validateValue:ioValue error:outError];
}





@implementation OXValidatorReflection
+ (OXPropertyType)oxc_propertypeWithName:(NSString *)propertyName clazz:(Class)clazz{
    objc_property_t property = class_getProperty(clazz, propertyName.UTF8String);
    if (property == NULL){
        return OXPropertyUnknown;
    }
    OX_mtl_propertyAttributes *attributes = mtl_copyPropertyAttributes(property);
    NSString *classStr = NSStringFromClass(attributes->objectClass);
    
    if (0 == classStr.length) {
       classStr = [NSString stringWithUTF8String:attributes->type];
    }
    free(attributes);
    OXPropertyType type = [self oxc_propertyTypeForBasicClassStr:classStr];;
    return type;
}

+ (OXPropertyType)oxc_propertyTypeForBasicClassStr:(NSString *)clazzStr{
    OXPropertyType typeVlaue = [[[self oxc_oxpropertyTypeDict] objectForKey:clazzStr] integerValue];
    return typeVlaue;
}

+ (NSDictionary <NSString *, NSNumber *>  *)oxc_oxpropertyTypeDict{
    static  NSDictionary <NSString *, NSNumber *> *propertyTypesDict = nil;
    if (0 == propertyTypesDict.allKeys.count) {
        propertyTypesDict = @{@"Unknown" : @(OXPropertyUnknown),
                               NSStringFromClass([NSString class]) : @(OXPropertyTypeString),
                               [NSString stringWithFormat:@"%s",@encode(BOOL)] : @(OXPropertyTypeBool),
                               NSStringFromClass([NSNumber class]): @(OXPropertyTypeNumber),
                               [NSString stringWithFormat:@"%s",@encode(int)] : @(OXPropertyTypeInteger),
                               [NSString stringWithFormat:@"%s",@encode(float)] : @(OXPropertyTypeFloat),
                               NSStringFromClass([NSArray class]) : @(OXPropertyTypeArray),
                               NSStringFromClass([NSMutableArray class]) : @(OXPropertyTypeMutableArray),
                               NSStringFromClass([NSDictionary class]) : @(OXPropertyTypeDictionary),
                               NSStringFromClass([NSMutableDictionary class]) : @(OXPropertyTypeMutableDictionary),
                               [NSString stringWithFormat:@"%s",@encode(unsigned int)] : @(OXPropertyTypeUnsignedInteger),
                               NSStringFromClass([NSDate class]) : @(OXPropertyTypeDate),
                               [NSString stringWithFormat:@"%s",@encode(double)] : @(OXPropertyTypeDouble),
                               [NSString stringWithFormat:@"%s",@encode(long)] : @(OXPropertyTypeLong),
                               [NSString stringWithFormat:@"%s",@encode(unsigned long)] : @(OXPropertyTypeUnsignedLong),
                              };

    }
    return propertyTypesDict;
}

+ (OXBaseValidator *)oxc_validatorForPropertyType:(OXPropertyType)propertyType{
    static NSDictionary <NSString *,OXBaseValidator *> *validatorDict = nil;
    if (validatorDict.allKeys.count == 0) {
        validatorDict = @{
                          [NSString stringWithFormat:@"%lu",(unsigned long)OXPropertyTypeString]:               [OXStringTypeValidator new],
                          [NSString stringWithFormat:@"%lu",(unsigned long)OXPropertyTypeBool]:                 [OXStringTypeValidator new],
                          [NSString stringWithFormat:@"%lu",(unsigned long)OXPropertyTypeNumber]:               [OXNumberTypeValidator new],
                          [NSString stringWithFormat:@"%lu",(unsigned long)OXPropertyTypeInteger]:              [OXIntegerTypeValidator new],
                          [NSString stringWithFormat:@"%lu",(unsigned long)OXPropertyTypeFloat]:                [OXFloatTypeValidator new],
                          [NSString stringWithFormat:@"%lu",(unsigned long)OXPropertyTypeArray]:                [OXArrayTypeValidator new],
                          [NSString stringWithFormat:@"%lu",(unsigned long)OXPropertyTypeMutableArray]:         [OXArrayTypeValidator new],
                          [NSString stringWithFormat:@"%lu",(unsigned long)OXPropertyTypeDictionary]:           [OXDictionaryTypeValidator new],
                          [NSString stringWithFormat:@"%lu",(unsigned long)OXPropertyTypeMutableDictionary]:    [OXDictionaryTypeValidator new],
                          [NSString stringWithFormat:@"%lu",(unsigned long)OXPropertyTypeUnsignedInteger]:      [OXUnsignedIntegerTypeValidator new],
                          [NSString stringWithFormat:@"%lu",(unsigned long)OXPropertyTypeDate]:                 [OXDateTypeValidator new],
                          [NSString stringWithFormat:@"%lu",(unsigned long)OXPropertyTypeDouble]:               [OXDoubleTypeValidator new],
                          [NSString stringWithFormat:@"%lu",(unsigned long)OXPropertyTypeLong]:                 [OXLongTypeValidator new],
                          [NSString stringWithFormat:@"%lu",(unsigned long)OXPropertyTypeUnsignedLong]:         [OXUnsignedLongTypeValicdator new]
                          };
    }
    return validatorDict[[NSString stringWithFormat:@"%lu",(unsigned long)propertyType]];
}

@end
