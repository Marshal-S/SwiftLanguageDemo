//
//  OperatorFuctionModel.swift
//  SwiftDemo
//
//  Created by Marshal on 2021/12/9.
//  高级运算符，自定义运算符相关
//  运算符使用的都是系统已经有的默认的运算符，不能使用特殊字符作为运算符
//  注意，运算符的结合优先级与系统中的默认优先级一致(例如:四则运算)

import UIKit

//prefix，只和左侧的结合,同理，postfix之和右侧结合，infix为中间符号和两边结合
//prefix、infix或者 postfix的使用
//方法不声明默认为中间符号 infix，也无需使用infix修饰，修饰会报错

//在swift你会发现，Int之类的已经是一个结构体了，而不是c基本类型
//swift中,数字自增没有++和--了，我们给Int扩展一个++和--吧(由于swift返回值问题，不推荐)
extension Int {
    //增加++前缀
    static prefix func ++(num: inout Int) -> Int {
        num += 1
        return num
    }
    //增加++后缀
    static postfix func ++(num: inout Int) -> Int{
        num += 1
        return num - 1
    }
    //增加--前缀
    static prefix func --(num: inout Int) -> Int {
        num -= 1
        return num
    }
    //增加--后缀
    static postfix func --(num: inout Int) -> Int{
        num -= 1
        return num + 1
    }
}
//在扩展一个结构体的负号吧,以及正常+,-
extension CGSize {
    //扩展一个-的结构体，给一个结构体取-
    static prefix func -(value: CGSize) -> CGSize {
        CGSize(width: -value.width, height: -value.height)
    }
    //新增正常运算符，默认中缀infix,不用标识,标识会报错
    static func +(left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: left.width + right.width, height: left.height + right.height)
    }
    static func -(left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: left.width - right.width, height: left.height - right.height)
    }
    //组合赋值运算符 += -=, 另外刚扩展的运算符也可以自己使用
    static func +=(left: inout CGSize, right: CGSize) {
        left = left + right
    }
    static func -=(left: inout CGSize, right: CGSize) {
        left = left - right
    }
    //等价运算符 ==，默认的数字自己实现了等价运算符功能 ==
    //自定义类，继承NSObject 或者 自己遵循 Equatable协议，可以直接重写
    //注意：NSObject已经遵循Equaltable协议，因此继承后无需再次实现
    //当然也可以不继承，不遵循Equatable协议，直接写也没问题
    static func ==(left: CGSize, right: CGSize) -> Bool {
        left.width == right.width && left.height == right.height
    }
}


//自定义中缀运算符 infix，前后缀不支持各种自定义
//新增系统没有运算符要在全局作用域内，使用 operator 关键字手动声明

//设置中缀***的结合和优先级,默认类型是precedencegroup类型
//系统默认提供了一些类型，可以输入 precedence 根据提示来查看
infix operator **** : DefaultPrecedence

//precedencegroup也可以自定义，不使用系统的
precedencegroup CGSizePrecedenceTest {
    associativity: left //默认同优先级左结合，和加减一样，或者乘除
    lowerThan: MultiplicationPrecedence //优先级低于乘号
    higherThan: AdditionPrecedence //优先级高于加号
}
//associativity表示的结合位置 left、right、none
//lowerThan、higherThan 表示的是优先级，可以跟系统优先级进行对比
//如果优先级跟系统的一致，就直接继承系统的即可
//相同优先级条件下，做结合就跟正常的加减乘除一样，同优先级从左往右算

//设置中缀+++的结合和优先级
precedencegroup CGSizePrecedenceAdd {
    associativity: left //默认同优先级左结合，和加减一样，或者乘除
    lowerThan: AdditionPrecedence //优先级低于加号
}
//设置中缀**的结合和优先级
precedencegroup CGSizePrecedenceMuti {
    associativity: left
    //优先级低于乘法高于加法
    lowerThan: MultiplicationPrecedence
    higherThan: AdditionPrecedence
}
//设置后缀+++的结合和优先级
precedencegroup CGSizePrecedenceAddAdd {
    //优先级高于乘法
    higherThan: MultiplicationPrecedence
}

//下面对CGSize子定义几个功能,相信更容易理解
infix operator ++ : CGSizePrecedenceAdd //左右相加
infix operator ** : CGSizePrecedenceMuti //左右相加相乘
infix operator ++++: CGSizePrecedenceAddAdd //相互相加两次
extension CGSize {
    static func ++(left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: left.width + right.width, height: left.height + right.height)
    }
    static func **(left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: left.width * right.width, height: left.height * right.height)
    }
    static func ++++(left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: (left.width + right.width) * 2, height: (left.height + right.height) * 2)
    }
}


//测试用的类
class OperatorFuctionModel {
    var name: String?
    func test() {
        var num: Int = 10
        num++
        print("num", num)
        num--
        print("num", num)
        let size = CGSize(width: 10, height: 10)
        let newSize = -size
        print("newSize", newSize, "size", size)
        
        var size1 = CGSize(width: 10, height: 20)
        size1 = (size1 ++ size1) //优先级比加号还低，需要加括号保险
        size1 = size1 ** size1
        size1 = size1 ++++ size1
    }
}


