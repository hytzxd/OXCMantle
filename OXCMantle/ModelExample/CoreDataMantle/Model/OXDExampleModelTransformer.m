//
//  OXDExampleModelTransformer.m
//  OXCMantle
//
//  Created by 张旭东 on 2017/11/26.
//  Copyright © 2017年 张旭东. All rights reserved.
//

#import "OXDExampleModelTransformer.h"
#import "OXDExampleContentOne.h"
#import "OXDExamleContentThree.h"
#import "OXDExampleContentTwo.h"
#import <UIKit/UIKit.h>
@implementation OXDExampleModelTransformer
+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSDictionary class];
}

- (id)transformedValue:(id)value {
    if (value == nil || ![[value class] conformsToProtocol:@protocol(NSCoding)]) {
        return nil;
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
    return data;
//    NSNumber *key = nil;
//    if ([value isKindOfClass:[OXDExampleContentOne class]]) {
//        key = @1;
//    }
//    else if ([value isKindOfClass:[OXDExampleContentTwo class]]) {
//        key = @2;
//    }
//    else if ([value isKindOfClass:[OXDExamleContentThree class]]) {
//        key = @3;
//    }
//    if (!key) {
//        return nil;
//    }
//    return @{key:data};
}

- (id)reverseTransformedValue:(id)value {
    return [NSKeyedUnarchiver unarchiveObjectWithData:value];
}
@end
