1. cps never return, it always take an unary a->r
2. Cont r a = (a->r)->r, is a cps computation, a->r is a continuation
3. just like Promise in js, >>= like then, you could use \error result -> to do something, but >>= a constant is error

a = 3
# now you want make a continuation on a, but not get it yet, it's delay computation
# it won't block here
k = pure a
# do something else
...
b = 2
# now you can do something b with k

r = pure a >>= \a -> doSomething about a to get a b, then pure b >>= \b -> ...

>>= 's benifit here is you think natually using lambda here to get the previous result and use it here, do what you want
then use pure to generate the new cps computation

and use id to release a, r id, or other else just has a->r, id only pass to a then it release a, and other will do the other things

it's like a chain of computation, domino, once an unray pass to it to unleash the first a, it will compute whole the rest on the chain

in \a -> ... return a, not a->r will circuit the whole computation and return b as final value, 
don't like Nothing in >>=, Nothing will come to the end eventually, but this b won't

cps >>= \a -> pure (doSomething a) >>= ...
cps >>= \a -> "error" >>= ...

this "error" don't use a, will circuit the whole computation and exit earlier
and this is the error branch in Promise in js

import Control.Monad.Trans.Cont
k = return 3
k2 = k >>= \a -> return (a+1)
runCont k2 id == 4
runCont k2 (+2) == 6
bindC = \g f k -> g (\x -> f x k)
k5 = k3 `bindC` (\a -> return_cont (a+1))
k5 id == 4
k5 (\a -> "b") == "b"

bind_cont = curry(lambda g, f, k: g(lambda x: f(x)(k)))
return_cont = lambda a: lambda k: k(a)
k = return_cont(3)
cps = bind_cont(k, lambda a: return_cont(a+1))
print(cps(identity)) == 4
print(cps(lambda x: "b")) == "b"

cps_2 = bind_cont(cps, lambda x: return_cont(x+2))
cps_2(identity) == 6

# circuit
cps_3 = bind_cont(k, (lambda a: bind_cont(lambda b: "b", lambda c: return_cont(c))))
cps_3(identity) == "b"

# circuit
cps_3 = bind_cont(k, (lambda a: bind_cont(lambda b: a, lambda c: return_cont(c))))
cps_3(identity) == 3

# same as ma >>= (\a -> (mb >>= \b -> mc))
cps_5 = bind_cont(k, lambda a: bind_cont(return_cont(a+1), lambda b: return_cont(a+b)))
print(cps_5(identity))

# circuit, return a will circuit the computation, return a->r won't circuit
cps_6 = bind_cont(k, lambda a: bind_cont(lambda _: 9, lambda b: return_cont(a+b)))
cps_6(identity) == 9

cps_6 = bind_cont(k, lambda a: bind_cont(lambda z: a if a == 3 else return_cont(z), lambda b: return_cont(a+b)))
cps_6(identity) == 3




# Playing with Multiple Callback Invocations
cps_7 = bind_cont(k, lambda a: bind_cont(lambda x: x("a") + x("b"), lambda b: return_cont(str(a)+b)))
cps_7(identity) == 3a3b










if cps is a class
from unwrapped_type import Cont as cont
(ma >>= \a -> mb) >>= (\b -> mc)
k = cont.pure(3).bind(lambda a: pure(a+1)).bind(lambda b: pure(b))
k.runCont(identity)

# same as ma >>= (\a -> (mb >>= \b -> mc))
k2 = cont.pure(3).bind(lambda a: pure(a+1).bind(lambda b: pure(b+a)))
k.runCont(identity)


def pure(x):
    return Cont(lambda k: k(x))

id = lambda x: x

class Cont:
    def __init__(self, g):
        self.g = g

    def bind(self, f):
        return Cont(lambda k: self.g(lambda x: f(x).runCont(k)))

    def runCont(self, f):
        return self.g(f)

# k3 = pure(3)
# print(k3.runCont(id))

# k5 = k3.bind(lambda a: pure(a+2))
# print(k5.runCont(id))

# (Cont inC) >>= fn = Cont $ \out -> inC (\a -> (runCont (fn a)) out)


k7 = k3.bind(lambda a: Cont(lambda x: x("a") + x("b")).bind(lambda b: pure(str(a)+b)))
print(k7.runCont(id))





# Cont r a = (a->r)->r
# cont :: (a->r)->r -> Cont r a
# return :: a -> Cont r a


k = (return $ \x -> x+3) <*> (return 3); runCont k id == 6

return 3 == cont $ \x -> x 3?

k = (cont $ \x -> x+3) <*> (cont $ \x -> x 3) is wrong
\x -> x+3 :: a->a
cont a->a /= Cont r a



there're two eval order
ma >>= \a -> mb >>= \b -> mc
is equal to ma >>= (\a -> (mb >>= \b -> mc)) -- the part after mb can access a
not (ma >>= \a -> mb) >>= (\b -> mc) -- the part after mb can't access a

m >>= (\x -> k x >>= h) = (m >>= k) >>= h

ref
https://jsdw.me/posts/haskell-cont-monad/

