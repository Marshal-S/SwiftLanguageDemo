//
//  StructClassModel.swift
//  SwiftDemo
//
//  Created by Marshal on 2021/12/3.
//

import UIKit


//struct
//struct传参是以值类型传递，与c的struct或者是int、float一样，也就意味着值传递时会重新创建一个新的
//默认属性可以赋初值，这样初始化的时候可以不传参
//如果没有给默认值，则初始化必须传值
//优缺点：以值的方式传递，不用维护引用计数，提高了效率，且对于需要深拷贝的内容很友好，但同时可能会增加了额外内存消耗，且不支持继承
struct StructModel {
    var width: Double = 0  //注意如果let修饰常量，给初始就不能修改了
    var height: Double = 0
    var cModel: ClassModel? = ClassModel.init()
}

//class
//class传参是以引用类型传递，可以理解为传值时，接受者同样引用了class对象，引用者们为多个指针类型，最终指向了创建的原class对象
//需要给默认值，可选类型可以不给，表示为nil
//优缺点：通过引用传递参数，操作同一片内存，节省内存开销，且对于不需要深拷贝的场景友好，但需要额外维护引用计数，增加了性能消耗
class ClassModel {
    var width: Double = 0
    var height: Double = 0
    var sModel: StructModel? = nil
}

//因此选用和struct代替class时，需要注意事项
//struct主要用来传递简单数据，最好不频繁修改内部属性，且传递是时值传递(对于信息需要共享的则不能更改，只会增加工作量)
//struct不存在继承行为

class StructClassModel: NSObject {
    func setup() {
        //StructModel: 允许不带值、带值、带部分值的初始化(取决于定义struct时，有没有给初值)
        var sMode1 = StructModel()
        var sMode2 = StructModel(width: 1, height: 1, cModel: nil)
        var sMode3 = StructModel(width: 1)
        sMode1.width = 20.0 //可以赋值更新
        
        //class类: 只有默认的初始化
        var cModel = ClassModel()
        cModel.width = 10 //可以赋值更新
    }
}


//属性设置，struct与class一样
struct propertyClass {
    var origin: CGPoint
    var size: CGSize
    var center: CGPoint {
        //set(newValue){}  //可以带参，如果省略会默认有newValue参数
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
        get {
            //直接使用参数或者使用get都可以
            let x = self.origin.x + self.size.width/2
            let y = self.origin.y + self.size.height/2
            return CGPoint(x: x, y: y)
            //如果只有一行赋值，可以省略 return
            //CGPoint(x: self.origin.x + self.size.width/2, y: self.origin.y + self.size.height/2)
        }
    }
}


//只读
class rectangleClass {
    var width: Double = 10
    var height: Double = 20
    var area: Double {
        //设置只读，那么只返回一个即可,单行省略return
        width * height
    }
}


//属性观察，可以避免重写set，以达到监听当前属性变化目的，跟平时所使用的的观察者不一样
struct ObserverClass {
    var name = "属性观察" //给属性赋值时，可以借用类型推断
    var age = 10 {
        willSet {
            //属性变化赋值前调用
        }
        didSet {
            //属性变化赋值后调用
        }
    }
}


//设定包装属性的初始值，就像java中的注解一样，能简化代码
//属性包装变量名称 wrappedValue
//属性映射(在属性包装的基础上,新增加一个功能,变量名称 projectedValue，调用时变量前加上$
//记得给属性设置初值，否则使用会报错

//例如(属性包装): 设置一个单个数字包装器，将赋值的数字最大不超过9
//例如(属性映射)：写入时加入写入数据库操作
@propertyWrapper
struct singleNumberClass {
    private var number: UInt = 0 //记得设置初值，也可以通过init来设置
    //默认的属性包装名称，参数名固定
    var wrappedValue: UInt {
        get {number}
        set {
            number = min(newValue, 9)
            print("没有写入数据库")
        }
    }
    //属性映射名称，参数名固定(这里模拟写入数据库操作)，调用参数时前面加上$即可(obj.$number)
    var projectedValue: UInt {
        get {number}
        set {
            number = min(newValue, 9)
            print("写入数据库了")
        }
    }
//    init() {//可以通过这里来设置初值}
}

//测试属性包装
class WrapperTestClass {
    
    @singleNumberClass
    var singleNumber: UInt  //这样实现了属性包装，就像是对其重写了一样
    
    var doubleNumber = 10
    
    func setup() {
        //测试一下属性包装
        singleNumber = 20 //wrappedValue -> set
        print("singleNumber", singleNumber) //发现值被限制了 //wrappedValue -> get
        
        //测试一下属性映射
        $singleNumber = 20 //projectedValue -> set
        print("singleNumber", $singleNumber) //发现值被限制了，projectedValue -> get
    }
}


