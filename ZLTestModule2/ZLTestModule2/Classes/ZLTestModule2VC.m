//
//  ZLTestModule2VC.m
//  ZLTestModule1
//
//  Created by admin on 2025/12/3.
//

#import "ZLTestModule2VC.h"



#import <ZLProtoService/ZLProtoService.h>
#import <ZLProtocols/ZLTestModule2Proto.h>
#import <ZLProtocols/ZLTestModule3Proto.h>

@interface ZLTestImpl2 : NSObject<ZLTestModule2Proto>
@end
zl_register_proto_for_class(ZLTestModule2Proto, ZLTestImpl2)
@implementation ZLTestImpl2
- (UIViewController *)jumpVC2{
    return ZLTestModule2VC.new;
}
@end

@interface ZLTestModule2VC ()

@end

@implementation ZLTestModule2VC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.redColor;

    // 1️⃣ 创建按钮
    UIButton *jumpButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [jumpButton setTitle:@"跳转组件3" forState:UIControlStateNormal];
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
    id<ZLTestModule3Proto> impl3 = zl_get_proto_impl(ZLTestModule3Proto);
    UIViewController *vc3 = [impl3 jumpVC3];
    [self.navigationController pushViewController:vc3 animated:YES];
}

@end
