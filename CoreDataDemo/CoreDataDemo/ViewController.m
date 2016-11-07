//
//  ViewController.m
//  CoreDataDemo
//
//  Created by dontbeditouzu on 16/11/7.
//  Copyright © 2016年 dontbeditouzu. All rights reserved.
//

#import "ViewController.h"


#define kWidth              [UIScreen mainScreen].bounds.size.width
#define kHeight             [UIScreen mainScreen].bounds.size.height

static NSString *reuseCellID = @"reuseCellID";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView          *tbView;
@property(nonatomic,strong)NSMutableArray       *dataArray;

@end

@implementation ViewController

/*排序方法*/
- (void)sortData{
    
}
/*筛选方法 */
- (void)filterData{
    
}

#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseCellID];;
    
    
    
    
    cell.textLabel.text=[NSString stringWithFormat:@"%zd",indexPath.row];
    
    return cell;
    
}
#pragma mark - 设置界面

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self.view addSubview:self.tbView];
    
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
