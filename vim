vim 按q进入recording宏录制
1.按q进入recording模式
2.输入a-z或0-9做缓冲器名字并进行录制
3.进行操作
4.按q停止宏录制
5.按@再按缓冲器名字调用宏
输入数字再@再宏名，执行多次宏
--------------------------------------
:e! 切换Buffer(only work in vi)
:X 加密文件
----------------------------------------------------------------------
I 行首插入
A 行尾插入
i 光标所在字符前插入
a 光标所在字符后插入
--------------------------------------------------------------------------------
颜色 :color or :colorscheme
ls /usr/share/vim/vim74/colors/ 可知color scheme
然后 :color color-scheme-name-what-you-want即可
安装vim-jellybeans后 :color jellybeans即可
------------------------------------------------------------------------------------------------------

水平分割窗口 :split
垂直分割窗口 :vsplit
移动窗口 C-w then h j k l r(reverse) w(循环移动) t(top) b(bottom) p(previous) x(switch)
关闭窗口 C-w q(quit) c(close) o(当前窗口以外的所有窗口)
vim -o test1 test2 水平分割  -O 垂直分割

C-z 挂到后台，然后用fg再调出来

--------------------------------------------------------------------------------------------------------------

ciw change a word, daw delete a word
delete dd D dw de daw dt df x X
undo u U
redo C-r :undolist :undo 178
cw change a word,  dw delete a word, w jumpt to next word
b back to previous word
r change a character
R change and insert
C-f C-b page up/down
ma mark
'a return mark a position
visual mode  v V C-v, d delete, y yank, p paste, g? ROT-13
f find a character lik /
zz middle
zt top
zb bottom

:ls list buffer
:bn next buffer or :n
:bp previous buffer
:b# previous buffer
:bdelete N delete buffer N
:bd delete current buffer
:b N switch to N, N is a number

:set ff=unix or dos file format /r/n /r
:set fenc=utf-8   file encoding,save as utf-8 encoding


只读打开-R或-M
指定打开多少行+N
:w :o :e :x

:h help, like :h :e
:e  re-edit the current file
:o open file


---------------------------------------------------------------------------------------------------------------------
archlinux下的vi和vim是不一样的，pacman -Ql vi和pacman -Ql vim可知
/usr/bin/vi是个软链接-> /usr/bin/ex,
而/usr/bin/vim就是vim了
进visual模式复制更方便, 按v进入visual模式，然后y选中开头再按y选中结尾，
按p粘帖.按d删除。按V自动选择行，按C-v选择列.然后选择所有行的第1列然后按I在行头插入#,
所有行头都会插入#

D 从光标删到行末 同d$ C-k
dw 向后删一个词删空格   M-d
de 向后删一个词不删空格
dd 删一行，然后可以用p粘帖 C-a C-k
^ 移动到行首 C-a
$ 移动到行尾 C-e
C-b pageup M-v
C-f pagedown C-v
G 移动到末行 M->
H 当前窗口的首行
M：移动到当前窗口的中间位置；  
L：移动光标到当前窗口的最后一行；

w:光标移动到下一个单词的词首 M-f
2w:重复执行w操作2次；  C-u 2 M-f
e:光标移动到下一个单词的词尾；  
5e:重复执行e操作5次；  
b：向前移动光标，移动到前一个单词的词首；M-b

):光标移动到下一句； M-e

(:光标移动到上一句；M-a

3):光标移动到向下3句


{:向上移动一个段落；

}:向下移动一个段落

3}:向下移动3个段落
以上文本有8行，当处在第6行编辑时，发现第2行好像有问题，需要修改，为了记住现在操作的行，可以作一个标记，ma，
然后2G（跳到第2行），操作完后，回到Normal模式（按ESC），执行 'a(注意a的前面有个单引号)，则会回到之前操作的第8行。
操作说明：

m+单词（单词为a-z或者A-Z） C-space

如果再需要一个标记，则可以mb,返回则执行'b;  C-u C-space

u undo C-x u
U 所有改动undo
C-R 撤销之前的undo

S-insert 插入(粘帖) C-y

yy 複製游標所在行整行。或大寫一個 Y。 2yy 或 y2y 複製兩行，請舉一反三好不好！:-) y^ 複製至行首，或 y0。
不含游標所在處字元。 y$ 複製至行尾。含游標所在處字元。 yw 複製一個 word。 y2w 複製兩個字。 yG 複製至檔尾。
y1G 複製至檔首。 p 小寫 p 代表貼至游標後（下）。 P 大寫 P 代表貼至游標前（上）。

整行的複製，按 p 或 P 時是插入式的貼在下（上）一行。非整行的複製則是貼在游標所在處之後（前）。
