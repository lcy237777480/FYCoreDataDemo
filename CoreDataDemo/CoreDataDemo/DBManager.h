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

// 排序和筛选
-(NSArray *)fiterSex:(NSString *)sex ageAcsending:(NSComparisonResult)compare;

// 删除
-(void)deletePeopleWithUid:(NSString *)uid;
@end
