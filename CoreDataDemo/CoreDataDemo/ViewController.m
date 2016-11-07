//
//  ViewController.m
//  CoreDataDemo
//
//  Created by dontbeditouzu on 16/11/7.
//  Copyright © 2016年 dontbeditouzu. All rights reserved.
//

#import "ViewController.h"
#import "DBManager.h"
#import "UIAlertController+Actions.h"

#define kWidth              [UIScreen mainScreen].bounds.size.width
#define kHeight             [UIScreen mainScreen].bounds.size.height

static NSString *reuseCellID = @"reuseCellID";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView          *tbView;
@property(nonatomic,strong)NSMutableArray       *dataArray;

@property(nonatomic,assign)NSComparisonResult   compare;
@property(nonatomic,copy)NSString               *fiterSex;
@end

@implementation ViewController
#pragma mark - delegate   删除
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) wkSelf=self;
    UITableViewRowAction *deleteAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        People *model=[wkSelf.dataArray objectAtIndex:indexPath.row];
        [[DBManager shared]deletePeopleWithUid:model.uid];
        [wkSelf.dataArray removeObject:model];
        [wkSelf.tbView reloadData];
    }];
    return @[deleteAction];
}
-(NSString *)descMsg{
    
    NSString *sortString;
    if(self.compare==NSOrderedAscending)
        sortString=@"年龄升序";
    else if(self.compare==NSOrderedDescending)
        sortString=@"年龄降序";
    else
        sortString=@"默认排序";
    NSString *fiterString;
    if([self.fiterSex isEqualToString:@"男"])
        fiterString=@"只看男生";
    else if([self.fiterSex isEqualToString:@"女"])
        fiterString=@"只看女生";
    else
        fiterString=@"查看全部";
    NSString *msg=[NSString stringWithFormat:@"排序方式：%@\n筛选条件：%@",sortString,fiterString];
    return msg;
}
/*排序方法*/
- (void)sortData{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"排序" message:[self descMsg] preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableArray *actions=[NSMutableArray array];
    NSArray *titiles=@[@"年龄升序",@"年龄降序",@"默认排序"];
    __weak typeof(self) wkSelf=self;
    for(int i=0;i<3;i++){
        
        UIAlertAction *action=[UIAlertAction actionWithTitle:titiles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if(i==0)
                wkSelf.compare=NSOrderedAscending;
            else if(i==1)
                wkSelf.compare=NSOrderedDescending;
            else
                wkSelf.compare=NSOrderedSame;
            wkSelf.dataArray=[NSMutableArray arrayWithArray:[[DBManager shared]fiterSex:wkSelf.fiterSex ageAcsending:wkSelf.compare]];
            [wkSelf.tbView reloadData];
        }];
        [actions addObject:action];
    }
    [alert addActions:actions];
    [self presentViewController:alert animated:YES completion:nil];
}
/*筛选方法 */
- (void)filterData{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"筛选" message:[self descMsg] preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableArray *actions=[NSMutableArray array];
    NSArray *titiles=@[@"只看男生",@"只看女生",@"查看全部"];
    __weak typeof(self) wkSelf=self;
    for(int i=0;i<3;i++){
        
        UIAlertAction *action=[UIAlertAction actionWithTitle:titiles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if(i==0)
                wkSelf.fiterSex=@"男";
            else if(i==1)
                wkSelf.fiterSex=@"女";
            else
                wkSelf.fiterSex=nil;
            wkSelf.dataArray=[NSMutableArray arrayWithArray:[[DBManager shared]fiterSex:wkSelf.fiterSex ageAcsending:wkSelf.compare]];
            [wkSelf.tbView reloadData];
        }];
        [actions addObject:action];
    }
    [alert addActions:actions];
    [self presentViewController:alert animated:YES completion:nil];

}
// 创建数据
-(void)createData
{
    if([[DBManager shared] allPeople].count==0){
        NSArray *names=@[@"丁丁",@"峰峰",@"楠楠",@"雯雯",@"木木",
                         @"葵葵",@"莎莎",@"蓉蓉",@"果果",@"胡微",
                         @"龚悦",@"程海鹏",@"刘荣",@"田慧",@"肖扬",
                         @"夏慧",@"邓伟强",@"周浩",@"周学富",@"戴文莲"];
        NSArray *sexes=@[@"女",@"男",@"女",@"女",@"女",
                         @"女",@"女",@"女",@"女",@"女",
                         @"女",@"男",@"女",@"女",@"男",
                         @"女",@"男",@"男",@"男",@"男",@"女"];
        DBManager *mgr=[DBManager shared];
        for(int i=0;i<20;i++){
            NSString *name=names[i];
            NSNumber *age=@(20+arc4random_uniform(5));
            NSString *uid=@(2016100+i+1).stringValue;
            NSString *sex=sexes[i];
            NSLog(@"%@",age);
            [mgr insert:name sex:sex age:age uid:uid];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.dataArray=[NSMutableArray arrayWithArray:[[DBManager shared]allPeople]];
    [self.tbView reloadData];
}

#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseCellID];;
    
    People *model=[self.dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@ %zd岁 %@",model.name,model.age,model.sex];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"学号：%@",model.uid];
    
    return cell;
    
}
#pragma mark - 设置界面

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self.view addSubview:self.tbView];
    // 创建数据
    [self createData];
}

-(void)setup
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.title=@"CoreData";
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    
    UIButton *sortBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    [sortBtn setTitle:@"排序" forState:UIControlStateNormal];
    [sortBtn addTarget:self action:@selector(sortData) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:sortBtn];
    
    UIButton *fiterBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    [fiterBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [fiterBtn addTarget:self action:@selector(filterData) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:fiterBtn];
    
    self.fiterSex=nil;
    self.compare=NSOrderedSame;
}

-(UITableView *)tbView
{
    if(!_tbView){
        
        _tbView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64) style:UITableViewStylePlain];
        [self.view addSubview:_tbView];
        [_tbView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseCellID];
        _tbView.delegate=self;
        _tbView.dataSource=self;
        _tbView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    }
    
    return _tbView;
    
}

-(NSMutableArray *)dataArray
{
    if(!_dataArray){
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
@end
