//
// OXBaseValidator
// Oxen
//
// Created by Matthew on 6/16/14.
// Released under the MIT license
//


#import "OXBaseValidator.h"


@implementation OXBaseValidator

- (BOOL)validateValue:(id *)value error:(NSError **)error {
    if (!self.isValid){
        if (self.defaultValidation) {
            *value = self.defaultValidation(*value, &_isValid, error);
        }
    }
    if (self.isValid && self.postValidation){
        *value = self.postValidation(*value);
    }

    return self.isValid;
}

- (id)initWithDefaultValidation:(OXDefaultValidation)defaultValidation {
    self = [self init];
	
    if (self){
        _defaultValidation = defaultValidation;
    }

    return self;
}

- (id)initWithPostValidation:(OXPostValidation)postValidation {
    self = [self init];
	
    if (self){
        _postValidation = postValidation;
    }

    return self;
}

@end