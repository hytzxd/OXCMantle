//
// OXNumberTypeValidator
// Oxen
//
// Created by Matthew on 6/16/14.
// Released under the MIT license
//


#import "OXNumberTypeValidator.h"


@implementation OXNumberTypeValidator

- (id)init {
    self = [super init];
	
    if (self) {
        self.defaultValidation = ^NSNumber * (id value, BOOL *isValid, NSError **error){
            *isValid = YES;
            return [NSDecimalNumber decimalNumberWithString:value];
        };
    }

    return self;
}

- (BOOL)validateValue:(id *)value error:(NSError **)error {
    _isValid = [*value isKindOfClass:[NSNumber class]];
    return [super validateValue:value error:error];
}

@end