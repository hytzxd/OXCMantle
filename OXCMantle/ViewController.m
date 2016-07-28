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
  
//    NSDictionary *dict = @{@"id":@"999",
//                           @"date":@"2016-06-23 06:13:32",
//                           @"age":[NSNull null],
//                           @"names":@[@"xd",@"xd",@"xd"],
//                           @"url":@"https://www.google.com",
//                           @"exampleType":@(1),
//                           @"isNew":@"YES",
//                           @"examples":@[
//                                   @{@"id":@"999",
//                                     @"date":@"2016-06-23 06:13:32",
//                                     @"age":@"421431",
//                                     @"names":@[@"xd",@"xd",@"xd"],
//                                     @"url":@"https://www.google.com",
//                                     @"exampleType":@2,
//                                     @"isNew":@1,
//                                     @"names":@[@1,@2,@3]},
//                                   @{@"id":@345,
//                                     @"date":@(460457629.178584),
//                                     @"names":@[@"xd",@"xd",@"xd"]},
//                                   @{@"id":@"999999",
//                                     @"date":@(460457629.178584),
//                                     @"names":@[@"xd",@"xd",@"xd"]},
//                                   
//                                   ]};
    
    NSDictionary *dict = @{@"id":@"999",
                           @"date":@"2016-06-23 06:13:32",
                           @"age":[NSNull null],
                           @"names":@[@"xd",@"xd",@"xd"],
                           @"url":@"https://www.google.com",
                           @"exampleType":@(1),
                           @"isNew":@"YES"};
    
   
    
            NSError *error = nil;
            ModelExample *example =  [MTLJSONAdapter modelOfClass:[ModelExample class] fromJSONDictionary:dict error:&error];
            NSLog(@"%@ %@",example,error);
          
        
        
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
