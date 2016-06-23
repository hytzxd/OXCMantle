# OXCMantle
在mantle上加入了类型验证的功能。(json转model)


该项目已纳入Cocoapods管理，目前是1.0.1版本

你可以使用如下的方式来将本项目加入自己的工程

pod 'OXCMantle', '~> 1.0.0'
使用方法 直接用代码说吧


```

#import "OXModel.h"

@interface ModelExample : OXModel
@property (copy ,nonatomic)NSString *ID;
@property (assign ,nonatomic)NSInteger age;
@property (strong ,nonatomic)NSArray *names;
@property (strong ,nonatomic)NSArray *examples;
@property (strong ,nonatomic)NSDate *date;
@end


#import "ModelExample.h"

@implementation ModelExample
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    NSMutableDictionary* keys = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    keys[@"ID"] = @"id";
    return keys;
}

+ (NSValueTransformer *)namesJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithBasicClass:[NSString class]];
}
+ (NSValueTransformer *)replysJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[ModelExample class]];
}
@end





下面来说一下怎样解析，还是代码

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

```
如果有一些好的 批评或者意见 欢迎指出。
谢谢~

