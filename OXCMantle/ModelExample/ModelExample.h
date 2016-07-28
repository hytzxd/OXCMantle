//
//  ModelExample.h
//  OXCen
//
//  Created by 张旭东 on 15/7/25.
//  Copyright (c) 2015年 zhangxudong. All rights reserved.
//

#import "OXModel.h"
#import "ProtocolExample.h" 
typedef NS_ENUM(NSInteger ,ModelExampleType) {
    ModelExampleTypeUnknow,
    ModelExampleTypeDisable,
    ModelExampleTypeEnable
};

@interface ModelExample : OXModel<ProtocolExample>

//@property (copy ,nonatomic)     NSString  *ID;
//@property (assign ,nonatomic)   BOOL isNew;
@property (assign ,nonatomic)   NSInteger  age;
//@property (strong ,nonatomic)   NSArray <NSString *> *names;
//@property (strong ,nonatomic)   NSArray *examples;
//@property (strong ,nonatomic)   NSDate  *date;
//@property (strong ,nonatomic)   NSURL   *url;
//@property (assign ,nonatomic)   ModelExampleType exampleType;

@end
