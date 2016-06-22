//
// OXBaseValidator
// Oxen
//
// Created by Matthew on 6/16/14.
// Released under the MIT license
//


#import <Foundation/Foundation.h>

typedef id (^OXDefaultValidation) (id value, BOOL *isValid, NSError **error);
typedef id (^OXPostValidation) (id value);

@interface OXBaseValidator : NSObject  {
@protected
    BOOL _isValid;
}

@property (nonatomic, assign, readonly) BOOL isValid;
@property (nonatomic, strong) OXDefaultValidation defaultValidation;
@property (nonatomic, strong) OXPostValidation postValidation;

- (BOOL)validateValue:(id *)value error:(NSError **)error;

- (id)initWithDefaultValidation:(OXDefaultValidation)defaultValidation;

- (id)initWithPostValidation:(OXPostValidation)postValidation;

@end