//
//  FunctionModel.swift
//  SwiftDemo
//
//  Created by Marshal on 2021/12/2.
//  介绍函数

import UIKit

class FunctionModel: NSObject {
    var name: String?

    //我是类方法
    static func setup() {
    }
    
    //我是对象方法
    func setup() {
        //默认函数介绍
        self.defaultFunction()
        
        //带参函数介绍（标签和参数名一致）
        print(self.function1(str1: "1", str2: "2"))
        //带参函数介绍（标签和参数不一致）
        NSLog(self.function2(prefixStr: "1", suffixStr: "2"))
        //省略标签函数
        NSLog(self.function3("1", "2"))
        //带默认值的函数介绍
        print(self.function4(str2: "我没有默认值"))
        print(self.function4(str1: "不使用默认值了", str2: "我没有默认值"))
        //带默认值，且省略标签的，须按照顺序传递
        print(self.function5(str1: "哈哈哈", "哈哈哈"))
        //可变参数传递(声明一个参数，可以同时传递多个参数，会接收到一个集合中)
        self.function6("啦啦啦", "啦啦啦", "我是第三个参数了", item2: 5)
        
        //inout声明参数，可以将外部的变量地址传入，在函数内部修改外部也生效
        var a = 20
        self.function7(num1: &a)
        print(a)
        
        //如果函数只有一行赋值内容，返回时可以省略return
        print(self.function8(num: 10))
        
        //返回函数类型参数(返回结果作为函数，可以直接调用，但是没有标签)
        self.functionReturnFunction()(1)
        
        //函数重载
        self.loadedFunction(num: a)
        
        //内联函数
        _ = self.inlineFunction(num1: 1, num2: 1)
        
        //内嵌函数(函数内部声明函数)
        self.functionSub()
        
        //闭包，尾随闭包、逃逸闭包、自动闭包
        self.closePackFunction()
    }

    //定义一个无返回值的函数，下面三个都一样
    //可以看到省略的返回值等同于 void等同于空元祖
    //void的定义 public typealias Void = ()
    func defaultFunction() {
    }
    func defaultFunction1() -> Void {
    }
    func defaultFunction2() -> () {
    }
    
    //基本函数定义
    //定义一个标签和参数一致的函数，推荐使用，
    func function1(str1: String, str2: String) -> String {
        return str1 + str2
    }
    //定义标签和参数不一致的函数，特殊情况下不同地方表达意思不一致可以使用
    func function2(prefixStr str1: String,suffixStr str2: String) -> String {
        return str1 + str2
    }
    //隐藏参数名称，和object-c调用一样，有这个习惯的可以使用
    func function3(_ str1: String,_ str2: String) -> String {
        return str1 + str2
    }
    //设置带有默认值的，有默认值的参数可以不传递
    func function4(str1: String = "我有默认值：", str2: String) -> String {
        return str1 + str2
    }
    //设置带有默认值的，省略标签的，那么必须按照顺序传递，否则系统无法分清是传的哪个参数
    func function5(str1: String = "我有默认值：",_ str2: String) -> String {
        return str1 + str2
    }
    //可变参数，即可以想NSLog似的传递多个参数，传递的参数组合成一个Any类型的数组
    //后面的参数不可以使用 _省略标签，否则会报错
    func function6(_ item1: Any..., item2: Any) {
        print(item1)
    }
    //inout可以声明参数指向的内容，可以在函数内部被修改，即犹如传递了一个指针过来
    func function7(num1: inout Int) -> Void {
        num1 += 10
    }
    
    //返回值为Int类型
    func function8(num: Int) -> Int {
        //如果只有一行内容，则可以省略return
        num + 1
//        return num + 1
    }
    
    //函数重载，同名方法，参数种类不同(标签、类型、数量、顺序等不同)，与返回类型无关
    func loadedFunction(num: Int) {
    }
    //类型不同
    func loadedFunction(num: Double) -> Void {
    }
    //标签不同
    func loadedFunction(_ num1: Int) -> Void {
    }
    func loadedFunction(num1: Int) -> Void {
    }
    func loadedFunction(num2 num: Int) -> Void {
    }
    //数量不同
    func loadedFunction(num: Int, num1: Int) {
    }
    //顺序不同
    func loadedFunction(num1: Int, num: Int) -> Void {
    }
    
    //传入参数为函数类型，可以使得一些代码更灵活，例如：排序算法，可以传递一个函数，通过外部函数排序(sort)
    func functionReturnFunction(sortBlock: (Int, Int) -> Void) {
        let a = 10
        let b = 20
        sortBlock(a, b)
    }
    //返回值为函数类型，即返回的是一个函数指针，可以返回的函数，直接调用该函数，有时候可以简化一些代码的使用
    func functionReturnFunction() -> (Int) -> Void {
        return loadedFunction(num:) //返回一个函数要带标签
        return loadedFunction(_:) //没标签带上_
    }
    
