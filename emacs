
;;; auto-complete for coding
(require 'auto-complete)
(add-to-list 'ac-modes 'javascript-mode)
(add-to-list 'ac-modes 'html-mode)
(add-to-list 'ac-modes 'css-mode)
(add-to-list 'ac-modes 'python-mode)
(add-to-list 'ac-modes 'racket-mode)
(add-to-list 'ac-modes 'scheme-mode)
(ac-config-default)

--------------------------------------------------------
M-x package-refresh-contents
M-x package-list-packages
M-x package-install RET racket-mode RET C-x C-z will open racket
和python-mode一样，C-c C-z调出repl, F5直接求值并显示结果在repl C-c C-c 运行
C-x C-e 求值光标之前的表达式
C-x C-r 求值选择的区域(region也就是C-S-n或M-; M-w)的表达式
或者直接M-x eshell RET racket
---------------------------------
M-x desktop-save  can save the buffers when you leave, or write (desktop-save-mode 1) into .emacs, then use M-x desktop-read to re-open them
-----------------------------------------------------
M-! 和 M-& 可以运行系统指令, M-!会阻塞emacs, M-&是异步执行指令，不阻塞emacs
可以用C-h k M-!来查看该组合键的使用
C-h f function-name 查看函数

M-x ielm 进入elisp
--------------------------------------------------------

M-x package-list or M-x package-list-packages   ;update the packages log
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
M-x pacakge-install RET auto-complete
(ac-config-default)    ; write this into .emacs
~

--------------------------------------------------------
install auto-complete on emacs for coding auto completion

emacs自带的python-mode再安装auto-complete就能自动补全python代码，不一定非得用jedi,在python-mode里C-c C-z打开个python shell,然后C-c C-c就能直接运行buffer里的代码

;;;put those into ~/.emacs
;;; run  (package-refresh-contents) update content, if some packages are not found, then (package-archives) and (package-initialize)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)



;;;https://github.com/auto-complete/auto-complete
;;;M-x package-install RET auto-complete RET
;;; if there're other errors like ac-update-greedy, try re-instal popup and yasnippet-classic-yasnippet with package-install

(ac-config-default)

;;; then you can run M-x auto-complete in *scratch* buff to enable it or wherever you want to use auto complete



