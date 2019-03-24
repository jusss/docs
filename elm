
Type Constructor and Value Constructor

data T a = V a   
w = V 3 则 w :: T Int
x::T String 则 V "whatever"的type是x, (T String)是一个type,而(V "whatever")是一个value

data A = B
A是Type Constructor, B是Value Constructor

data T a = V a 就定义了T和V

Elm里的Type相当于Haskell的data
而在haskell里type相当于elm的Type alias
type X = Int  X就可以代表Int

newtype相当于一个优化的data

newtype = 只允许有一个值的data

newtype X = X Int 定义了一个新的X类型和对应的俩构造器

data X = X Int 表示X这个值构造器接受一个Int返回一个X
X::Int -> X
haskell GADT

data X = Int 是没有这种写法的，只有 type X = Int 定义类型构造器的别名

data Y = Y
x = Y 这样是可以的

值构造器不是类型

Int是个类型构造器
data Int = 0|1|2|...|4294967295

Value Constructor可以当作一类特殊的函数，可以在模式匹配里用,match pattern,
但普通函数不能在模式匹配里用， 值构造器可以作为函数使用，也可以模式匹配
所以Haskell有类型构造器 值构造器 和函数,  其它语言里的Constructor一般是指Value Constructor
data E = X | Y
:type X
X :: E
:type Y
Y :: E
:type 1
1 :: Num p => p
:type 1 :: Int
1 :: Int :: Int
所以:1也是值构造器还是多态的

类型构造器和值构造器都可以没有参数
data Bool = True | False   Bool是个无参数的类型构造器, True和False是无参数的值构造器
data Maybe a = Nothing | Just a    Maybe是类型构造器，a是在等号左边是类型变量,a在等号右边是值变量，Just是值构造器

Haskell除了值，类型之外还有Kind
Int是Int::*
Maybe是*->*
Kind就是Type的Type,  Idris可以无限层级堆叠类型
Haskell最高只有两阶类型，所以没法表达所有集合的集合, 是data和typeclass之别，好像没问题，Elm 0.19还没有typeclass
https://diogocastro.com/blog/2018/10/17/haskells-kind-system-a-primer/
C++好像也是两阶的
Kind就是描述类型构造器的类型的,
先用Type描述数字，data Nat这样用Nat Succ这样去描述数字
https://hackage.haskell.org/package/data-nat
data-nat: data Nat = Zero | Succ Nat

data T a = V a
x :: T Int 怎么把V 3里的3通过操作x提取出来？
得把x写成函数
x :: T Int -> Int
x (V boom) = boom
或者
x biu = case biu of
        (V boom) -> boom

Elm没有data,只有Type和Type alias, Elm的Type和Haskell的data功能一样, Elm的Type alias和Haskell的type功能一样或者newtype?
Haskell开LambdaCase之后可以这样写
:set -XLambdaCase
y = \case (V boom) -> boom
:type x
x :: T a -> a
:type y
y :: T a -> a

Module X where 这个where就是定义了一个块状区域，类似c系语言里的大括号把后面缩进的内容都包含进去了

t = map f  这个是curring柯里化也是pointfree写法
括号里有逗号就是tuple,没有逗号就是优先求值
x :: (Int, String, Int) -> Int 和 y :: Int->String->Int-> Int 后者是柯里化的

haskell没有一元tuple 但是有0元tuple,0元tuple就是()

module X where 就是指这个文件的名字是X.hs或X.elm, where类似C的大括号,这个文件可以作为模块给其它文件使用
也可以 module Main where, module Test where, module Whatever where, module就是把这个文件声明成了模块给其它文件使用
而在python里一个文件默认就是模块，test.py可以在同目录的其它python文件里直接import test去掉文件名后缀.py导入，但是为了防止在导入
test.py时求值里面的函数，所以一般就在test.py里把求值的函数都写在if __name__ == '__main__':里，这样在其它文件导入test.py时，
因为主文件的__name__才等于__main__,导入时test.py里的__name__不等于__main__这样test.py里的求值函数就不会求值，
因为python的执行顺序是从top到bottom,所以python的程序入口点entry point就是第一行，
而C的程序入口点是main(),  Elm和Haskell的程序入口点是main = 

#######################################

https://zhuanlan.zhihu.com/p/21338799
update : Msg -> Model -> (Model, Cmd Msg)

update函数接受两个参数：

    事件，比如鼠标移动、用户点击等，也就是Msg参数
    系统的当前状态，也就是Model参数

每当有新事件发生时，Elm自动用该事件调用update函数，update函数返回新的状态，当状态发生变化时，Elm自动调用view函数

view : Model -> Html Msg

view函数根据Model来生成Html，Elm识别这次生成的Html和之前的Html之间的差异，并在浏览器上做相应的渲染。

当+ 和 - 按钮按下时，会发出相应的Decrement和Increment这两种Msg。 Msg又会被喂给update函数用来计算新的Model，新的model又计算出新的view。如此循环，生生不已。

#########################
有ports就用main=Browser.element  没有就用Browser.sandbox
0.16的Mouse模块现在也在Browser模块里
##################################

Main.elm

port module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Browser exposing (sandbox)
type alias Model = Int

type Msg
  = Inc
  | Dec
  | GetHello String

model : Model
model = 0

port sayHello : String -> Cmd msg
port jsHello : (String -> msg) -> Sub msg 

init : flags -> ( Model, Cmd Msg )
init dataFromJSwhenInit = (model, Cmd.none)

update : Msg -> Model  -> (Model, Cmd msg)
update msg model2 =
  case msg of
    Inc ->
      (model2 + 1, sayHello "i")
    Dec ->
      (model2 - 1, sayHello "d")
    GetHello str ->
     (model2, sayHello str)

view : Model -> Html Msg
view model1 =
  div []
    [ button [ onClick Inc] [ text "Inc" ]
    , text (String.fromInt model1)
    , button [ onClick Dec ] [ text "Dec" ]
    ]

subscriptions : Model -> Sub Msg
subscriptions model3 = jsHello GetHello

main : Program () Model Msg
main =  Browser.element
       { init = init
       , view = view
        , update = update , subscriptions = subscriptions}

#####################################################
elm make Desktop\Ports\Main.elm --output=main.js

###############################
<script> src="main.js" </script>
<script> src="hello.js"</script>
<script>
     
  var app = Elm.Main.init({
    node: document.getElementById('elm')
  });
      app.ports.sayHello.subscribe(function(data) { console.log(data)});
	  //app.ports.jsHello.send("Elm! hellooooo");
	  toE = function(x) {app.ports.jsHello.send(x);};
      

      <!-- messager = function(msg){hello.hello(msg)} -->
 
    </script>
####################################################
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
