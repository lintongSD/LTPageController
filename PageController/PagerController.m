//
//  PagerController.m
//  PageController
//
//  Created by 林_同 on 2017/12/14.
//  Copyright © 2017年 林_同. All rights reserved.
//

#import "PagerController.h"
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
@interface PagerController ()<UIScrollViewDelegate>{
    UIScrollView *_scrollView;
    NSMutableArray <UIButton *> *_btnArr;
    UIButton *_selectedBtn;
    UILabel *_signL;        //记号
}

@end

@implementation PagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGRect frame = self.view.frame;
    _btnArr = [NSMutableArray array];
    _scrollView = [[UIScrollView alloc] initWithFrame:frame];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    
    _signL = [[UILabel alloc] init];
    _signL.backgroundColor = [UIColor redColor];
}

//page
- (void)setSubControllers:(NSArray<UIViewController *> *)subControllers{
    _subControllers = subControllers;
    for (int i = 0; i < subControllers.count; i++) {
        _scrollView.contentSize = CGSizeMake(kWidth * subControllers.count, kHeight);
        UIViewController *vc = subControllers[i];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255.0)/255.0 green:arc4random_uniform(255.0)/255.0 blue:arc4random_uniform(255.0)/255.0 alpha:1];
        CGFloat y = _btnArr.count>0?CGRectGetMaxY(_btnArr[0].frame):0;
        CGFloat h = kHeight - (_btnArr.count>0?CGRectGetMaxY(_btnArr[0].frame):0);
        vc.view.frame = CGRectMake(kWidth * i, y, kWidth, h);
        [self addChildViewController:vc];
        [_scrollView addSubview:vc.view];
    }
}
//title
- (void)setControllerTitles:(NSArray<NSString *> *)controllerTitles{
    _controllerTitles = controllerTitles;
    for (int i = 0; i < controllerTitles.count; i++) {
        UIButton *titleBtn = [[UIButton alloc] init];
        titleBtn.highlighted = NO;
        [titleBtn setTitle:controllerTitles[i] forState:UIControlStateNormal];
        titleBtn.backgroundColor = [UIColor whiteColor];
        [titleBtn setTitleColor:self.normalColor?:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:self.selectedColor?:[UIColor redColor] forState:UIControlStateSelected];
        titleBtn.titleLabel.font = self.titleFont?:[UIFont systemFontOfSize:15];
        titleBtn.tag = 1000 + i;
        [titleBtn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat btnW = (kWidth - self.titleMargin * controllerTitles.count) / controllerTitles.count;
        CGFloat btnH = self.titleHeight?:40;
        titleBtn.frame = CGRectMake(btnW * i, 0, btnW, btnH);
        [self.view addSubview:titleBtn];
        [_btnArr addObject:titleBtn];
        
        if (i == 0) {
            titleBtn.selected = YES;
            _selectedBtn = titleBtn;
        }
    }
    [self setSubControllers:self.subControllers];
}

#pragma mark----显示标记
- (void)setShowSign:(BOOL)showSign{
    _showSign = showSign;
    if (showSign) {
        [self.view addSubview:_signL];
        [self updateSignLFrame];
    }
}

- (void)setPagerSignStyle:(PagerSignStyle)pagerSignStyle{
    _pagerSignStyle = pagerSignStyle;
    [self updateSignLFrame];
}

- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    if(_btnArr.count > 0){
        for (int i = 0; i < _btnArr.count; i++) {
            UIButton *btn = _btnArr[i];
            btn.titleLabel.font = titleFont;
        }
        [_btnArr removeAllObjects];
        [self setControllerTitles:self.controllerTitles];
        [self updateSignLFrame];
    }
}

- (void)setTitleHeight:(CGFloat)titleHeight{
    _titleHeight = titleHeight;
    if (_btnArr.count > 0) {
        for (int i = 0; i < _btnArr.count; i++) {
            UIButton *btn = _btnArr[i];
            btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width, titleHeight);
        }
        [_btnArr removeAllObjects];
        [self setControllerTitles:self.controllerTitles];
        [self updateSignLFrame];
    }
}

