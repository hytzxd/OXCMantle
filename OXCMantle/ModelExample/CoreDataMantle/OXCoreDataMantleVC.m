//
//  OXCoreDataMantleVC.m
//  OXCMantle
//
//  Created by 张旭东 on 2017/11/26.
//  Copyright © 2017年 张旭东. All rights reserved.
//

#import "OXCoreDataMantleVC.h"
#import "OXDExampleModel.h"
@interface OXCoreDataMantleVC ()

@end

@implementation OXCoreDataMantleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dict = @{
                           @"qeustion":@"qeustion",
                           @"type":@1,
                           @"content":@{
                                   @"name":@"contentOne",
                                    @"contents":@[@"1",@"2",@"3"]
                                   },
                           };
    NSError *error = nil;
    OXDExampleModel *example =  [MTLJSONAdapter modelOfClass:[OXDExampleModel class] fromJSONDictionary:dict error:&error];
    NSLog(@"%@ %@",example,error);
    // 创建上下文对象，并发队列设置为主队列
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    // 创建托管对象模型，并使用Model.momd路径当做初始化参数
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    // 创建持久化存储调度器
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", @"Modle"];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    
    
    // 上下文对象设置属性为持久化存储器
    context.persistentStoreCoordinator = coordinator;
    NSManagedObject *managedExample = [MTLManagedObjectAdapter managedObjectFromModel:example insertingIntoContext:context error:&error];
    example.managedObj = managedExample;
    
    NSLog(@"%@",managedExample);
    if (context.hasChanges) {
        [context save:&error];
    }
    NSMutableArray<OXDExampleModel * > *oxEmodels = [[NSMutableArray alloc]initWithCapacity:42];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSError *aError = nil;
        // 建立获取数据的请求对象，指明操作的实体为Employee
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ExampleModel"];

        // 执行获取操作，获取所有Employee托管对象
        
        NSArray<ExampleModel *> *models = [context executeFetchRequest:request error:&aError];
        [models enumerateObjectsUsingBlock:^(ExampleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"ExampleModel type  :%d,qeustion, %@ ,content: %@",obj.type, obj.qeustion,obj.content);
            NSError *transError = nil;
            OXDExampleModel *aModel =[MTLManagedObjectAdapter modelOfClass:[OXDExampleModel class] fromManagedObject:obj error:&transError];
            NSLog(@"%@",transError);
            aModel.managedObj = obj;
            [oxEmodels addObject:aModel];
        }];
        NSLog(@"%@",oxEmodels);
        // 错误处理
        if (error) {
            NSLog(@"CoreData Ergodic Data Error : %@", error);
        }
    });
    //3秒钟之后 模拟 修改 conten属性的操纵
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (OXDExampleModel *model in oxEmodels) {
            OXDExampleContentOne *subModel = [[OXDExampleContentOne alloc]init];
            subModel.name = @"456";
            subModel.contents = @[@"99",@"88"];
            model.content = subModel;
            ((OXDExampleContentOne *)model.content).name = @"456";
            model.managedObj.content = model.content;
        }
        if (context.hasChanges) {
            [context save:nil];
        }
    });

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
