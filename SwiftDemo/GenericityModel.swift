//
//  GenericityModel.swift
//  SwiftDemo
//
//  Created by Marshal on 2021/12/8.
//  泛型

import UIKit

//泛型

//在使用的时候，能传递任意类型参数
//其类型参数传递时，则会确定该占位类型，以便于进行类型校验
//注意：使用泛型时，T 只是一个占位符类型，使用其他字母或者单词也可以
//一般用 T，其为模板(template)的简称（一般使用从T开始，例如：T、U、V，然后往后排）
class GenericityModel {
    //当交换两个数字的时候，这样做就很不通用，Int, double等，需要重复好几个，就很麻烦
    func swapNumber(_ swapA: inout Int, _ swapB: inout Int) {
        let tem = swapA
        swapA = swapB
        swapB = tem
    }
    //使用泛型解决,这样传递任意类型都可以了
    //注意：这里的 T 只是一个占位符类型，使用其他字母也可以
    //一般用 T 其为模板(template)的简称（一般T、U、V往后排）
    func swapNumber2<T>(_ swapA: inout T, _ swapB: inout T) {
        let tem = swapA
        swapA = swapB
        swapB = tem
    }
}


//泛型类型(创建时需要给定类型)
//定义一个栈类型结构，一个栈内只能放置同一种元素
//例如：使用泛型顶定义一个节点为任意类型，但一组对象只能使用同一种类型(如果定义成Any，则任意类型)
struct Stack<Element> {
    var elements: [Element] = []
    //push进去一个参数，放到最后(栈顶)，记得结构体改变参数需要加上mutating关键字
    mutating func push(_ item: Element) {
        elements.append(item)
    }
    //pop出栈最后一个元素(栈顶)
    mutating func pop() -> Element {
        return elements.removeLast()
    }
}


//扩展泛型，可以使用原来指定的泛型参数
//扩展一个栈顶元素
extension Stack {
    func top() -> Element {
        return elements[elements.count-1]
    }
}


//类型约束
//上面的类型虽有一定约束，使用时定义的类型仍然是非常灵活的，可以通过协议约束
//下面声明一个函数，通过制定协议进一步约束制定类型
//以上面的NewStack为例，泛型类型须遵循printProtocol协议
//默认协议(也可以认为printProtocol类型的变量)
protocol printProtocol {
    func printInfo()
}
struct NewStack<Element: printProtocol> {
    var elements: [Element] = []
    //push进去一个参数，放到最后(栈顶)，记得结构体改变参数需要加上mutating关键字
    mutating func push(_ item: Element) {
        elements.append(item)
    }
    //pop出栈最后一个元素(栈顶)
    mutating func pop() -> Element {
        return elements.removeLast()
    }
}
//定义两个遵循 printProtocol 的一个类
//也就意味着NewStack可以存放NewStackItem、NewStackItem2中的一种了
class NewStackItem: NSObject, printProtocol  {
    func function1() {
        
    }
    func printInfo() {
        print(self.description)
    }
}
class NewStackItem2: NSObject, printProtocol {
    func function2() -> Int {
        return 10
    }
    func printInfo() {
        print(self.description)
    }
}


//使用函数时传递的参数，泛型也可以指定遵循某种协议的类型
class GenericityModel1 {
    func swapNumber2<T: printProtocol>(_ swapA: inout T, _ swapB: inout T) {
        let tem = swapA
        swapA = swapB
        swapB = tem
    }
}


//关联类型
//通过associatedtype关键字关联声明一个类型，这个类型就是泛型，名字任意
protocol associateProtocol {
    //声明一个泛型关联的类型名
    associatedtype ItemType
    //追加是使用该泛型
    mutating func append(_ item: ItemType)
    //获取时使用该类型
    func get(_ index: Int) -> ItemType
    //定义下标是使用同一个类型
    subscript(_ index: Int) -> ItemType{get}
}
//遵循associateProtocol协议
//实现了协议后，所有的关联类型 ItemType 全部要设定成同一个类型
//这里直接手动将Int类型全部替换成Int了
struct associateContainer: associateProtocol {
    var list = [Int]()
    //这行可以删除，只是下面手动赋予类型即可
    typealias ItemType = Int
    mutating func append(_ item: ItemType) {
        list.append(item)
    }
    func get(_ index: Int) -> ItemType {
        list[index]
    }
    subscript(index: Int) -> ItemType {
        list[index]
    }
}
//一般会结合类型泛型使用，这里带关联类型的泛型类型的实现
//只需要定义(系统提示) typealias ItemType = Element
//然后系统提示一键展开即可实现对应类型的协议
//typealias是要给一个泛型类型重命名成当前关联类型名(这里是ItemType)
//如果只有一个关联类型(associatedtype),那么可以删除掉typealias那一行
struct associateContainer1<Element>: associateProtocol {
    var list = [Element]()
    //这行可以去掉，下面都换成Element即可,其存在可以快速生成下面协议
    typealias ItemType = Element
    //此时后面的类型，ItemType或者Element都可以
    mutating func append(_ item: Element) {
        list.append(item)
    }
    func get(_ index: Int) -> Element {
        list[index]
    }
    subscript(index: Int) -> Element {
        list[index]
    }
}


//关联类型约束（遵循协议）
//声明两个关联泛型类型，其中一个关联类型支持协议约束
//其中key需要遵循Hashable协议，value为任意类型
protocol NewAssociateProtocol {
    associatedtype Key: Hashable
    associatedtype Value
    
    mutating func appendItem(_ key: Key, value: Value)
    mutating func removeItem(_ key: Key)
    mutating func removeItem(_ value: Value)
}

//接下来我们赋值后自动展开即可
struct AssociateList<T: Hashable, U>: NewAssociateProtocol {
    var map: Dictionary<T, U> = [:]
    //可以直接删除
    typealias key = T
    typealias value = U
    //实现协议
    mutating func appendItem(_ key: T, value: U) {
        map.updateValue(value, forKey: key)
    }
    mutating func removeItem(_ key: T) {
        map.removeValue(forKey: key)
    }
    mutating func removeItem(_ value: U) {
    }
}


//测试类
class GenericityTestModel {
    func setup() {
        let model = GenericityModel()
        var a = 10, b = 20
        var d1 = 10.0, d2 = 20.0
        //使用默认的交换方法
        model.swapNumber(&a, &b)
        //model.swapNumber(&d1, &d2)//会发现不行
        
        //使用泛型定义的交换，发现都可以
        model.swapNumber2(&a, &b)
        model.swapNumber2(&d1, &d2)
        
        
        //使用了泛型的栈结构
        var stack = Stack<String>()
        stack.push("")
        stack.push("哈哈")
        _ = stack.pop()
        //stack.push(10)//此时会报错，泛型定义的类型为String类型，因此不能更新了
        
        //测试带类型约束泛型类型(遵循协议)
        var newStack = NewStack<NewStackItem>()
        newStack.push(NewStackItem())
        
        var newStack2 = NewStack<NewStackItem2>()
        newStack2.push(NewStackItem2())
        
        //测试关联类型泛型
        var container = associateContainer1<Int>()
        container.append(10)
        
        //测试带约束的关联类型(遵循协议的的关联类型)
        var associte = AssociateList<String, String>()
        associte.appendItem("key", value: "value")
        
        var associte1 = AssociateList<String, Int>()
        associte1.appendItem("key", value: 1)
        
    }
}
