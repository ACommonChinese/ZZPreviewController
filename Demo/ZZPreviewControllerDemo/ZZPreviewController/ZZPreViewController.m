//
//  ZZPreViewController.m
//  ZZPreviewControllerDemo
//
//  Created by liuweizhen on 2017/10/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ZZPreViewController.h"

@interface ZZPreViewController ()

/// 用于呈现rootViewController
@property(nonatomic, strong) UIWindow *previewWindow;
/// 是否是fading效果
@property(nonatomic, assign) BOOL fading;
/// 初始frame, 用于非fading动画的开始
@property(nonatomic, assign) CGRect previewFromRect;
/// 考虑到contentView可能在其他地方引用，所以消失时还原其frame
@property(nonatomic, assign) CGRect tempOriginContentViewFrame;
/// 考虑屏蔽掉多次调用show方法
@property(nonatomic) BOOL isShowing;
@end

@implementation ZZPreViewController

#pragma mark - Life cycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self didInitialized];
    }
    return self;
}

- (void)didInitialized {
    [self setHidesBottomBarWhenPushed:YES];
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.previewWindow) return;
    
    if (self.fading) {
        if ([self.view.subviews containsObject:self.contentView] == NO) {
            self.tempOriginContentViewFrame = self.contentView.frame;
            [self.view addSubview:self.contentView];
        }
        // NSLog(@"%d", self.view.alpha);
        [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.view.alpha = 1;
        } completion:^(BOOL finished) {
            self.contentView.hidden = NO;
            [self previewControllerDidShow];
        }];
        return;
    }
    // no fading:
    self.view.backgroundColor = [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.5];
    CGRect transitionFromRect = self.previewFromRect;
    CGRect transitionToRect   = self.tempOriginContentViewFrame = self.contentView.frame;
    self.contentView.frame = transitionFromRect;
    [self.view addSubview:self.contentView];
    [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.frame = transitionToRect;
        // self.view.backgroundColor = self.backgroundColorTemporarily;
    } completion:^(BOOL finished) {
        [self previewControllerDidShow];
    }];
}

- (void)previewControllerDidShow {
    if ([self.delegate respondsToSelector:@selector(previewControllerDidShow:)]) {
        [self.delegate previewControllerDidShow:self];
    } else if ([self respondsToSelector:@selector(previewControllerDidShow:)]) {
        [self previewControllerDidShow:self];
    }
}

- (void)previewControllerWillDismiss {
    if ([self.delegate respondsToSelector:@selector(previewControllerWillDismiss:)]) {
        [self.delegate previewControllerWillDismiss:self];
    } else if ([self respondsToSelector:@selector(previewControllerWillDismiss:)]) {
        [self previewControllerWillDismiss:self];
    }
}

- (void)initPreviewWindowIfNeeded {
    if (!self.previewWindow) {
        self.previewWindow = [[UIWindow alloc] init];
        self.previewWindow.windowLevel = UIWindowLevelStatusBar + 1.0;
        self.previewWindow.backgroundColor = [UIColor clearColor];
    }
}

- (void)removePreviewWindow {
    self.contentView.frame = self.tempOriginContentViewFrame;
    [self.contentView removeFromSuperview];
    self.contentView          = nil;
    self.previewWindow.hidden = YES;
    self.isShowing            = NO;
    self.previewWindow.rootViewController = nil;
    self.previewWindow = nil;
}

#pragma mark - <ZZPreViewControllerProtocol>
- (void)previewControllerDidShow:(ZZPreViewController *)controller {}
- (void)previewControllerWillDismiss:(ZZPreViewController *)controller {}

#pragma mark - Public APIs

- (void)showFromRect:(CGRect)rect {
    [self showWithFadingAnimation:NO orFromRect:rect];
}

- (void)showFading {
    [self showWithFadingAnimation:YES orFromRect:CGRectZero];
}

- (void)showWithFadingAnimation:(BOOL)isFading orFromRect:(CGRect)rect {
    if (self.isShowing) return;
    self.isShowing = YES;
    self.fading    = isFading;
    if (isFading) {
        self.view.alpha = 0; // Prepare for fading animation
    } else {
        self.previewFromRect = rect;
    }
    
    [self initPreviewWindowIfNeeded];
    self.previewWindow.rootViewController = self;
    self.previewWindow.hidden = NO;
}

- (void)showFromView:(UIView *)view {
    NSAssert(view, @"showFromView:view is nil");
    [self showFromRect:[self getRelativeRect:view]];
}

- (void)dismiss {
    [self previewControllerWillDismiss];
    
    self.isShowing = NO;
    if (self.fading) {
        [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self removePreviewWindow];
            self.view.alpha = 1;
        }];
        return;
    }
    // no fading:
    CGRect transitionToRect = self.previewFromRect;
    [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.frame = transitionToRect;
    } completion:^(BOOL finished) {
        [self removePreviewWindow];
    }];
}

#pragma mark - Util methods
- (CGRect)getRelativeRect:(UIView *)view {
    return [self.view convertRect:view.frame fromView:view.superview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

@end
