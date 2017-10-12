//
//  ViewController.m
//  ZZPreviewControllerDemo
//
//  Created by liuweizhen on 2017/10/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ViewController.h"
#import "ZZPreViewController.h"

@interface ViewController ()

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

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
