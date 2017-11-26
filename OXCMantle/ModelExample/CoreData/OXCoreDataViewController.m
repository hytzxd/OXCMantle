//
//  OXCoreDataViewController.m
//  OXCMantle
//
//  Created by 张旭东 on 2017/11/26.
//  Copyright © 2017年 张旭东. All rights reserved.
//
#import "Department+CoreDataProperties.h"
#import "Employee+CoreDataProperties.h"
#import "OXCoreDataViewController.h"
#import <CoreData/CoreData.h>
@interface OXCoreDataViewController ()
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@end

@implementation OXCoreDataViewController
@synthesize persistentContainer = _persistentContainer;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.persistentContainer.viewContext);
    
    
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
    
    Employee *employee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
    employee.name = @"oxcmantle";
    employee.birthday = [NSDate new];
    Department *department = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:context];
    department.departName = @"oxcmantleDepartment";
    department.createDate = [NSDate new];
    NSError *error = nil;
    [context save:&error];
    NSLog(@"%@",error);
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSError *aError = nil;
        // 建立获取数据的请求对象，指明操作的实体为Employee
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
        
        // 执行获取操作，获取所有Employee托管对象
        
        NSArray<Employee *> *employees = [context executeFetchRequest:request error:&aError];
        [employees enumerateObjectsUsingBlock:^(Employee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"Employee Name : %@,Brithday : %@", obj.name, obj.birthday);
        }];
        
        // 错误处理
        if (error) {
            NSLog(@"CoreData Ergodic Data Error : %@", error);
        }
    });
    
    
  
}

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}


- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
