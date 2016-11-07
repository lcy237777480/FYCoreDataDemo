//
//  ViewController.m
//  CoreDataDemo
//
//  Created by dontbeditouzu on 16/11/7.
//  Copyright © 2016年 dontbeditouzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *sexField;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UILabel *uidLabel;

@property(nonatomic,strong)People *model;


@end
