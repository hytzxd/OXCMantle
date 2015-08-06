//
//  OXLongTypeValidator.m
//  Oxen
//
//  Created by Matthew on 7/2/14.
//  Released under the MIT license
//

#import "OXLongTypeValidator.h"

@implementation OXLongTypeValidator

- (id)init {
    self = [super init];
	
    if (self) {
        self.defaultValidation = ^NSNumber * (id value, BOOL *isValid, NSError **error){
            *isValid = YES;
            if ([value respondsToSelector:@selector(longValue)]){
                return @([value longValue]);
            }
            return @0;
        };
    }

    return self;
}

@end
