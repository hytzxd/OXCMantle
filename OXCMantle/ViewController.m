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
    
    NSDictionary *dict = @{@"id":@"999",
                           @"date":[NSNull null],
                           @"age":[NSNull null],
                           @"names":@[@"xd",@"xd",@"xd"],
                           @"url":@"https://www.google.com",
                           @"exampleType":@(1),
                           @"isNew":@"YES",
                           @"example":@{@"id":@"999",
                                        @"date":[NSNull null],
                                        @"age":[NSNull null],
                                        @"names":@[@"xd",@"xd",@"xd"],
                                        @"url":@"https://www.google.com",
                                        @"exampleType":@(1),
                                        @"isNew":@"YES",
                                        @"example":@{}}};
    
   
    
            NSError *error = nil;
            ModelExample *example =  [MTLJSONAdapter modelOfClass:[ModelExample class] fromJSONDictionary:dict error:&error];
            NSLog(@"%@ %@",example,error);
          
        
        
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
