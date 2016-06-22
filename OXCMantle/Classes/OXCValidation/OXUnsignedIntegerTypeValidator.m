//
// OXUnsignedIntegerTypeValidator
// Oxen
//
// Created by Matthew on 6/17/14.
// Released under the MIT license
//


#import "OXUnsignedIntegerTypeValidator.h"


@implementation OXUnsignedIntegerTypeValidator

- (id)init {
    self = [super init];
	
    if (self) {
        self.defaultValidation = ^NSNumber * (id value, BOOL *isValid, NSError **error){
            *isValid = YES;
            if ([value respondsToSelector:@selector(integerValue)]){
                NSInteger intValue = [value integerValue];
                if (intValue >= 0){
                    return @(intValue);
                }
            }
            return @0U;
        };
    }

    return self;
}

- (BOOL)validateValue:(id *)value error:(NSError **)error {
    BOOL isValid = NO;
	
    if ([*value isKindOfClass:[NSNumber class]]){
        if ([*value integerValue] >= 0){
            isValid = YES;
        }
    }
	
    _isValid = isValid;
	
    return [super validateValue:value error:error];
}

@end