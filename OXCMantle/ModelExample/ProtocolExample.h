//
//  ProtocolExample.h
//  OXCMantle
//
//  Created by 张旭东 on 16/6/14.
//  Copyright © 2016年 张旭东. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProtocolExample <NSObject>
@property (nonatomic ,copy ,readonly)NSString *test1;
@property (nonatomic ,copy ,readonly)NSString *test2;
@property (nonatomic ,copy ,readonly)NSString *test3;
@property (nonatomic ,copy ,readonly)NSString *test4;

@end
