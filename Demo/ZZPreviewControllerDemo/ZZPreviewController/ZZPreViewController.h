//
//  ZZPreViewController.h
//  ZZPreviewControllerDemo
//
//  Created by liuweizhen on 2017/10/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 从指定视图位置以动画的形式放大进入预览，则调用 startPreviewFromRectInScreen:，传入一个 rect 即可开始预览，这种模式下会创建一个独立的 UIWindow 用于显示，所以可以达到盖住当前界面所有元素（包括顶部状态栏）的效果
 */
@interface ZZPreViewController : UIViewController

@property (nonatomic) UIView *contentView;

/**
 *  从指定 rect 的位置以动画的形式进入预览
 *  @param rect 在当前屏幕坐标系里的 rect，注意传进来的 rect 要做坐标系转换，例如：[view.superview convertRect:view.frame toView:nil]
 */
- (void)showFromRect:(CGRect)rect;

/**
 *  从指定视图的位置以动画的形式进入预览
 *  @param view 从指定的视图展开，默认会调用showFromRect 转换规则是：[view.superview convertRect:view.frame toView:nil]
 */
- (void)showFromView:(UIView *)view;

/**
 * 以渐现的方式开始预览
 */
- (void)showFading;

/**
 * 消失 - 根据显示方式相应的消失
 */
- (void)dismiss;

@end
