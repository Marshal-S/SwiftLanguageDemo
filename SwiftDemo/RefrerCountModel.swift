//
//  RefrerCountModel.swift
//  SwiftDemo
//
//  Created by Marshal on 2021/12/8.
//  引用计数问题，解决内存泄露问题

import UIKit

class RefrerCountModel {
    var name: String?
    //weak 弱引用关键字，能有效避免强引用导致的内存泄露问题
    //由于weak修饰的关键字的值问题，所以一定为可选类型
    weak var delegate: NSObject? = nil //为了避免强引用
    
    //unowned 无主引用，与oc中的unsafe_unretained相似
    //可以理解为纯粹一个指针，没有进行retain等相关操作，也不会像弱引用会释放置空
    //其指向指定内存区域，对象释放后调用容易出现野指针问题
    //另外其为非可选类型，不能赋值为nil，需要初始化时(init)赋指定值
    unowned let delegate1: NSObject
    
    init(obj: NSObject) {
        delegate1 = obj
    }
    
    //解决闭包的内存泄露
    func setup() {
        //可以在闭包的参数前面添加中括号，可以在里面定义多个变量，如下所示这样就可以解决内存泄露了
        //下面的self定义一个就可以了
        let block = { [unowned self, weak wself = self, weak delegate = self.delegate1]() in
            print("我是测试的闭包")
            self.delegate = nil
        }
        
        block()
    }
}