#pragma mark----更新signFrame
- (void)updateSignLFrame{
    CGPoint selectedBtnCenter = _selectedBtn.center;
    CGRect frame = _selectedBtn.frame;
    CGFloat smallW = 40;
    switch (self.pagerSignStyle) {
        case PagerSignStyleLineSmall:
            _signL.frame = CGRectMake(selectedBtnCenter.x - 20, CGRectGetMaxY(frame), self.signWidth>0?:smallW, 2);
            break;
        case PagerSignStyleLineFull:
            _signL.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame), frame.size.width, 2);
            break;
        default:
            _signL.frame = CGRectMake(selectedBtnCenter.x - 20, CGRectGetMaxY(_selectedBtn.frame), smallW, 2);
            break;
    }
}

#pragma mark----标记颜色
- (void)setSignColor:(UIColor *)signColor{
    _signL.backgroundColor = signColor;
    [self setShowSign:YES];
}

//设置动画效果
- (void)signAnimationFromeButton:(UIButton *)fromeBtn ToButton:(UIButton *)toBtn{
    
    NSTimeInterval time = 0.5;
//    NSTimeInterval delay = 0.2;
    switch (self.pagerSignAnimationStyle) {
        case PagerSignAnimationStyleNormal:{
            [UIView animateWithDuration:time animations:^{
                [self updateSignLFrame];
            }];
        }
            break;
//        case PagerSignAnimationStyleDraw:{
//            [UIView animateWithDuration:time delay:delay options:0 animations:^{
//                CGRect frame = fromeBtn.frame;
//                _signL.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame), frame.size.width, 2);
//            } completion:^(BOOL finished) {
//                [self updateSignLFrame];
//            }];
//            break;
//        }
//        case PagerSignAnimationStyleFull:{
//            
//        }
//            break;
        default:{
            [UIView animateWithDuration:time animations:^{
                [self updateSignLFrame];
            }];
        }
            break;
    }
}

- (void)btnSelected:(UIButton *)btn{
    
    NSInteger oldSelectedIndex = [_btnArr indexOfObject:_selectedBtn];
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    _scrollView.contentOffset = CGPointMake((btn.tag - 1000) * kWidth , 0);
    [self signAnimationFromeButton:_btnArr[oldSelectedIndex] ToButton:btn];
    
}

- (NSInteger)selectedIndex{
    return [_btnArr indexOfObject:_selectedBtn];
}

#pragma mark----scrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat indexF = scrollView.contentOffset.x / kWidth;   //偏移量
    CGFloat distance = indexF - floor(indexF);      //偏移了多少
    NSInteger index = distance > 0.5?ceil(indexF):floor(indexF);        //偏移的下标
    NSInteger oldSelectedIndex = [_btnArr indexOfObject:_selectedBtn];
    
    if (distance > 0.4 && distance < 0.6) {
        _selectedBtn.selected = NO;
        _selectedBtn = _btnArr[index];
        _selectedBtn.selected = YES;
        [self signAnimationFromeButton:_btnArr[oldSelectedIndex] ToButton:_selectedBtn];
    }
}


#pragma mark----动画
- (void)signAnimationWithScrollView:(UIScrollView *)scrollView{
//    CGRect frame = _signL.frame;
    if (scrollView.isDragging) {  //正在拖动
        switch (self.pagerSignAnimationStyle) {
            case PagerSignAnimationStyleNormal:
                
                break;
                
            default:
                break;
        }
    }else{      //结束拖动
        
    }
    
}

- (void)setPagerSignAnimationStyle:(PagerSignAnimationStyle)pagerSignAnimationStyle{
    _pagerSignAnimationStyle = pagerSignAnimationStyle;
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
