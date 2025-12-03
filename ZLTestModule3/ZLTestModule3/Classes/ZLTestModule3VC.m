//
//  ZLTestModule3VC.m
//  ZLTestModule1
//
//  Created by admin on 2025/12/3.
//

#import "ZLTestModule3VC.h"

#import <ZLProtoService/ZLProtoService.h>
#import <ZLProtocols/ZLTestModule3Proto.h>
#import <ZLProtocols/ZLMainModuleProto.h>

@interface ZLTestModule3ProtoImpl : NSObject<ZLTestModule3Proto>
@end
@implementation ZLTestModule3ProtoImpl
- (UIViewController *)jumpVC3{
    return ZLTestModule3VC.new;
}
@end
@interface ZLTestModule3VC ()

@end

@implementation ZLTestModule3VC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"无需手动注册";
    self.view.backgroundColor = UIColor.greenColor;

    // 1️⃣ 创建按钮
    UIButton *jumpButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [jumpButton setTitle:@"跳转主VC" forState:UIControlStateNormal];
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
    id<ZLMainModuleProto> impl = zl_get_proto_impl(ZLMainModuleProto);
    UIViewController *mainVC = [impl mainVC];
    [self.navigationController pushViewController:mainVC animated:YES];
}

@end
