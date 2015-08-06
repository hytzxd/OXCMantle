//
// OXFloatTypeValidator
// Oxen
//
// Created by Matthew on 6/16/14.
// Released under the MIT license
//


#import "OXFloatTypeValidator.h"
#import "NSString+ValidationUtils.h"


@implementation OXFloatTypeValidator

- (id)init {
    self = [super init];
    if (self) {
        self.defaultValidation = ^NSNumber * (id value, BOOL *isValid, NSError **error){
            *isValid = YES;
            if ([value isKindOfClass:[NSString class]]){
                
                
                value = [NSString stripNonNumericCharacters:value];
            }
            if ([value respondsToSelector:@selector(floatValue)]){
                return @([value floatValue]);
            }
            return @0.0f;
        };
    }

    return self;
}

@end