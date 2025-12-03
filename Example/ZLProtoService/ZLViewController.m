//
//  ZLViewController.m
//  ZLProtoService
//
//  Created by fanpeng on 12/03/2025.
//  Copyright (c) 2025 fanpeng. All rights reserved.
//

#import "ZLViewController.h"
#import <ZLProtoService/ZLProtoService.h>
#import <ZLProtocols/ZLTestModule1Proto.h>
@protocol ZLTest <NSObject>

- (void)test;

@end

@interface ZLViewController ()

@end

@implementation ZLViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    ZLProtoService.interceptInvokeBlock = ^(NSInvocation * _Nonnull invocation, BOOL * _Nonnull stop) {
        NSLog(@"interceptInvokeBlock");
    };
    ZLProtoService.willInvokeBlock = ^(NSInvocation * _Nonnull invocation) {
        NSLog(@"willInvokeBlock");

    };
    ZLProtoService.didInvokeBlock = ^(NSInvocation * _Nonnull invocation) {
        NSLog(@"didInvokeBlock");

    };

    // 1️⃣ 创建按钮
    UIButton *jumpButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [jumpButton setTitle:@"跳转组件1" forState:UIControlStateNormal];
    jumpButton.titleLabel.font = [UIFont systemFontOfSize:18];
    jumpButton.backgroundColor = [UIColor systemBlueColor];
    [jumpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    jumpButton.layer.cornerRadius = 8;
    jumpButton.translatesAutoresizingMaskIntoConstraints = NO; // 使用 Auto Layout
    
    // 2️⃣ 添加点击事件
    [jumpButton addTarget:self action:@selector(jumpButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    // 3️⃣ 添加到视图
    [self.view addSubview:jumpButton];
    
    // 4️⃣ 居中约束
    [NSLayoutConstraint activateConstraints:@[
        [jumpButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [jumpButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [jumpButton.widthAnchor constraintEqualToConstant:120],
        [jumpButton.heightAnchor constraintEqualToConstant:44]
    ]];
}

// 5️⃣ 点击事件
- (void)jumpButtonTapped:(UIButton *)sender {
    id<ZLTestModule1Proto> impl1 = ZLGET_PROTO_IMPL(ZLTestModule1Proto);
    UIViewController *vc1 = [impl1 jumpVC1];
    [self.navigationController pushViewController:vc1 animated:YES];
}
@end
