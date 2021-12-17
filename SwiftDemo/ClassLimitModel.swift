//
//  ClassLimitModel.swift
//  SwiftDemo
//
//  Created by Marshal on 2021/12/8.
//  权限访问关键字

import UIKit

class ClassLimitModel: NSObject {
    //如果学习了c++的小伙伴们很定会了解三个权限关键字
    //public private protect  即公开，私有，受保护
    
    //下面介绍下swift中的权限关键字
   
    //提示：源文件值当前创建的.swift文件，模块指的是当前项目仓库，或者是一个pod模块仓库，或者一个framework模块仓库
    //例如：pod导入的网络加载框架、图片加载框架
    
    //swift中主要可能使用到下面几个关键字：
    //open、public、Internal、private、File-private
    
    //internal
    //默认关键字,不指明情况下，默认权限为internal，其允许被定义模块中的任意源文件访问，但不能被该模块外的任何源文件访问
    
    //private
    //仅仅限制于当前声明的实体中，可以是一个类，可以是一个源文件(前提是声明到了外层)，出了实体(当前类、或者当前源文件)，就不可以访问了
    
    //fileprivate
    //像package修饰的一样，在当前源文件中能随意访问，出了源文件不能访问
    //例如：当前源文件定义了两个class,其中一个class中属性使用了fileprivate修饰，那么另一个类也可以调用，而使用private修饰的就不能访问
    
    //public、open
    //他们两个在模块内部和外部，都能够被访问到，但继承和重写权限有区别
    //public在当前模块中，可以被继承(类)和子类(方法)重写,出了当前模块则不可以
    //open在当前模块中，也可以被继承和重写，出了模块，只要导入该模块，也可以被导入模块继承和重写
    
    //因此open 访问权限最高，private 访问权限最低，Internal居中
    
    func limitFunction() {}
    
    internal func limitFunction0() {}
    
    private func limitFunction1() {}
    
    fileprivate func limitFunction2() {}
    
    open func limitFunction3() {}
    
    public func limitFunction4() {}
}
