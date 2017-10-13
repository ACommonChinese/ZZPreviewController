//
//  ZZCustomPreviewController.m
//  ZZPreviewControllerDemo
//
//  Created by liuweizhen on 2017/10/13.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ZZCustomPreviewController.h"

@interface ZZCustomPreviewController ()

@property (nonatomic) UIView *blueView;
@end

@implementation ZZCustomPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)showCustomView {
    self.blueView = [[UIView alloc] initWithFrame:CGRectMake(100, 400, 200, 200)];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];
}

- (void)dismissCustomView {
    self.blueView.hidden = YES;
}

- (void)previewControllerDidShow:(ZZPreViewController *)controller {
    [self showCustomView];
}

- (void)previewControllerWillDismiss:(ZZPreViewController *)controller {
    [self dismissCustomView];
}

@end
