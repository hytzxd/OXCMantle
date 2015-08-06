//
//  OXCMantleTests.m
//  OXCMantleTests
//
//  Created by 张旭东 on 15/8/6.
//  Copyright (c) 2015年 张旭东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
//#import "ModelExample.h"
//#import "MTLJSONAdapter.h"
@interface OXCMantleTests : XCTestCase

@end

@implementation OXCMantleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}


//- (void)testModel{
//    NSDictionary *dict = @{@"id":@"999",
//                           @"date":@(460457629.178584),
//                           @"names":@[@"xd",@"xd",@"xd"],
//                           @"examples":@[
//                                   @{@"id":@"999",
//                                     @"date":@(460457629.178584),
//                                     @"names":@[@"xd",@"xd",@"xd"]},
//                                   @{@"id":@"999",
//                                     @"date":@(460457629.178584),
//                                     @"names":@[@"xd",@"xd",@"xd"]},
//                                   @{@"id":@"999",
//                                     @"date":@(460457629.178584),
//                                     @"names":@[@"xd",@"xd",@"xd"]},
//                                   
//                                   ]};
//    NSError *error = nil;
////    ModelExample *example =  [MTLJSONAdapter modelOfClass:[ModelExample class] fromJSONDictionary:dict error:&error];
////    NSLog(@"%@",example);
//}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
