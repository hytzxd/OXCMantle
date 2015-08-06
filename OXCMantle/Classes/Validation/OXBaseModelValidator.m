//
// OXBaseModelValidator
// Oxen
//
// Created by Matthew on 6/17/14.
// Released under the MIT license
//


#import "OXBaseModelValidator.h"
#import "OXModel.h"


@implementation OXBaseModelValidator

- (id)initWithClass:(Class)baseModelClass {
    self = [super init];
	
    if (self){
        __weak Class blockModelClass = baseModelClass;
        self.postValidation = ^id (id value){
            return [[blockModelClass alloc] initWithDictionary:value];
        };
    }
	
    return self;
}

- (id)initWithDefaultValidation:(OXDefaultValidation)defaultValidation {
    self = [self init];
	
    if (self) {
        self.defaultValidation = defaultValidation;
    }

    return self;
}

- (id)init {
    return [self initWithClass:[OXModel class]];
}

- (BOOL)validateValue:(id *)value error:(NSError **)error {
    _isValid = [*value isKindOfClass:[NSDictionary class]];
    return [super validateValue:value error:error];
}

@end