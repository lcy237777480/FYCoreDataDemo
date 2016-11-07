//
//  DBManager.h
//  CoreDataDemo
//
//  Created by dontbeditouzu on 16/11/8.
//  Copyright © 2016年 dontbeditouzu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "People+CoreDataClass.h"
@interface DBManager : NSObject
+(instancetype)shared;



-(NSArray *)allPeople;
-(People *)isPeopleExist:(NSString *)uid;
// 增加数据
-(void)insert:(NSString *)name sex:(NSString *)sex age:(NSNumber *)age uid:(NSString *)uid;

// 删除
-(void)deletePeopleWithUid:(NSString *)uid;

// 更改
-(void)updatePeople:(People *)people name:(NSString *)name age:(NSNumber *)age sex:(NSString *)sex;

// 排序和筛选
-(NSArray *)fiterSex:(NSString *)sex ageAcsending:(NSComparisonResult)compare;


// 按性别筛选
-(NSArray *)filterSex:(NSString *)sex;
// 按年龄关键字排序
-(NSArray *)sortWithAgeAcsend:(NSComparisonResult)compare;
@end
