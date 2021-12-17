//
//  AsyncAwaitModel.swift
//  SwiftDemo
//
//  Created by Marshal on 2021/12/6.
//  并行

import UIKit


//这里的并行同 javasscript中async与await的有些相似
//在函数参数括号后面，返回值前面，加上 aysnc 关键字 即异步调用
//异步函数调用时，可以使用 await 关键字阻塞等待，会阻塞调用者的函数，
//因此使用await需要两个异步函数
class AsyncAwaitModel: NSObject {
    var baseName: String?
    var name: String? {
        //set async {
        set {
            baseName = newValue
        }
        get {
           "就测试一下"
        }
    }
    
    func setup() {
        //NSOperation
        let o = OperationQueue()
        o.maxConcurrentOperationCount = 10
        o.addOperation {
            print("我是异步方法了")
        }

        //GCD
        DispatchQueue.global().async {
            print("我也是异步方法了")
        }
        //使用栅栏函数，注意需要在一个queue中，且不能为 global，这里只是案例
        DispatchQueue.global().async(flags: .barrier, execute: {
            print("我是栅栏函数，我不执行完毕，后面的别想动")
        })
    }
    
    func function0() {
        //同步函数，不能使用await
        self.function1()
        DispatchQueue.global().async(flags: .barrier, execute: {
            
        })
    }
    func function1() -> Int {
        return 10
    }
    
    //需要至少xcode13版本，否则直接报错
    //注意ios15版本才能这么使用，因此不建议使用，使用场景
    //ios15以及之后的小工具或者新功能体验版本可以使用
//    @available(iOS 15.0.0, *)
//    func function0() async {
//        //异步函数才能使用await,同步函数不能使用
//        let res = await self.function1()
//    }
//    @available(iOS 15.0.0, *)
//    func function1() async -> Int {
//        return 10
//    }
}
