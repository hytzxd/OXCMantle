//
//  ModelExample.h
//  OXCen
//
//  Created by 张旭东 on 15/7/25.
//  Copyright (c) 2015年 zhangxudong. All rights reserved.
//

#import "OXModel.h"
#import "ProtocolExample.h"
@interface ModelExample : OXModel<ProtocolExample>

@property (assign ,nonatomic)bool  ID;
@property (copy ,nonatomic)NSString * age;
@property (strong ,nonatomic)NSArray *names;
@property (strong ,nonatomic)NSArray *examples;
@property (strong ,nonatomic)NSDate *date;

@end
