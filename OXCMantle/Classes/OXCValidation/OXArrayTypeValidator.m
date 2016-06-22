//
// OXArrayTypeValidator
// Oxen
//
// Created by Matthew on 6/16/14.
// Released under the MIT license
//


#import "OXArrayTypeValidator.h"


@implementation OXArrayTypeValidator

- (id)init {
    self = [super init];
	
    if (self) {
        self.defaultValidation = ^NSArray * (id value, BOOL *isValid, NSError **error){
            *isValid = NO;
            return nil;
        };
    }

    return self;
}

- (BOOL)validateValue:(id *)value error:(NSError **)error {
    _isValid = [*value isKindOfClass:[NSArray class]];
    return [super validateValue:value error:error];
}

@end