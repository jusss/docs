a.dsl
loop 10 print "hi"
sleep 10s

b.scheme
(readline a.dsl)
(my-dsl (readline a.dsl)
    (cond (loop ...
          (sleep ...
          (other ...

$b.scheme a.dsl

or in repl:
(mydsl loop 10 print "hi" end
       sleep 10s end
       set a 5 end
       print a end)
设置namespace给这个dsl
(append-env (a 3))

https://zhuanlan.zhihu.com/p/22824177
bash sql bre are dsl
内部dsl和外部dsl, 
ruby 1 + 1  1.+(1)  1.methods
block 是Proc类的实例

简单搞个 Embedded DSL

使用 Ruby 实现嵌入式 DSL 一般需要三个步骤，这里以 CocoaPods 为例进行简单介绍：

创建一个 Podfile 中“代码”执行的上下文，也就是一些方法；
读取 Podfile 中的内容到脚本中；
使用 eval 在上下文中执行 Podfile 中的“代码”；