    //强制内联，内部函数就像宏定义一样被替换调用方法使用，调用方法时不会开辟函数栈
    @inline(__always) func inlineFunction(num1: Int, num2: Int) -> Int {
        return num1 + num2
    }
    
    //内嵌函数，一般仅仅用来减少一个功能块的重复代码或递归调用
    func functionSub() {
        func sub1() {
            
        }
        //减少模块重复代码调用，一般外部不复用
        sub1()
        print(123)
        sub1()
        
        //递归，可以使得功能更为集中
        var a = 0
        func sub2() {
            a += 1
            if (a < 1000) {
                sub2()
            }
        }
    }
    
    //内嵌闭包函数
    func funcionPack() {
        //闭包的实现定义如下所示
        //即 参数 + in + 实现
        let block = { num in
            print(num)
        }
        let block1 = { () in
            print("无参函数")
        }
        //与普通变量不一样的是，如果是属性引用的block,那么block可能会出现循环引用
        //如下所示，可以使用 unowned或者weak 关键字在参数前面，定义unowned类型self
        //此时在使用self就不会循环引用了，另外[]内重支持定义多个参数
        let block2 = { [unowned self]() in
            if let name = self.name {
                print(name)
            }
        }
        block(1)
        block1()
        block2()
    }
    
    //闭包函数，和block一样，可以简化一些方法调用和实现
    func closePackFunction() {
        //排序
        func sort1(_ num1: Int, _ num2: Int) -> Bool {
            return num1 < num2
        }
        var nums = [2, 3, 5, 1, 2, 4, 10, 6]
        nums.sort(by: sort1(_:_:)) //通过sort1函数对数组内容进行排序
        
        //闭包函数，这样也完成了闭包函数，这展开的是一个尾随闭包（推荐使用）
        nums.sort { (num1, num2) in
            return num1 < num2
        }
        //因为有类型推断，以及隐藏参数简化闭包，通过运算符简化，其中$0、$1表示第几个参数(实际不推荐这么玩，可读性差)
        nums.sort { num1, num2 in num1 < num2}
        nums.sort(by: {$0 > $1})
        nums.sort(by: >)
        
        //正常闭包
        self.tailClosePackFunction1(closePack: { (num) -> Bool in
            return num > 0
        }, num: 0)
        //尾随闭包,传入的闭包参数在前，后面有参数
        //会发现第一个闭包参数跑到了最后实现，正常参数都在前面括号里面
        self.tailClosePackFunction(num: 10) { (num) -> Bool in
            return num > 0
        }
        //尾随闭包，没有正常参数时，参数小括号都消失了
        //只要最后几个都是闭包，也可以一次性展开，这种情况网路请求中很常见
        self.tailClosePackFunction2 { (num) -> Bool in
            return true
        } failure: { (num) -> Bool in
            return false
        }

        //逃逸闭包，在传入的函数结束前没有执行闭包，需要使用 @escaping 修饰闭包类型，否则会报错
        self.functionWithEscapingClosure {
            print("我就是逃逸闭包")
        }
        
        //传入的不带参的普通闭包
        self.functionNormal { () in
            "我就是传入的不带参闭包"
        }
        //自动闭包，适用于无参闭包，需使用 @autoclosure 修饰闭包类型
        self.functionAuto1(pack: "我就是自动闭包，简单吧")
        self.functionAuto1(pack: self.description)
    }
    
    //声明一个普通闭包函数
    func tailClosePackFunction(num: Int, closePack: ((Int) -> Bool)) {
    }
    //声明一个尾随闭包函数
    func tailClosePackFunction1(closePack: ((Int) -> Bool), num: Int) {
    }
    func tailClosePackFunction2(success: ((Int) -> Bool), failure: ((Int) -> Bool)) {
    }
    
    //逃逸闭包，在传入的函数结束前没有执行闭包，需要使用 @escaping 修饰，否则会报错
    //即：如果传入的闭包，在函数执行过程中没有立即使用，而是被保存起来或者延迟时使用，就叫做逃逸闭包
    var completionHandlers: [() -> Void] = []
    func functionWithEscapingClosure(completionHandler: @escaping () -> Void) {
        completionHandlers.append(completionHandler)
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            completionHandler()
        }
    }
    
    //自动闭包，传入时不接受带参闭包，当他被调用时，可以直接使用返回表达式的值，即 return 的值
    //不带参的普通闭包
    func functionNormal(pack: ()-> String) {
        let str = pack()
        print(str)
    }
    //不带参的自动闭包
    func functionAuto1(pack: @autoclosure ()-> String) {
        let str = pack()
        print(str)
    }
}
