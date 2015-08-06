//
// OXValidationFuntions.h
// Oxen
//
// Created by Matthew on 6/16/14.
// Released under the MIT license
//

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