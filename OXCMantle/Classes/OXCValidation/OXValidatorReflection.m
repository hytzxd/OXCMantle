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
//    OXBaseValidator *validator = nil;
//    switch (propertyType){
//        case OXPropertyTypeString:
//            validator = [OXStringTypeValidator new];
//            break;
//        case OXPropertyTypeBool:
//            validator = [OXBooleanTypeValidator new];;
//            break;
//        case OXPropertyTypeNumber:
//            validator = [OXNumberTypeValidator new];
//            break;
//        case OXPropertyTypeInteger:
//            validator = [OXIntegerTypeValidator new];
//            break;
//        case OXPropertyTypeFloat:
//            validator = [OXFloatTypeValidator new];
//            break;
//        case OXPropertyTypeArray:
//        case OXPropertyTypeMutableArray:
//            validator = [OXArrayTypeValidator new];
//            break;
//        case OXPropertyTypeDictionary:
//        case OXPropertyTypeMutableDictionary:
//            validator = [OXDictionaryTypeValidator new];
//            break;
//        case OXPropertyTypeUnsignedInteger:
//            validator = [OXUnsignedIntegerTypeValidator new];
//            break;
//        case OXPropertyTypeDate:
//            validator =[OXDateTypeValidator new];
//            break;
//        case OXPropertyTypeDouble:
//            validator = [OXDoubleTypeValidator new];
//            break;
//        case OXPropertyTypeLong:
//            validator = [OXLongTypeValidator new];
//            break;
//        case OXPropertyTypeUnsignedLong:
//            validator = [OXUnsignedLongTypeValicdator new];
//            break;
//        default:
//            break;
//    }
//    return validator;
}


//
//
//+ (void)oxc_addValidatorForProperty:(NSString *)propertyName type:(OXPropertyType)propertyType clazz:(Class)clazz{
//    IMP implementation;
//    switch (propertyType){
//        case OXPropertyTypeString:
//            implementation = (IMP)validateStringProperty;
//            break;
//        case OXPropertyTypeBool:
//            implementation = (IMP)validateBoolProperty;
//            break;
//        case OXPropertyTypeNumber:
//            implementation = (IMP)validateNumberProperty;
//            break;
//        case OXPropertyTypeInteger:
//            implementation = (IMP)validateIntegerProperty;
//            break;
//        case OXPropertyTypeFloat:
//            implementation = (IMP)validateFloatProperty;
//            break;
//        case OXPropertyTypeArray:
//        case OXPropertyTypeMutableArray:
//            implementation = (IMP)validateArrayProperty;
//            break;
//        case OXPropertyTypeDictionary:
//        case OXPropertyTypeMutableDictionary:
//            implementation = (IMP)validateDictionaryProperty;
//            break;
//        case OXPropertyTypeUnsignedInteger:
//            implementation = (IMP)validateUnsignedIntegerProperty;
//            break;
//        case OXPropertyTypeDate:
//            implementation = (IMP)validateDateProperty;
//            break;
//        case OXPropertyTypeDouble:
//            implementation = (IMP)validateDoubleProperty;
//            break;
//        case OXPropertyTypeLong:
//            implementation = (IMP)validateLongProperty;
//            break;
//        case OXPropertyTypeUnsignedLong:
//            implementation = (IMP)validateUnsignedLongProperty;
//            break;
//        default:
//            implementation = nil;
//            break;
//    }
//    if (implementation){
//        NSString *methodName = [self oxc_generateValidationMethodName:propertyName];
//        class_addMethod(clazz, NSSelectorFromString(methodName), implementation, "c@:^@^@");
//    }
//}
//
//+(NSString *)oxc_generateValidationMethodName:(NSString *)key{
//    return [NSString stringWithFormat:@"validate%@:error:", [NSString capitalizeFirstCharacter:key]];
//}

@end
