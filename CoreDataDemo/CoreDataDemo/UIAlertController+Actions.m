//
//  UIAlertController+Actions.m
//  CoreDataDemo
//
//  Created by dontbeditouzu on 16/11/8.
//  Copyright © 2016年 dontbeditouzu. All rights reserved.
//

#import "UIAlertController+Actions.h"

@implementation UIAlertController (Actions)

-(void)addActions:(NSArray<UIAlertAction *> *)actions{
    if(actions.count==0)
        return;
    for(UIAlertAction *action in actions){
        [self addAction:action];
    }
}
@end
