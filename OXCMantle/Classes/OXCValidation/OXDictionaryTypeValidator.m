//
// OXDictionaryTypeValidator
// Oxen
//
// Created by Matthew on 6/17/14.
// Released under the MIT license
//


#import "OXDictionaryTypeValidator.h"


@implementation OXDictionaryTypeValidator

- (id)init {
    self = [super init];
	
    if (self) {
        self.defaultValidation = ^NSDictionary * (id value, BOOL *isValid, NSError **error){
            *isValid = NO;
            return nil;
        };
    }

    return self;
}

- (BOOL)validateValue:(id *)value error:(NSError **)error {
    _isValid = [*value isKindOfClass:[NSDictionary class]];
    return [super validateValue:value error:error];
}

@end