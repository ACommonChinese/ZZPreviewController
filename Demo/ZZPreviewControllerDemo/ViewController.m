//
//  ViewController.m
//  ZZPreviewControllerDemo
//
//  Created by liuweizhen on 2017/10/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ViewController.h"
#import "ZZPreViewController.h"
#import "ZZCustomPreviewController.h"

@interface ViewController () <ZZPreViewControllerProtocol>

@end

@implementation ViewController

- (IBAction)buttonClick:(UIButton *)sender {
    ZZPreViewController *previewController = [[ZZPreViewController alloc] init];
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    redView.backgroundColor = [UIColor redColor];
    previewController.contentView = redView;
    [previewController showFromView:sender];
    // [previewController showFading];
}

- (IBAction)customButtonClick:(UIButton *)sender {
    ZZCustomPreviewController *previewController = [[ZZCustomPreviewController alloc] init];
    previewController.delegate = self; // 如果代理方法不想在本控制器中实现，则可以在ZZCustomPreviewController中实现
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    redView.backgroundColor = [UIColor redColor];
    previewController.contentView = redView;
    [previewController showFromView:sender];
    // [previewController showFading];
}

- (IBAction)customButton2Click:(UIButton *)sender {
    ZZCustomPreviewController *previewController = [[ZZCustomPreviewController alloc] init];
    // previewController.delegate = self; // 在ZZCustomPreviewController中实现了代理方法
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    redView.backgroundColor = [UIColor redColor];
    previewController.contentView = redView;
    [previewController showFromView:sender];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - <ZZPreViewControllerProtocol>

- (void)previewControllerDidShow:(ZZPreViewController *)controller {
    ZZCustomPreviewController *vc = (ZZCustomPreviewController *)controller;
    [vc showCustomView];
}

- (void)previewControllerWillDismiss:(ZZPreViewController *)controller {
    ZZCustomPreviewController *vc = (ZZCustomPreviewController *)controller;
    [vc dismissCustomView];
}

@end
