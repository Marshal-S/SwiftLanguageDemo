//
//  BaseLanguageModel.swift
//  SwiftDemo
//
//  Created by Marshal on 2021/11/30.
//  介绍基本语法内容

import UIKit

//定义枚举
enum TestEmum {
    case TestEnum1
    case TestEnum2
    case TestEnum3
}

//定义代值枚举，不写值默认从0开始，写了从给的值开始
enum TestValueEmum: Int {
    case TestEnum1 = 1,
         TestEnum2, //2
         TestEnum3 //3
    
    case TestEnum4 //4
    
    case TestEnum5 = 100,
         TestEnum6 //这里就是101了
}
class BaseLanguageModel: NSObject {
    
    //对象方法
    func baseLanguage1() {
    }
    
    //类方法
    static func baseLanguage() {
        //let 声明常量，可修改，相当于js中的const
        let a = 0 //类型推断，相当于 let a: Int = 0
        //let a: Int = 0
        let b = 0, c = 1 //可以同时声明好几个
        //a = 5; //let修饰无法更改
        
        //var 声明变量,可修改,相当于js中的let
        var a1 = 0
        a1 = 3;
        print("输出一下变量:\(a1)   常量：\(a) \(b) \(c)")
        
        
        //声明类型
        var d: Double
        //声明的同时进行赋值
        var d1: Double = 10
        
        var d2 = 10 //这里类型推断为Int
        d = 10 + 3.2
        print(Int(d)); //转化成指定类型
        //Int8.max Int8.min; //这些类都有最大最小值
        
        
        //类型别名，特殊场景有奇效，例如下面的颜色范围
        typealias ColorNmber = UInt8
        let a3: ColorNmber = 10;
        
        
        //元组的初始化与赋值
        let numTuple = (1, 2, 4)
        let mixTuple = (1, "字符串")
        let mixTuple1:(Int, String) = (1, "字符串")
        let (num1, string1) = mixTuple //展开元组赋值
        print("num1:\(num1) -- string1:\(string1)")
        
        
        //可选项，即这个选项可能有值，可能没值(nil)
        var a10: Int? = 404
        a10 = nil
        
        //可选项绑定（用来判断是否包含值）
        //正常情况使用a10时需要判断
        //注意判断条件只能以 true和false类型来判断
        if a10 != nil {} // if (a10 != nil) {} //根据习惯是否省略括号
        else {}
        //可选项绑定判断语句，与生面的式子相同,即成功展开就走后面括号
        if let newA10 = a10 {}
        else {}
        
        //隐式展开可选项
        //主要针对一旦赋值，值就不会在改变的情况
        //默认使用可选项时
        let s1: String? = "123123123" //我是一个可选项
        //这样就强展开s1，不写感叹号就会报错哈，如果可选项没有值，会崩溃
        //强展开适合一旦赋值就不会改变的，正常使用就得用上面的if判断处理
        let s2: String = s1!
        //隐式展开可选项类型!，适合一旦赋值就不会改变的
        var s3: String! = nil
        //开始赋值，不再更改
        s3 = "展开就开了没事了"
        let s4: String = s3
        
        
        //合并运算符
        let s5 = s1 ?? s3 //使用条件s1，必须是可选项，s1有值，赋值展开可选项的s1，否则赋值s3
        
        //扩展：如果可选项是一个类
        //那么正常访问，就可以通过?.来访问其内部属性，甚至可以a?[1]可选下标来访问
        //强制访问就可以通过!.来访问其内部属性(同样适合一旦赋值就一直存在的)
        
        //运算符
        //三目运算符
        var a20 = 10 < 20 ? 5 : 10 //?前面条件满足赋值:前面的值，否则赋值:后面的值
        //合并运算符
        a20 = a ?? b //使用条件a，必须是可选项，a有值，赋值展开可选项的a，否则赋值b
        
        //区间运算符 ...(闭区间)和 ..<(右半开区间)
        for index in 1...5 {
            print(index)
        }
        for index in 1..<6 {
            print(index)
        }
        //单侧区间，可以展开数组选项，到某个索引，或者从某个索引开始
        let list = [1, 2, 3, 4]
        for item in list[...2] {
            //运行到第二个
            print(item)
        }
        for item in list[1...] {
            //从第一个开始
            print(item)
        }
        
        //_为忽略标识，用来做简化操作的，很多地方会有意想不到的效果
        _ = 10 //let aa = 10 不使用声明的参数时可以代替，还有若干
        
        //顺便提一下
        //_忽略标识 ?判断标识或可选项标识 !隐式展开可选项
        
        
        //字符串
        var s10: String = ""
        s10 = "卡萨丁副卡就熬---"
        //拼接字符串,只能字符串拼接字符串
        s10 += "哈哈哈哈"
        s10 = s10 + "测试一个不可变字符串"
        s10.append("哈哈哈哈") //再其后面拼接新的字符串
        s10 = s10.appendingFormat("sdfasd%ld", 5) //拼接格式化字符串，返回新的字符串
        //字符串中嵌套变量，以形成新的字符串，数字字符串都可以
        let s12 = "哈哈哈\(a)--\(s10)"
        
        s10.count;//字符串长度，已经不是length了
        s10.isEmpty;
        let s11 = s10.reversed() //逆序
        let strList = s10.split(separator: " ") //分割字符串到集合中
        
        //索引，字符串访问子字符需要用到索引，不能用1，2，3等代替
        //字符串开头索引
        s10.startIndex;
        //字符串结束位置,与length一致
        s10.endIndex
        //获取指定索引前面的字符(参数是第一个字符索引)
        s10.index(after: s10.startIndex)
        //获取指定索引后面的字符(参数是最后一个字符索引)
        s10.index(before: s10.endIndex)
        //获取指定索引位置，偏移指定长度的字符(这里从开始向后偏移0长度)
        s10.index(s10.startIndex, offsetBy: 0)
        //获取指定索引字符，参数是字符开始索引
        let subcs10 = s10[s10.startIndex]
        print("subcs10", subcs10)
        let subss10 = s10[s10.startIndex..<s10.endIndex];
        //可以将SubString类型子串转化成String
        print("subss10", String(subss10))
        
        //插入和删除
        //插入单个字符到某个索引处
        s10.insert("0", at: s10.startIndex)
        //插入子串到某个索引出
        s10.insert(contentsOf: "哈哈哈哈", at: s10.startIndex)
        //删除某个索引的字符
        s10.remove(at: s10.startIndex)
        //删除指定索引范围的子串(不要忘了区间运算符)
        s10.removeSubrange(s10.startIndex..<s10.endIndex)
        //s10.removeSubrange(s10.startIndex...s10.endIndex)
        
        //比较两个字符串是否相等，
        if s10 == s12 {}
        if s10 != s12 {}
        
        //顺便提一下，比较两个变量或者常量，是否引用了同一个类的实例(对象) === !==
        //判断两个自定义类等价也可以使用 == 前提是继承了NSObject类或者自己遵循Equatable协议
        //继承的类可以直接使用 == 判断两个类是否相等
        
        //字符串前缀和后缀
        s10.hasPrefix("lalala")
        s10.hasSuffix("lalala")
                
        //遍历字符串
        for c in s12 {
            //展开遍历字符串中的单个字符
            print(c)
        }
        //使用forEach
        s12.forEach { (c) in
            print(c)
        }
        
        
        //集合
        
        //数组 Array
        var l = [Any]() //声明空数组
//        var l: [Any] = [] //等价于上面
//        var l1: Array<Any> = []
        //创建一个重复初值的数组
        var l1 = Array(repeating: true, count: 10)
        //合并两个数组
        var l2 = l + l1
        //快速创建一个有默认值的数组
        var l3 = ["哈哈哈", "嘿嘿"]
        //创建一个多种类型子集的数组
        var l4:[Any] = ["哈哈", 3]
        //常用操作,获取、添加、插入、删除
        let firstItem = l1[0] //获取
        l1[0] = false //改动
        l.append(2)//添加
        l.insert(1, at: 1) //插入
        l.insert("sdfasd", at: 2)
        l.remove(at: 2) //l.removeLast() 删除
        l.count;
        l.isEmpty
        l = [] //类型确定，可以这种方式置空集合
        
        //遍历
        for item in l1 {}
        for (index, value) in l1.enumerated() {
            //以枚举的方式遍历带索引，索引在前，值在后
        }
        l1.forEach { (item) in
            //forEach遍历
        }
        
        //哈希集合Set
        var set = Set<String>()
//        let set: Set<String> = []  //等价于上面
        //快速创建一个有值的Set
        var set1: Set<String> = ["哈哈哈", "啦啦啦"]
        //常用操作，增删查
        set.insert("哈哈哈2")
        set1.remove("哈哈哈")
        set1.contains("哈哈哈") //查询是否有没有
        set.count
        set.isEmpty
        set = [] //置空
        //遍历
        for item in set {}
        set.forEach { (item) in
            //forEach遍历
        }
        
        
        //哈希集合Dictionary(字典) key-value哈希集合(其实就是Map)
        var map = Dictionary<Int, String>() //Map<key, value>
        //var map:Dictionary<Int, String> = [:] //等价于扇面
        //字典还可以下面这样声明，由于其key-value的形式唯一，而数组Array和哈希Set不行
        var map1 = [Int: String]()
        //根据内容快速创建 Dictionary<String:String> 类型字典,会类型推断
        var map2 = ["key1": "value1", "key2": "value2"]
        //赋值
        let firstValue = map[1] //获取内容,也可以用来当做查询
        map[1] = "哈哈" //key:1--value:"哈哈"  更新内容
        map.updateValue("哈哈", forKey: 1) //跟新内容
        map.removeValue(forKey: 1) //删除指定key
        map[1] = nil //删除指定key,value和key成对出现，一个不存在都不存在
        map = [:] //置空字典，与数组和Set不同，其为key-value形式
        
        //遍历
        for (key, value) in map {}
        for key in map.keys {}
        for value in map.values {}
        //单个接收key-value数组,无序
        let keyList = [Int](map.keys)
        let valueList = [String](map.values)
        map.forEach { (key, value) in
            //forEach遍历
        }
        
        //guard
        //其和if相反，实际主要是简化代码使用的
        //正常我们判断一个条件时，满足就走if,否则就走else
        //如果条件需要置反，则需要加括号置反，看起来比较臃肿
        //那么可以直接使用 guard
        if !(1 > 2) {
        }
        //换成 guard 可以保持原有条件，如果条件不满足，直接 else
        //比较适合一些拦截操作
        guard 1 > 2 else {
            return
        }
            
        
        //switch
        //switch默认执行一个case自动跳出,default只能在最后
        //使用fallthrough关键字，可以贯穿到后面一种情况，即可以继续执行下面的case
        let enu = TestEmum.TestEnum1;
        //可以switch + enu + {} 通过提示自动补全case
        switch enu {
            case .TestEnum1:
                print(TestEmum.TestEnum1)
//                fallthrough //使用这个关键字可以继续往后走
            case .TestEnum2, .TestEnum3: //可以通知使用多个参数
                print(TestEmum.TestEnum2)
            default:
                print(TestEmum.TestEnum3)
        }
        //switch展开范围
        let ranNum = arc4random()
        switch ranNum {
            case 1...10:
                print(1)
            case 11..<1000:
                print(11)
            case 1000..<10123213:
                print(1000)
            default:
                print(123123123123)
        }
        //switch展开元组
        let cuple:(Int, Int) = (1, 10001)
        switch cuple {
            case (1, 10):
                print("匹配值为(1, 10)的值")
            case (_, 11):
                print("匹配值为(任意值, 10)的值")
            case (10...100, 200...2000):
                print("匹配值为(指定范围, 指定范围)的值")
            default:
                print("剩下的所有都到这里吧")
        }
        
        //可以用来判断版本号，用来控制api的执行
        if #available(iOS 10, *) {}
        
    }
}
