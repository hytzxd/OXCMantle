//
// OXBooleanTypeValidator
// Oxen
//
// Created by Matthew on 6/16/14.
// Released under the MIT license
//


#import "OXBooleanTypeValidator.h"


@implementation OXBooleanTypeValidator

- (id)init {
    self = [super init];
    if (self) {
        self.defaultValidation = ^NSNumber * (id value, BOOL *isValid, NSError **error){
            *isValid = YES;
			
            NSString *stringValue = @"NO";
			
            if ([value isKindOfClass:[NSString class]]){
                stringValue = value;
            } else if ([value respondsToSelector:@selector(stringValue)]){
                stringValue = [value stringValue];
            }
			
            if ([stringValue caseInsensitiveCompare:@"true"] == NSOrderedSame ||
                    [stringValue caseInsensitiveCompare:@"yes"] == NSOrderedSame ||
                    [stringValue caseInsensitiveCompare:@"y"] == NSOrderedSame ||
                    [stringValue caseInsensitiveCompare:@"1"] == NSOrderedSame){
                return @YES;
            }
			
            return @NO;
        };
    }

    return self;
}

@end