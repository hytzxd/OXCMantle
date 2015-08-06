//
//  NSString+NSString_ValidationUtils.h
//  OXCMantle
//
//  Created by 张旭东 on 15/8/6.
//  Copyright (c) 2015年 张旭东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ValidationUtils)
+ (NSString *)capitalizeFirstCharacter:(NSString *)string;
+ (NSString *)stripNonNumericCharacters:(NSString *)string;
+ (NSString *)leftPadString:(NSString *)string length:(NSUInteger)length padCharacter:(NSString *)padCharacter;

@end
