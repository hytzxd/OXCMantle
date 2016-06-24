//
//  ProtocolExample.h
//  OXCMantle
//
//  Created by 张旭东 on 16/6/14.
//  Copyright © 2016年 张旭东. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProtocolExample <NSObject>

@property (copy ,nonatomic)     NSString  *ID;
@property (strong ,nonatomic)   NSArray <NSString *> *names;
@property (strong ,nonatomic)   NSArray *examples;
@property (strong ,nonatomic)   NSDate  *date;
@property (strong ,nonatomic)   NSURL   *url;

@property (nonatomic ,copy ,readonly)NSString *test1;
@property (nonatomic ,copy ,readonly)NSString *test2;
@property (nonatomic ,copy ,readonly)NSString *test3;
@property (nonatomic ,copy ,readonly)NSString *test4;

@end
