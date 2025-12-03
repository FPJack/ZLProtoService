# ZLProtoService

[![CI Status](https://img.shields.io/travis/fanpeng/ZLProtoService.svg?style=flat)](https://travis-ci.org/fanpeng/ZLProtoService)
[![Version](https://img.shields.io/cocoapods/v/ZLProtoService.svg?style=flat)](https://cocoapods.org/pods/ZLProtoService)
[![License](https://img.shields.io/cocoapods/l/ZLProtoService.svg?style=flat)](https://cocoapods.org/pods/ZLProtoService)
[![Platform](https://img.shields.io/cocoapods/p/ZLProtoService.svg?style=flat)](https://cocoapods.org/pods/ZLProtoService)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ZLProtoService is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZLProtoService'
```
### 注册协议与实现类
```ruby

@protocol ZLTest
- (void)test;
@end


[ZLProtoService registerProtocol:@protocol(ZLTest) implClass:ZLTestModule1VC.class];

```


### 通过协议获取实现类实例
```ruby
 id<ZLTest> impl = [ZLProtoService instanceForProtocol:@protocol(ZLTest)];
 [impl test];
 
```

### 宏定义写法
```ruby
   注册协议与实现类
    zl_register_proto_for_class(ZLTest, ZLTestModule1VC);
    
    通过协议获取实现类实例
    id<ZLTest> impl = zl_instance_for_proto(ZLTest);
    [impl test];
    
   通过协议获取实现类实例代理对象
    id<ZLTest> implProxy = zl_instance_proxy_for_proto(ZLTest);
    [implProxy test];
 
```



## Author

fanpeng, peng.fan@ukelink.com

## License

ZLProtoService is available under the MIT license. See the LICENSE file for more info.