//类属性，类方法
struct staticClass {
    static var name: String? //类属性，通过类名直接调用，可以理解为静态变量
    static func writeName(newName: String) { //类方法，也是通过类名调用
        
    }
}


//通过实例方法，修改结构体struct和枚举enum实例属性(类属性修改完全不受影响)
//由于struct、enum都为值类型，不能通过函数直接修改属性，需在函数前面加上mutating方可(有突变之意)
//注意 mutating 不能在class中使用
struct modifyTypeClass {
    static var score1: Double = 0.0 //其为类属性，修改完全不受影响
    var score: Double = 0 //实例属性，其修改会受到影响
    
    //func updateScore(score s: Double) {} //会报错
    //实例方法修改实例属性，需要加上mutating，枚举也是一样(不过枚举一般不这么使)
    mutating func updateScore(score s: Double) {
        score = s
        modifyTypeClass.score1 = s
    }
    
    //类属性可以随意修改
    static func updateScore1(score s: Double) {
        score1 = s
    }
}


//继承,即子类继承父类，只能用在class,而 struct、enum不行
//override重写关键字,可重写属性和方法
//final修饰的方法，不可被子类重写
class parentClass: NSObject {
    var name: String {
        get {
            return "父类"
        }
    }
    func location() {
        print("我是parentClass的方法,我在家里")
    }
    func work() {
        print("我是父类")
    }
    //禁止重写关键字 final
    final func finalFunction() {}
}
//继承父类时，:后面需要紧跟父类，不能先跟协议
//下面重写了属性和实例方法
class subClass: parentClass {
    override var name: String {
        get {
            return "子类"
        }
    }
    override func work() {
        print("我是子类，我也是可以使用super关键字调用父类的方法的")
        super.work()
    }
    //禁止重写，会报错
//    override func finalFunction() {}
}

//let parentModel = parentClass()
//print(parentModel.name)
//parentModel.work()
//parentModel.location()
//
//let defaultModel: parentClass = parentClass()
//parentModel.work()
//parentModel.location()
//
//let subModel = subClass()
//print(subModel.name)
//subModel.work()
//subModel.location()


//is、as、as!、as?
// 前面提到了继承，不得不提到这几个关键字
// is判断是否是某个类的实例对象
// as 为强制类型转换，由于转化过程可能失败，一般使用 as? 或者 as!
// as?强制类型转换，转换失败会返回可选类型
// as!强制类型转换，与强制展开一样，转换失败会报错崩溃
// as转化适用于数字和class
class isAsClass {
    func test() {
        let a = 10 as Double //这种可以直接用as
        let b = 10.0 as! Int //double转Int这种需要强转as!
        let a1 = Double(10) //一般数字强转是使用这种方式
        let b1 = Int(10.0)
        
        var r = arc4random() % 2 == 0 ? subClass() : parentClass()
        if (r is parentClass) {
            //判断 r 是否是当前类或者父类的实例对象，与 isKind 相似
        }
        //强制类型转换，转换成功会返回一个可选类型的该类型的对象，否则返回nil
        if let c = r as? subClass {
            print(c)
        }
        //强制类型转换强制展开，转换为指定类型，失败会崩溃
        let d = r as! parentClass
        if d === r {
            print(d)
        }
    }
}



//构造方法与析构方法，只有class拥有  init、deinit(dealloc)
class initDeinitClass {
    //如果自己不实现，系统会使用默认的无实现的init方法
    init() {
        //构造方法init方法
        print("initDeinitClass")
    }
    //带参数的，会映射到创建时函数的括号里面
    init(aObj: String, bObj: String) {
    }
    deinit {
        //析构方法，以前的dealloc，类释放调用通知的方法
    }
}
//到这里你可能会想到继承NSObject的问题
//swift中默认的类可以不继承子NSObject，其能能正常创建和释放类
//其就变成了一个空类，不能使用以前的NSObeject中的任何方法(例如：description)
//简单类可以不继承NSObject，空白类自己用，如果功能多可能需要判断等，建议继承NSObject
class initDeinit2Class: NSObject {
    override init() {
        //如果是继承自NSObject或者其他类的方法，init记得加上override重写关键字
    }
    deinit {}
}
//initDeinitClass()或者initDeinitClass.init();


//下标使用方法，通过subscript关键字，可以给固定的类设置下标的调用方法
//可以像数组一样调用该类
class subscriptClass {
    var list = [1, 2, 3, 4]
    
    //在里面可以定义set和get调用方法,想数组一样，subObj[num]
    //参数可以是任意类型，也可以传递字符串，过滤出自己想要的方法
    subscript(num: Int) -> Int {
        set {
            list[num] = num
        }
        get {
            list[num]
        }
    }
    //如果两个参数也可以,例如传入一个二维坐标,设置和获取值
    subscript(x: Double, y: Double) -> Double {
        set {
            print("设置坐标对应的值了")
        }
        get {
            return x * y
        }
    }
    
