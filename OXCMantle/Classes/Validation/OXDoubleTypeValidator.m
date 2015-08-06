//
// OXDoubleTypeValidator
// Oxen
//
// Created by Matthew on 6/17/14.
// Released under the MIT license
//


#import "OXDoubleTypeValidator.h"


@implementation OXDoubleTypeValidator

- (id)init {
    self = [super init];
	
    if (self) {
        self.defaultValidation = ^NSNumber * (id value, BOOL *isValid, NSError **error){
            *isValid = NO;
            if ([value respondsToSelector:@selector(doubleValue)]){
                return @([value doubleValue]);
            }
            return @0.0;
        };
    }

    return self;
}

@end