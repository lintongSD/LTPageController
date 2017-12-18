//
//  ViewController.m
//  PageController
//
//  Created by 林_同 on 2017/12/14.
//  Copyright © 2017年 林_同. All rights reserved.
//

#import "ViewController.h"
#import "PagerController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  给定一个控制器数组可创建一个PagerController
     *
     */
    [self createTableView];
    
}

static NSString *cellId = @"cellId";
- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 80;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255.0)/255.0 green:arc4random_uniform(255.0)/255.0 blue:arc4random_uniform(255.0)/255.0 alpha:1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PagerController *pager = [PagerController new];
    UIViewController *vc0 = [UIViewController new];
    UIViewController *vc1 = [UIViewController new];
    UIViewController *vc2 = [UIViewController new];
    UIViewController *vc3 = [UIViewController new];
    pager.subControllers = @[vc0, vc1, vc2, vc3];
    pager.controllerTitles = @[@"首页", @"标题", @"个人中心", @"登录"];
    pager.showSign = YES;
//    pager.pagerSignStyle = PagerSignStyleLineFull;
    pager.pagerSignAnimationStyle = PagerSignAnimationStyleDraw;
    [self presentViewController:pager animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
