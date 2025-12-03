//
//  ZLTestModule1VC.m
//  ZLTestModule1
//
//  Created by admin on 2025/12/3.
//

#import "ZLTestModule1VC.h"
#import <ZLProtoService/ZLProtoService.h>
#import <ZLProtocols/ZLTestModule1Proto.h>
#import <ZLProtocols/ZLTestModule2Proto.h>

@interface ZLTestImpl1 : NSObject<ZLTestModule1Proto>
@end
zl_register_proto_for_class(ZLTestModule1Proto, ZLTestImpl1)
@implementation ZLTestImpl1
- (UIViewController *)jumpVC1{
    return [[ZLTestModule1VC alloc] init];
    
    

}
@end

// 自动注册协议实现
@interface ZLTestModule1VC()

@end

@implementation ZLTestModule1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.orangeColor;

    // 1️⃣ 创建按钮
    UIButton *jumpButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [jumpButton setTitle:@"跳转组件2" forState:UIControlStateNormal];
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
    id<ZLTestModule2Proto> impl2 = zl_get_proto_impl(ZLTestModule2Proto);
    UIViewController *vc2 = [impl2 jumpVC2];
    [self.navigationController pushViewController:vc2 animated:YES];
}

@end
