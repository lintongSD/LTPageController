//
//  ViewController.m
//  PageController
//
//  Created by 林_同 on 2017/12/14.
//  Copyright © 2017年 林_同. All rights reserved.
//

#import "ViewController.h"
#import "PagerController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *push = [UIButton buttonWithType:UIButtonTypeCustom];
    push.frame = CGRectMake(100, 200, 150, 70);
    [push setTitle:@"push" forState:UIControlStateNormal];
    [push addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    push.tag = 1;
    push.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:push];
    
    UIButton *present = [UIButton buttonWithType:UIButtonTypeCustom];
    present.frame = CGRectMake(100, 300, 150, 70);
    [present setTitle:@"present" forState:UIControlStateNormal];
    [present addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    present.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:present];
    
}

- (void)btnAction:(UIButton *)btn{
    PagerController *pager = [PagerController new];
    UIViewController *vc0 = [UIViewController new];
    UIViewController *vc1 = [UIViewController new];
    UIViewController *vc2 = [UIViewController new];
    UIViewController *vc3 = [UIViewController new];
    pager.subControllers = @[vc0, vc1, vc2, vc3];
    pager.controllerTitles = @[@"首页", @"标题", @"个人中心", @"登录"];
    pager.showSign = YES;
    pager.titleHeight = 30;
    if (btn.tag == 1) {
        pager.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pager animated:YES];
    }else{
        [self presentViewController:pager animated:YES completion:nil];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
