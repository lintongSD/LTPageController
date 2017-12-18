//
//  PagerController.h
//  PageController
//
//  Created by 林_同 on 2017/12/14.
//  Copyright © 2017年 林_同. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagerController : UIViewController
//控制器
@property (nonatomic, copy) NSArray <UIViewController *>* subControllers;
//控制器顶部title
@property (nonatomic, copy) NSArray <NSString *>* controllerTitles;
//标题是否有间隔
@property (nonatomic, assign) CGFloat titleMargin;
//正常时颜色
@property (nonatomic, copy) UIColor *normalColor;
//选中后颜色
@property (nonatomic, copy) UIColor *selectedColor;

@property (nonatomic, assign) BOOL showSign;

@property (nonatomic, assign) CGFloat signWidth;

//sign颜色    默认红色
@property (nonatomic, copy) UIColor *signColor;

@property (nonatomic, assign, readonly) NSInteger selectedIndex;

typedef NS_ENUM(int, PagerSignAnimationStyle){
    PagerSignAnimationStyleNormal = 0,   //平移
//    PagerSignAnimationStyleDraw,     //填充一个-->缩小-->移动
//    PagerSignAnimationStyleFull,    //填充两个-->缩小到指定位置
};
typedef NS_ENUM(int, PagerSignStyle){
    PagerSignStyleLineSmall,    //默认情况
    PagerSignStyleLineFull,
};

//如果不设置默认平移
//@property (nonatomic, assign) PagerSignAnimationStyle pagerSignAnimationStyle;

@property (nonatomic, assign) PagerSignStyle pagerSignStyle;

@end
