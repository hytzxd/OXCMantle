//
//  OXDValidationFunctions.h
//  OXCMantle
//
//  Created by 张旭东 on 16/7/28.
//  Copyright © 2016年 张旭东. All rights reserved.
//

#ifndef OXDValidationFunctions_h
#define OXDValidationFunctions_h
#import <Foundation/Foundation.h>

BOOL oxd_validateStringProperty(id *ioValue, NSError *__autoreleasing* outError);

BOOL oxd_validateBoolProperty(id *ioValue, NSError *__autoreleasing* outError);

BOOL oxd_validateNumberProperty(id *ioValue, NSError *__autoreleasing* outError);

BOOL oxd_validateIntegerProperty(id *ioValue, NSError *__autoreleasing* outError);

BOOL oxd_validateUnsignedLongProperty(id *ioValue, NSError *__autoreleasing* outError);

BOOL oxd_validateLongProperty(id *ioValue, NSError *__autoreleasing* outError);

BOOL oxd_validateFloatProperty(id *ioValue, NSError *__autoreleasing* outError);

BOOL oxd_validateArrayProperty(id *ioValue, NSError *__autoreleasing* outError);

BOOL oxd_validateDictionaryProperty(id *ioValue, NSError *__autoreleasing* outError);

BOOL oxd_validateUnsignedIntegerProperty(id *ioValue, NSError *__autoreleasing* outError);

BOOL oxd_validateDoubleProperty(id *ioValue, NSError *__autoreleasing* outError);

BOOL oxd_validateDateProperty(id *ioValue, NSError *__autoreleasing* outError);


#endif /* OXDValidationFunctions_h */
