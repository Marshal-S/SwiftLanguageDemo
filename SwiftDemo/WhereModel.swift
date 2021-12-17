//
//  WhereModel.swift
//  SwiftDemo
//
//  Created by Marshal on 2021/12/17.
//  where 条件语句


import UIKit

//where 条件语句，一般用在协议扩展约束，泛型约束，遍历语句中使用

//swift中目前没有可选协议(可实现、也可不实现)，可以使用extersion默认实现协议
protocol whereDefaultProtocol {
    func testPrint()
}
//给该协议扩展实现协议，协议扩展的方法拥有了可选效果，适用所有遵循该协议类
extension whereDefaultProtocol {
    func testPrint() {
        print("我扩展了协议的方法")
    }
}
//如果不想所有遵循该协议类都使用实现该可选效果，那么可以使用where语句
//当遵循协议的类为 UIView 才会扩展此类
extension whereDefaultProtocol where Self:UIView{
    func testPrint() {
        print("我扩展了协议的方法，仅仅在UIView或者其子类才能实现可选效果")
    }
}


//泛型约束，即遵循协议的泛型，where 语句也可以实现同样效果
//不过推荐默认的泛型约束，这里作为了解
protocol genericityProtocol {
}
//通过where实现泛型类型约束，作为了解，不推荐
class WhereModel1<element>: NSObject where element: genericityProtocol {
    //通过 where 约束默认泛型函数
    func swap<T>(_ a: inout T, _ b: inout T) where T: genericityProtocol {
        //实现交换
    }
}
//泛型约束推荐写法，简洁明了，推荐
class WhereModel2<element: genericityProtocol>: NSObject {
    //通过 where 约束默认泛型函数
    func swap<T: genericityProtocol>(_ a: inout T, _ b: inout T) {
        //实现交换
    }
}


//where语句用于遍历时判断，比较常见，可以减少循环内部的嵌套层数
class WhereModel {
    func setup() {
        let list = [1, 2, 3, 4, 5]
        
        //可以将判断语句写到后面，可以减少循环内部的嵌套层数
        for item in list where item > 3 {
        }
        //相当于
        for item in list {
            if (item > 3) {
                
            }
        }
    }
}
