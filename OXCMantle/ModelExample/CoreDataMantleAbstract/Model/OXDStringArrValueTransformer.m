//
//  OXDStringArrValueTransformer.m
//  OXCMantle
//
//  Created by xudongzhang on 2017/11/27.
//  Copyright © 2017年 张旭东. All rights reserved.
//

#import "OXDStringArrValueTransformer.h"

@implementation OXDStringArrValueTransformer
+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSData class];
}

- (id)transformedValue:(id)value {
    if (value == nil || ![[value class] conformsToProtocol:@protocol(NSCoding)]) {
        return nil;
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
    return data;
}

- (id)reverseTransformedValue:(id)value {
    return [NSKeyedUnarchiver unarchiveObjectWithData:value];
}
@end
