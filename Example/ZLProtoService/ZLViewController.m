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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ZLProtoService.interceptInvokeBlock = ^(NSInvocation * _Nonnull invocation, BOOL * _Nonnull stop) {
        NSLog(@"interceptInvokeBlock");
    };
    ZLProtoService.willInvokeBlock = ^(NSInvocation * _Nonnull invocation) {
        NSLog(@"willInvokeBlock");

    };
    ZLProtoService.didInvokeBlock = ^(NSInvocation * _Nonnull invocation) {
        NSLog(@"didInvokeBlock");

    };
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)jumpModul1:(id)sender {
    id<ZLTestModule1Proto> impl1 = ZLGET_PROTO_IMPL(ZLTestModule1Proto);
    UIViewController *vc1 = [impl1 jumpVC1];
    [self.navigationController pushViewController:vc1 animated:YES];
}

@end
