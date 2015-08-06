//
// OXIntegerTypeValidator
// Oxen
//
// Created by Matthew on 6/17/14.
// Released under the MIT license
//


#import "OXIntegerTypeValidator.h"


@implementation OXIntegerTypeValidator

- (id)init {
    self = [super init];
	
    if (self) {
        self.defaultValidation = ^NSNumber * (id value, BOOL *isValid, NSError **error){
            *isValid = YES;
            if ([value respondsToSelector:@selector(integerValue)]){
                return @([value integerValue]);
            }
            return @0;
        };
    }

    return self;
}

@end