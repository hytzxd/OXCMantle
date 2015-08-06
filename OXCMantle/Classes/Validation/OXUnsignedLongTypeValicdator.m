//
//  OXUnsignLognTypeValicdator.m
//  Oxen
//
//  Created by Matthew on 12/18/14.
//  Released under the MIT license
//

#import "OXUnsignedLongTypeValicdator.h"

@implementation OXUnsignedLongTypeValicdator

- (id)init {
    self = [super init];
	
    if (self) {
        self.defaultValidation = ^NSNumber * (id value, BOOL *isValid, NSError **error){
            *isValid = YES;
            if ([value respondsToSelector:@selector(longValue)]){
                return @([value unsignedLongValue]);
            }
            return @0;
        };
    }

    return self;
}
@end