    //let sub = subClass()
    //sub[2] = 10 //调用了该类下标set方法
    //print(sub[2]) //调用了该类下标的get方法
    //sub[2, 3]
    //?[2]  如果该类其作为其他类的可选属性，可以使用可选+下标方式访问
}


//内嵌类型
//前面有提到过内嵌函数，内嵌类型也有，能内嵌class、struct、enum等
//一般内部私用，定义如下所示
class subTypeClass {
    enum enumType: Int {
        case Monday = 0, TuesDay = 1
    }
    
    struct structType {
        var name: String?
    }
    
    class classType {
        var name: String?
    }
    
    func setup() {
        let enum1 = enumType.Monday
        let struct1 = structType()
        let class1 = classType()
    }
}


//扩展
//和 Object-c 的分类相似，不同的，这里分类没有名字
//扩展属性和方法
extension String {
    //扩展属性
    var extersionName: String {
        return self + ".txt"
    }
    //扩展方法
    func getLogString(str: String) -> String {
        print(str)
        return str
    }
    //扩展下标函数，向range一样取出子字符串
    subscript(loc: Int, len: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: loc)
        let end = self.index(self.startIndex, offsetBy: loc + len)
        return String(self[start..<end])
    }
    //如果是struct等类，仍然可以采用异变的方式进行定义修改内容
    mutating func updateContent(str: String) {
        //可以用来更新结构体的参数
    }
}
//对初始化方法进行扩展
extension CGRect {
    init(x: CGFloat, y: CGFloat) {
        let size = UIScreen.main.bounds.size
        self.init(origin: CGPoint(x:x, y: y), size: CGSize(width: size.width, height: size.height))
    }
}
//测试扩展类
class extensionTestClass {
    func test() {
        //这应String就扩展出来了该属性
        print("文件名".extersionName);
        "打印字符串".getLogString(str: "测试一下打印")
        let frame = CGRect(x: 10, y: 10);
    }
}


//协议
//声明协议,与类一样,默认协议可以被struct、class,extersion等遵循
protocol protocol0 {
}
//协议继承，遵循该协议必须遵循其继承的所有协议
protocol protocol1: protocol0 {
    //属性协议
    var name: String {set get} //需满足读写，支持写必支持读，因此没有单个set
    var name1: String {get} //需满足读取，一般声明默认读写都有要求
    
    func method1() //协议函数1
    func method2() -> Int //协议函数2
    
    static func method3() //静态协议，类方法
    
    mutating func updateStructValue(num: Int) //更新struct的内部属性
    
    init(str: String) //初始化协议要求
}
//协议继承，遵循该协议的类必须实现其继承的所有协议
protocol protocol2: protocol1 {
}
//协议继承时，继承AnyObject时，只能使用class遵循该协议
protocol protocol3: AnyObject {
}
//继承自AnyObject的协议，只能用class来遵循实现
class TableViewClass: protocol3 {
    
}
//实现协议,多个协议之间使用，隔开,写到继承的父类后面，也可以没有父类
struct TableViewStruct: protocol2, protocol0  {
    var name: String = "" //重写只需要声明即可
    var name1: String = ""
    
    //初始化协议要求
    init(str: String) {
        //协议可以当一个类型来使用，即遵循协议的某个类
        let pro: protocol1
    }
    
    //实现协议1
    func method1() {
    }
    //实现协议2
    func method2() -> Int {
        return 0
    }
    
    //实现协议的类方法
    static func method3() {
    }
    
    //更新struct里面的内部属性
    mutating func updateStructValue(num: Int) {
    }
}

//swift中目前没有可选协议(可实现、也可不实现)，可以使用extersion默认实现协议
//因此实现协议的类可以不实现，也不会报错
extension protocol1 {
    func method1() {}
}
//扩展也可以遵循协议
protocol extensionProtocol {
    func testPrint()
}
//给该协议扩展实现协议，协议扩展的方法拥有了可选效果，适用所有遵循该协议类
extension extensionProtocol {
    func testPrint() {
        print("我扩展了协议的方法")
    }
}
//如果不想所有遵循该协议类都使用实现该可选效果，那么可以使用where语句
//当遵循协议的类为 UIView 才会扩展此类
extension extensionProtocol where Self:UIView{
    func testPrint() {
        print("我扩展了协议的方法，仅仅在UIView或者其子类才能实现可选效果")
    }
}


//lazy关键字，懒加载，延迟加载
//一般修饰var定义的属性，属性执行一个闭包，返回属性值
//一般lazy修饰的变量指向的是一个调用的函数，或者闭包函数，其会延迟执行赋值
struct lazyClass {
    var userInfo: String? = "加剧"
    //给属性懒加载定义如下所示
    lazy var name: String = {
        //赋值逻辑
        return userInfo!
    }()
}








