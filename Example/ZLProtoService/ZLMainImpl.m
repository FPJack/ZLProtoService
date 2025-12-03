//
//  ZLMainImpl.m
//  ZLProtoService_Example
//
//  Created by admin on 2025/12/3.
//  Copyright © 2025 fanpeng. All rights reserved.
//

#import "ZLMainImpl.h"
#import "ZLViewController.h"

zl_register_proto_for_class(ZLMainModuleProto, ZLMainImpl)
@implementation ZLMainImpl
- (UIViewController *)mainVC {
    return ZLViewController.new;
}
@end
