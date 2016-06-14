//
//  ModelExample.h
//  OXCen
//
//  Created by 张旭东 on 15/7/25.
//  Copyright (c) 2015年 zhangxudong. All rights reserved.
//

#import "OXModel.h"

@interface ModelExample : OXModel
@property (assign ,nonatomic)NSInteger ID;
@property (assign ,nonatomic)float age;
@property (strong ,nonatomic)NSArray *names;
@property (strong ,nonatomic)NSArray *examples;
@property (strong ,nonatomic)NSDate *date;
@end
