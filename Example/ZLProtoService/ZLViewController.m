//
//  ZLViewController.m
//  ZLProtoService
//
//  Created by fanpeng on 12/03/2025.
//  Copyright (c) 2025 fanpeng. All rights reserved.
//

#import "ZLViewController.h"
#import <ZLProtoService/ZLProtoService.h>

@protocol ZLTest <NSObject>

- (void)test;

@end

@interface ZLViewController ()<ZLTest>

@end

@implementation ZLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ZLProtoService registerProtocol:@protocol(ZLTest) implClass:ZLViewController.class];
    ZLProtoService.interceptInvokeBlock = ^(NSInvocation * _Nonnull invocation, BOOL * _Nonnull stop) {
        *stop = YES;
        NSLog(@"interceptInvokeBlock");
    };
    ZLProtoService.willInvokeBlock = ^(NSInvocation * _Nonnull invocation) {
        NSLog(@"willInvokeBlock");

    };
    ZLProtoService.didInvokeBlock = ^(NSInvocation * _Nonnull invocation) {
        NSLog(@"didInvokeBlock");

    };
    id<ZLTest> impl = GET_PROTO_IMPL(@protocol(ZLTest));
    [impl test];
}
- (void)test {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
