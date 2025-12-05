//
//  ZLProtoService.m
//  ZLProtoService
//
//  Created by admin on 2025/12/3.
//

#import "ZLProtoService.h"
static ZLProtoService *instance;
@interface ZLImplProxy()
@property (nonatomic,strong,readwrite)NSObject* impl;
@end
@implementation ZLImplProxy
+ (id)proxyImpl:(NSObject *)impl {
    ZLImplProxy *proxy = [ZLImplProxy alloc];
    proxy.impl = impl;
    return proxy;
}
- (BOOL)respondsToSelector:(SEL)aSelector {
    return [self.impl respondsToSelector:aSelector];
}
- (BOOL)isKindOfClass:(Class)aClass {
    return [self.impl isKindOfClass:aClass];
}
- (BOOL)isMemberOfClass:(Class)aClass {
    return [self.impl isMemberOfClass:aClass];
}

- (Class)class {
    return self.impl.class;
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    BOOL stop = NO;
    if (ZLProtoService.interceptInvokeBlock) {
        ZLProtoService.interceptInvokeBlock(invocation,&stop);
    }
    if (stop) return;
    if (ZLProtoService.willInvokeBlock) {
        ZLProtoService.willInvokeBlock(invocation);
    }
    [invocation invokeWithTarget:self.impl];
    if (ZLProtoService.didInvokeBlock) {
        ZLProtoService.didInvokeBlock(invocation);
    }
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSMethodSignature *signature = [self.impl methodSignatureForSelector:sel];
    return signature ? signature : [NSMethodSignature signatureWithObjCTypes:"v@:"];
    return signature;
}
@end




@interface ZLProtoService()
@property (nonatomic,strong)NSMutableDictionary<NSString *,Class> *proto_class_map;
@property (nonatomic,strong)NSMutableDictionary *proto_impl_map;
@property (nonatomic, copy) void(^interceptInvokeBlock)(NSInvocation *invocation, BOOL *stop);
@property (nonatomic, copy) void(^willInvokeBlock)(NSInvocation *invocation);
@property (nonatomic, copy) void(^didInvokeBlock)(NSInvocation *invocation);
@property (nonatomic,assign) BOOL allowOverwriteRegister; // default NO

@end
@implementation ZLProtoService
+ (instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.proto_class_map = NSMutableDictionary.dictionary;
        instance.proto_impl_map = NSMutableDictionary.dictionary;
    });
    return instance;
}

+ (void)setInterceptInvokeBlock:(void (^)(NSInvocation * _Nonnull, BOOL * _Nonnull))interceptInvokeBlock {
    ZLProtoService.share.interceptInvokeBlock = interceptInvokeBlock;
}
+ (void (^)(NSInvocation * _Nonnull, BOOL * _Nonnull))interceptInvokeBlock {
    return  ZLProtoService.share.interceptInvokeBlock;
}
+ (void)setWillInvokeBlock:(void (^)(NSInvocation * _Nonnull))willInvokeBlock {
    ZLProtoService.share.willInvokeBlock = willInvokeBlock;
}
+ (void (^)(NSInvocation * _Nonnull))willInvokeBlock {
    return ZLProtoService.share.willInvokeBlock;
}
+ (void)setDidInvokeBlock:(void (^)(NSInvocation * _Nonnull))didInvokeBlock {
    ZLProtoService.share.didInvokeBlock = didInvokeBlock;
}
+ (void (^)(NSInvocation * _Nonnull))didInvokeBlock {
    return ZLProtoService.share.didInvokeBlock;
}
+ (BOOL)allowOverwriteRegister {
    return ZLProtoService.share.allowOverwriteRegister;
}
+ (void)setAllowOverwriteRegister:(BOOL)allowOverwriteRegister {
    ZLProtoService.share.allowOverwriteRegister = allowOverwriteRegister;
}
/// 1. 根据协议获取其实现类
+ (Class)classForProtocol:(Protocol *)protocol{
    if (!protocol) return nil;
    Class cls = ZLProtoService.share.proto_class_map[NSStringFromProtocol(protocol)];
    if(!cls) {
        cls = [self defaultImplClassForProtocol:protocol];
    }
    return cls;
}
+ (Class)defaultImplClassForProtocol:(Protocol *)protocol{
    NSString *clsStr = NSStringFromProtocol(protocol);
    NSString *cls = [NSString stringWithFormat:@"%@Impl",clsStr];
    return NSClassFromString(cls);
}

/// 2. 注册协议与实现类
+ (void)registerProtocol:(Protocol *)protocol implClass:(Class)implClass{
    if ([implClass conformsToProtocol:protocol]) {
        NSString *key = NSStringFromProtocol(protocol);
        if (ZLProtoService.share.proto_class_map[key]) {
            if (!ZLProtoService.share.allowOverwriteRegister) {
                @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"协议%@已经注册过实现类%@",key,NSStringFromClass(ZLProtoService.share.proto_class_map[key])] userInfo:nil];
            }
        }
        ZLProtoService.share.proto_class_map[NSStringFromProtocol(protocol)] = implClass;
    }else {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@没有遵守%@协议",implClass,NSStringFromProtocol(protocol)] userInfo:nil];
    }
}
/// 3. 获取协议对应的实例对象
+ (id)instanceForProtocol:(Protocol *)protocol{
    return [self instanceForProtocol:protocol shouldCache:YES];
}
///
+ (id)instanceForProtocol:(Protocol *)protocol shouldCache:(BOOL)shouldCache{
    if(!protocol) return nil;
    id impl = ZLProtoService.share.proto_impl_map[NSStringFromProtocol(protocol)];
    if (impl) return impl;
    Class cls = [self classForProtocol:protocol];
    if(!cls) return nil;
    if ([cls conformsToProtocol:@protocol(ZLImplProto)]) {
        if ([cls respondsToSelector:@selector(share)]) {
            impl = [cls share];
        }else if ([cls respondsToSelector:@selector(createInstance)]){
            impl = [cls createInstance];
        }else{
            impl = [[cls alloc] init];
        }
    }else{
        impl = [[cls alloc] init];
    }
    if (shouldCache) {
        ZLProtoService.share.proto_impl_map[NSStringFromProtocol(protocol)] = impl;
    }
    return impl;
}
@end
