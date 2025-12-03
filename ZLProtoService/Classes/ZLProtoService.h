//
//  ZLProtoService.h
//  ZLProtoService
//
//  Created by admin on 2025/12/3.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@protocol ZLImplProto <NSObject>
+ (id)share;
@end

@interface ZLImplProxy : NSProxy
+ (ZLImplProxy *)proxyImpl:(NSObject *)impl;
@end

@interface ZLProtoService : NSObject
/// 拦截调用（可中断）
@property (class) void(^interceptInvokeBlock)(NSInvocation *invocation, BOOL *stop);
/// 方法调用前置回调
@property (class) void(^willInvokeBlock)(NSInvocation *invocation);
/// 方法调用后置回调
@property (class) void(^didInvokeBlock)(NSInvocation *invocation);
/// 1. 根据协议获取其实现类,如果没有注册会自动尝试获取协议名拼接Impl的类对象，例如传入ZLProtocol会获取对应ZLProtocolImpl类
+ (Class)classForProtocol:(Protocol *)protocol;
/// 2. 注册协议与实现类
+ (void)registerProtocol:(Protocol *)protocol implClass:(Class)implClass;
/// 3. 获取协议对应的实例对象,优先读缓存
+ (id )instanceForProtocol:(Protocol *)protocol;
/// 4.是否从缓存获取协议对应的实例对象
+ (id )instanceForProtocol:(Protocol *)protocol shouldCache:(BOOL)shouldCache;
@end

///注册协议
#define ZLRegisterProtoForClass(protocolName, cls) \
__attribute__((constructor)) \
static void _ZLRegisterProtocol_##cls(void) { \
    [ZLProtoService registerProtocol:@protocol(protocolName) implClass:[cls class]]; \
}

///根据协议获取实现对象
#define ZLGET_PROTO_IMPL(p) [ZLProtoService instanceForProtocol:@protocol(p)]

NS_ASSUME_NONNULL_END
