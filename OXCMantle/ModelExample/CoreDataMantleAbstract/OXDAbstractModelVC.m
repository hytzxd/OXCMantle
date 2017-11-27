//
//  OXDAbstractModelVC.m
//  OXCMantle
//
//  Created by xudongzhang on 2017/11/27.
//  Copyright © 2017年 张旭东. All rights reserved.
//

#import "OXDAbstractModelVC.h"
#import <CoreData/CoreData.h>
#import "OXDPetModel.h"
#import "OXDPetFishModel.h"
#import "PetFishModel+CoreDataProperties.h"
#import "PetAbstractModel+CoreDataProperties.h"
@interface OXDAbstractModelVC ()
@property (nonatomic ,strong)NSManagedObjectContext *context;
@end

@implementation OXDAbstractModelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configContext];
    OXDPetModel *petModel = [self makePetModel];
    [self insertPetModel:petModel];
    NSLog(@"%@",petModel);
    [self saveContext];
    [self fetchPetModel];
}

- (void)fetchPetModel {
    // 建立获取数据的请求对象，指明操作的实体为Employee
    NSError *error = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PetModel"];
    // 执行获取操作，获取所有Employee托管对象
    NSMutableArray<OXDPetModel *> *pets = [[NSMutableArray alloc]initWithCapacity:42];
    NSArray<PetModel *> *models = [self.context executeFetchRequest:request error:&error];
    
    [models enumerateObjectsUsingBlock:^(PetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSError *transError = nil;
        NSLog(@"petModel name  :%@,petModel : %@ ",obj.name, obj.petModel);
        PetAbstractModel *abstractModel = (PetAbstractModel *)obj.petModel;
        OXDPetModel *aModel = [MTLManagedObjectAdapter modelOfClass:[OXDPetModel class] fromManagedObject:obj error:&transError];
        NSLog(@"%@",transError);
        if (abstractModel.type == OXDPetModelTypeFish) {
            OXDPetFishModel *fishModel = [MTLManagedObjectAdapter modelOfClass:[OXDPetFishModel class] fromManagedObject:abstractModel error:&transError];
            aModel.petModel = fishModel;
        }
        NSLog(@"%@",transError);
        aModel.managedObj = obj;
        [pets addObject:aModel];
    }];
    NSLog(@"%@",pets);
    // 错误处理
    NSLog(@"CoreData Ergodic Data Error : %@", error);
   
   //模拟修改事件
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        OXDPetModel *updateModel =  pets.firstObject;
        updateModel.name = @"123";
        updateModel.managedObj.name = updateModel.name;
        [self saveContext];
    });
    
}
- (void)insertPetModel:(OXDPetModel *)petModel {
    NSError *error = nil;
    PetModel *managedExample = (PetModel *)[MTLManagedObjectAdapter managedObjectFromModel:petModel insertingIntoContext:self.context error:&error];
    petModel.managedObj = managedExample;
}

- (void)saveContext {
    if (!self.context.hasChanges) {
        return;
    }
    NSError *error = nil;
    [self.context save:&error];
    NSLog(@"%@",error);
    
}
- (OXDPetModel *)makePetModel {
    NSDictionary *dict = @{
                           @"name":@"myPet",
                           };
    NSDictionary *petDict = @{
                              @"type":@(OXDPetModelTypeFish),
                              @"name":@"myFish",
                              @"fishFoods":@[
                                      @{
                                          @"name":@"food1",
                                          },
                                      @{
                                          @"name":@"food2",
                                          },
                                      @{
                                          @"name":@"food3",
                                          }
                                      ],
                              };
    NSError *error = nil;
    OXDPetModel *pet =  [MTLJSONAdapter modelOfClass:[OXDPetModel class] fromJSONDictionary:dict error:&error];
    NSLog(@"%@ %@",pet,error);
    OXDPetFishModel *petModel = [MTLJSONAdapter modelOfClass:[OXDPetFishModel class] fromJSONDictionary:petDict error:&error];
    NSLog(@"%@ %@",petModel,error);
    pet.petModel = petModel;
    NSLog(@"%@ %@",pet,error);
    return pet;
}
- (void)configContext {
    
    if (self.context) {
        return;
    }
    self.context = ({
        // Do any additional setup after loading the view.
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
        context;
    });
    
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
