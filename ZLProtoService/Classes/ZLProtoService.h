//
//  ZLProtoService.h
//  ZLProtoService
//
//  Created by admin on 2025/12/3.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@protocol ZLImplProto <NSObject>
///如果要实现单例和自定义实例化方式，可以实现下面两个方法
// Singleton单例实现
+ (instancetype)share;
// 普通创建实例
+ (instancetype)createInstance;
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

/// 是否允许覆盖注册实现类
@property (class) BOOL allowOverwriteRegister; // default NO
/// 1. 根据协议获取其实现类,如果没有注册会自动尝试获取协议名拼接Impl的类对象，例如传入ZLProtocol会获取对应ZLProtocolImpl类
+ (Class)classForProtocol:(Protocol *)protocol;

/// 1.1 默认的协议实现类获取方式 协议名 + Impl
+ (Class)defaultImplClassForProtocol:(Protocol *)protocol;

/// 2. 注册协议与实现类
+ (void)registerProtocol:(Protocol *)protocol implClass:(Class)implClass;
/// 3. 获取协议对应的实例对象,优先读缓存
+ (id )instanceForProtocol:(Protocol *)protocol;
/// 4.获取协议对应的实例对象,是否缓存起来
+ (id )instanceForProtocol:(Protocol *)protocol shouldCache:(BOOL)shouldCache;
@end

///注册协议
#define zl_register_proto_for_class(protocolName, cls) \
__attribute__((constructor)) \
static void _ZLRegisterProtocol_##cls(void) { \
    [ZLProtoService registerProtocol:@protocol(protocolName) implClass:[cls class]]; \
}

///根据协议获取实现对象
#define zl_get_proto_impl(p) [ZLProtoService instanceForProtocol:@protocol(p)]

///根据协议获取实现对象的代理,方法调用的时候可进行拦截
#define zl_get_proto_proxy_impl(p) [ZLImplProxy proxyImpl:[ZLProtoService instanceForProtocol:@protocol(p)]]


NS_ASSUME_NONNULL_END
