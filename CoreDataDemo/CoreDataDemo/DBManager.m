//
//  DBManager.m
//  CoreDataDemo
//
//  Created by dontbeditouzu on 16/11/8.
//  Copyright © 2016年 dontbeditouzu. All rights reserved.
//

#import "DBManager.h"
@interface DBManager()
@property(nonatomic,strong)NSManagedObjectContext *ctxt;
@end
@implementation DBManager

-(NSArray *)allPeople{
    
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"People"];
    return [_ctxt executeFetchRequest:request error:nil];
    
}
-(People *)isPeopleExist:(NSString *)uid{
    
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"People"];
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"uid=%@",uid];
    request.predicate=pre;
    NSArray *array=[_ctxt executeFetchRequest:request error:nil];
    if(array.count>0){
        return array.firstObject;
    }
    return nil;
    
}
-(void)insert:(NSString *)name sex:(NSString *)sex age:(NSNumber *)age uid:(NSString *)uid{
    if([self isPeopleExist:uid]){
        return;
    }
    NSLog(@"manager%@",age);
    People *people=[NSEntityDescription insertNewObjectForEntityForName:@"People" inManagedObjectContext:_ctxt];
    people.name=name;
    people.sex=sex;
    people.age= age.intValue;
    NSLog(@"people%zd",people.age);
    people.uid=uid;
    [_ctxt save:nil];
    
}


-(NSArray *)fiterSex:(NSString *)sex ageAcsending:(NSComparisonResult)compare{
    
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"People"];
    if(sex){
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"sex=%@",sex];
        request.predicate=pre;
    }
    BOOL acsend=(compare==NSOrderedAscending);
    if(compare!=NSOrderedSame){
        NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"age" ascending:acsend];
        request.sortDescriptors=@[sort];
    }
    return [_ctxt executeFetchRequest:request error:nil];
}


-(void)deletePeopleWithUid:(NSString *)uid{
    People *people=[self isPeopleExist:uid];
    if(!people){
        return;
    }
    [_ctxt deleteObject:people];
    [_ctxt save:nil];
}
















+(instancetype)shared{
    static DBManager*manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        manager=[[DBManager alloc]init];
    });
    return manager;
}

-(instancetype)init{
    if(self=[super init]){
        // 创建数据库
        [self createDatabase];
    }
    return self;
}

// 创建数据库
-(void)createDatabase{
    // 1、实例化管理上下文
    _ctxt=[[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    //
    NSURL *mmodelPath=[[NSBundle mainBundle]URLForResource:@"Student" withExtension:@"momd"];
    NSLog(@"%@",mmodelPath.absoluteString);
    // 2、管理对象模型
    NSManagedObjectModel *mmodel=[[NSManagedObjectModel alloc]initWithContentsOfURL:mmodelPath];
    // 3、持久化存储调度器
    NSPersistentStoreCoordinator *store=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:mmodel];
    
    //4、添加数据库
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlitePath=[docPath stringByAppendingPathComponent:@"People.db"];
    // 将本地文件的完整路径转换成 文件 URL
    NSURL *sqliteURL=[NSURL fileURLWithPath:sqlitePath];
    NSLog(@"%@",docPath);
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqliteURL options:nil error:nil];
    // 5、给管理上下文指定存储调度器
    _ctxt.persistentStoreCoordinator=store;
}
@end
