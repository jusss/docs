http://mywiki.wooledge.org/BashGuide
http://mywiki.wooledge.org/ParsingLs

for v in * ; do mpv $v; done;

pidof -x offlineimap.py         get the script pid 

use a macro in bash like
alias 'mkill x'=kill `pidof x`  like a macro, and this isn't support by bash or alias

you need a bash function in shell

mkill() { kill "$(pidof "$1")" ;}
run that in shell, and then run mkill what-ever-you-want in shell, if you got > don't forget
put ; before }  and put one space after {

then put that in .bashrc and you can use it anywhere





about macro and function talks in bash jusss@irc.freenode.net#archlinux

<jusss> igemnace: phantomotap what if I'd like use 'mpv -s x.srt x.mp4'
	instead of 'mpv --sub-file x.srt x.mp4', how should I do?
<jusss> use bash function?
<jusss> define a new function?
<igemnace> jusss: what? what invocation do you expect to use
<phantomotap> i'd probably write a full blown script to check if same_name.srt
	      exists and do that automagically
<phantomotap> igemnace: he apparently wants to alias -s to --sub-file outside
	      of the program  [12:00]
<sangy> jusss: why do you want to do this exactlY?
<sangy> to have a shorthand? 
<jusss> sangy: it's simple to use and remeber
<igemnace> you'd have to write a script to handle arguments properly
<jusss> when I download the srt file ,it's always not same as the x.mp4, and I
	have to change its name, it's awful  [12:01]
<igemnace> too long-winded for such a small gain
<sangy> I think you can
<sangy> alias mpv='mpv --sub-auto=all --sub-path=.'  [12:02]

<jusss> sangy: no, there's lots of srt, I just need one of them, not all

<jusss> so I don't think use all is good idea
<ryzenda> I am setting up a Scarlett Focusrite 6i6 first time now, and see at
	  https://community.ardour.org/node/14390 that apparently I need to
	  boot into a MS Windows environment to use the Focusrite Control, but
	  I don't have access to a MS Windows environment.  
<phrik> Title: Focusrite Scarlett 6i6 2nd Gen | ardour (at
	community.ardour.org)
<sangy> well, read the man page and check with ones help you better

<sangy> probably fuzzy, but who knows
<jusss> that's why I think macro is great

<jusss> it can check and change stuff  [12:04]
<phantomotap> jusss: you can do that with a function
<jusss> phantomotap: define a function with a new name?
<igemnace> jusss: what exactly do you mean by a macro

<igemnace> i know of multiple things that are called "macros" so i'm not sure
	   what exactly you're looking for
<sangy> keiga: I'd wager you make a PKGBUILD

<jusss> ((mpv -s x.srt x.mp4) (mpv --sub-file x.srt x.mp4))
<igemnace> jusss: alright, lisp macros? those don't exist. bash functions come
	   very close, but fall short since lisp macros prevent evaluation and
	   bash functions can't do that  [12:08]
<sangy> not sure if it works, but it probably is a goog place to start
<keiga> I'm aware of that, it 1) wasn't compiling correctly and 2) downloaded
	a ton of other stuff I don't need when I only need MKL

<jusss> or just ((mpv x.mp4 x.srt) (mpv --sub-file x.srt x.mp4))

<phantomotap> jusss: now that one is trivial
<sangy> keiga: hmm, let's see. Just to make sure, you want to replace the
	systemwide installation of python-numpy with python-numpy-mkl or do
	you want to do this just in your venv?  [12:09]
<jusss> igemnace: other shell can do that?
<igemnace> that one's easy, e.g. mpvs() { mpv --sub-file "$2" "$1"; }

<jusss> igemnace: yeah, with a new name

<igemnace> jusss: not that i know of. are you absolutely certain you need to
	   prevent evaluation in these cases though?  [12:10]
<sangy> can use mpv if you want

<phantomotap> [untested] function mpv() { command mpv --sub-file "$2" "$1"; }
								        [12:15]
<phantomotap> a PKGBUILD file is basically a shell script; it could be as
	      complex as you need it
<jusss> phantomotap: mpv a.mp4  without second parameter it'll be error

<igemnace> jusss: fair, but the example we were basing off you didn't handle
	   that
<phantomotap> jusss: you can fix that problem as well. seriously, rather than
	      complain about missing macros, why not look into what shell
	      functions can do?

<igemnace> jusss: as i've said, you'll usually want a script to handle more
	   complex args

<jusss> phantomotap: igemnace fair enough, my mistake, I just fight back for
	your saying that function instead of macro, 

<igemnace> jusss: which i only do because as i've pointed out, macros as they
	   exist in lisp don't exist in bash
<phantomotap> indeed

<igemnace> jusss: but honestly, your examples don't rely on anything
	   macro-specific that bash functions don't have  [12:21]
<phantomotap> if i knew of a shell that handled lisp-like macros i would have
	      just told you
<jusss> so I wonder if there's other shell can do that
<igemnace> your complex-arg-handling counterexample isn't even handled by
	   macros
<igemnace> "not that i know of. are you absolutely certain you need to prevent
	   evaluation in these cases though?"
<jusss> I just forget what macro can do and function can't, 

<igemnace> major thing macros in lisp have over functions is that eval
	   recognizes macro calls and delays evaluation of its args, as
	   opposed to function calls where its args are recursively eval'd
	   before passing to the function
<igemnace> as an aside, that's not something that can save you from your
	   complex args handling  [12:24]


<igemnace> the reason why you can't have macros in bash (and most other
	   shells) is because it always evaluates a command before passing off
	   to the function/program

<jusss> igemnace: your sounds like macro only do delay eval, but I think form
	transform is more import
<igemnace> jusss: because you can also emulate a form transform with functions
								        [12:27]
<jusss> and I do rememer there's a scheme shell, but I forget its name...

<igemnace> it's just that the function never sees the form as it was read,
	   because it's eval'd before it sees it

<igemnace> jusss: well, your call. you can use a scheme shell with macros if
	   you want. just know that your examples are achievable with shell
	   functions, and your counterexamples aren't magically solved if the
	   shell supported macros

<phantomotap> keiga: where does MKL usually live? or does MKL set any
	      environment variables in the standard shells?
<jusss> https://en.wikipedia.org/wiki/Scsh
<phrik> Title: Scsh - Wikipedia (at en.wikipedia.org)
<igemnace> jusss: neat
