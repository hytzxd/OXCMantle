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

@property (copy ,nonatomic)NSString  *ID;
@property (assign ,nonatomic)BOOL  age;
@property (strong ,nonatomic)NSArray <NSString *> *names;
@property (strong ,nonatomic)NSArray *examples;
@property (strong ,nonatomic)NSDate  *date;

@end
