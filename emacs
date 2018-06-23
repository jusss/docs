M-x desktop-save  can save the buffers when you leave, or write (desktop-save-mode 1) into .emacs, then use M-x desktop-read to re-open them
-----------------------------------------------------
M-! 和 M-& 可以运行系统指令, M-!会阻塞emacs, M-&是异步执行指令，不阻塞emacs
可以用C-h k M-!来查看该组合键的使用
C-h f function-name 查看函数

M-x ielm 进入elisp
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



