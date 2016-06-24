//
//  ViewController.m
//  OXCMantle
//
//  Created by 张旭东 on 15/8/6.
//  Copyright (c) 2015年 张旭东. All rights reserved.
//

#import "ViewController.h"
#import "ModelExample.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    NSDictionary *dict = @{@"id":@"999",
                           @"date":@"2016-06-23 06:13:32",
                           @"age":@"421431",
                           @"names":@[@"xd",@"xd",@"xd"],
                           @"url":@"https://www.google.com",
                           @"exampleType":@(1),
                           @"isNew":@"YES",
                           @"examples":@[
                                   @{@"id":@"999",
                                     @"date":@"2016-06-23 06:13:32",
                                     @"age":@"421431",
                                     @"names":@[@"xd",@"xd",@"xd"],
                                     @"url":@"https://www.google.com",
                                     @"exampleType":@2,
                                     @"isNew":@1,
                                     @"names":@[@1,@2,@3]},
                                   @{@"id":@345,
                                     @"date":@(460457629.178584),
                                     @"names":@[@"xd",@"xd",@"xd"]},
                                   @{@"id":@"999999",
                                     @"date":@(460457629.178584),
                                     @"names":@[@"xd",@"xd",@"xd"]},
                                   
                                   ]};
    for (int i = 0; i < 10000; i++) {
        @autoreleasepool {
            NSError *error = nil;
            ModelExample *example =  [MTLJSONAdapter modelOfClass:[ModelExample class] fromJSONDictionary:dict error:&error];
            NSLog(@"%@ %@",example,error);
            NSDictionary *dict = [MTLJSONAdapter JSONDictionaryFromModel:example error:&error];
            NSLog(@"%@",dict);
        }
        
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
