1. $irb 打开ruby的repl
2. 定义方法
    def h(name)
      puts "hello #{name}" 
    end
    在字符串中扩展变量 #{xxx}
3. 定义类
    class greeter
        def initialize(name = 'world')
            @name = name
        end
    end
    @name是类的实例变量
