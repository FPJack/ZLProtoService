//
//  test.swift
//  ZLProtoService_Example
//
//  Created by admin on 2025/12/4.
//  Copyright © 2025 fanpeng. All rights reserved.
//

import Foundation

///swift通过懒加载无感注册最方便,定义一个协议名，协议的实现对象 = 协议名 + Impl 
@objc
protocol SwiftTest: NSObjectProtocol {
    func getSwiftVC() -> UIViewController
}
@objc class SwiftTestImpl: NSObject,SwiftTest {
    func getSwiftVC() -> UIViewController {
        let impl = ZLProtoService.instance(for: SwiftTest.self) as! SwiftTest
        impl.getSwiftVC()
        
        
        return SwiftViewController()
    }
}


