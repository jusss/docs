python中文交流 on telegram
elm on slack


elm怎么调用外部js的函数?

main.js里面
app.ports.<function name>.subscribe(js_function)
然后elm里面 port <function name> : Xxx -> Cmd msg

这个main.js是在index.html里面加载elm用的，const app = Elm.Main.embed(...) app.ports.set_title.subscribe(...)

elm make可以编译成html或js, 一般编译成js，然后手写 head body

好奇ES6+那套Promise Async/Await Websocket Fetch API Elm是怎么解决的
Elm用的是Task

purescript and purescript-css  or haskell的 clay

qt先design 然后生成code, 生成后有两部分，一部分是坐标和组建，第二部分是组建的设置，都是写到第二个里面去

Promise镶嵌Promise会让Promise flattern 水平化

AST DSL

JetBrains's mps
aldebaran's chorgraphe python box只用考虑抽象的逻辑关系，而不用管具体实现

timer, tornado有PeriodicCallback, asyncio好像用asyncio.sleep实现，但也有asyncio.wait_for

elm   | symbol means or

write a file caled Counter.elm and write those lines
module Counter exposing (..)   自己写的库文件，就用module在其它文件里导入，官方的库直接import
这个module就是js里面的module.exports, python import *的时候的__all__

格式声明
type Msg
  = Inc
  | Dec
define a type Msg using a union type, union type就是一个集合中的一个元素

Msg的值就是Inc或者Dec   Int16 = =32768 | -32767 | ... | 0 | 1 | 2 | .. | 32767

elm写函数 变量 格式 之前先写个类型声明。。。人家C语言这种静态类型语言是把类型声明和定义写到一起了呀 int a=3; int f(int x, int y);
elm倒好 把函数签名和函数定义分开写  f : Int -> Int  f x = y
