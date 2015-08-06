//
//  OXModel.h
//  Oxen
//
//  Created by Matthew on 6/16/14.
//  Released under the MIT license
//

#import "Mantle.h"
#import "NSValueTransformer+MantleExtention.h"

@interface OXModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong, readonly) NSString *dictionaryKey;

+ (NSString *)calculateClassName;

- (NSString *)compactDescription;
/**
 *  获取所有属性和数据
 *
 *  @return NSDictionary
 */
- (NSDictionary *)getAllPropertiesAndVaules;
@end
