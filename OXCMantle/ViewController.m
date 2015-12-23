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
    
    NSDictionary *dict = @{@"id":@(999),
                           @"date":@(460457629.178584),
                           @"age":@"421431",
                           @"names":@[@"xd",@"xd",@"xd"],
                           @"examples":@[
                                   @{@"id":@"9999",
                                     @"date":@(460457629.178584),
                                     @"names":@[@"xd1",@"xd2",@"xd3"]},
                                   @{@"id":@"99900",
                                     @"date":@(460457629.178584),
                                     @"names":@[@"xd",@"xd",@"xd"]},
                                   @{@"id":@"999999",
                                     @"date":@(460457629.178584),
                                     @"names":@[@"xd",@"xd",@"xd"]},
                                   
                                   ]};
    NSError *error = nil;
    ModelExample *example =  [MTLJSONAdapter modelOfClass:[ModelExample class] fromJSONDictionary:dict error:&error];
    NSLog(@"%@",example);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
