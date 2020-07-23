#正则表达式各家语言的语法格式不尽相同。
#或者称为模式，最终判定出来只有：匹配、不匹配两种结果。
#文件名匹配模式的使用用到了许多和正则表达式一样的字符，但是文件名匹配模式并不是正则表达式

#简单的模式;

#若模式的匹配对象是$_的内容，只要把模式写在/ / 中就可以，模式本身就是一串简单的字序列
$_ = 'yabba dabba doo';
if(/abba/){
	print "matched\n";
}
#模式匹配返回的通常是真或假，所以经常用在if while内
#所有能用双引号引在其中的字符串中的技巧，在模式串里都能使用。
#如： /coke\tsprite/ 会匹配 coke 制表符、sprite 11个字符
# Unicode属性
#每个字符除了字节组合，还可以用属性信息完成匹配
#只要把属性名放在 \p{property} 里面

#许多字符带有空白符，相应的属性名为Space，要完成这类 字符的匹配：
if(/\p{Space}/){
	print( "The string has some whitespace.\n");
}
#匹配数字：
if(/\p{Digit}/){
	print ("The string has digit.\n");
}
# 匹配连续两个十六进制的字符集：
if(/\p{Hex}\p{Hex}/){
    print "The string has a pair of hex digits.\n";
}
# 若要匹配不包含特定属性的字符，把 p改成 P,就表示了否定意义
if(/\P{Space}/){#不是空白符都能匹配
	print( "The string has some non-whitespace.\n");
}

#######模式的元字符：
# 	.	表示匹配任意一个字符的通配符，像"\n"这种是除外的。只能匹配一个字符
# 	\	在任何元字符前加入 \ 进行转义就失去了通配符的意义，要想使用/这个元字符需用： \\ 
$_ = 'yabba \\dabba doo';
if(/\\/){ #匹配是否有：\	 第一个\是用来转义的
	print "\\matched\n";
}
######量词：
# * 	*是用来匹配前面一个字符的0次或者多次。例："fred\t*barney"，表示匹配fred barney之间任意数量的制表符，包括0个
# 匹配任意字符的任意数量： .* 例："fred.*barney"，表示匹配fred barney之间任意的字符、任意数量、	 .*也被称为捡破烂字符
$_ = 'fredbarney';
if(/fred\t*barney/){
	print "*matched\n";
}
# + 	+会匹配前面字符是否出现过至少一次: ge 1 个
$_ = 'fred barney';
if(/e+/){
	print "+matched\n";
}
# ? 	？匹配前一个字符：出现过一次、没有出现
$_ = 'fred-- barney';
if(/-?/){
	print "?matched\n";
}
#模式分组：（）		
$_ = 'fredfredfred';
if(/(fred)+/){#匹配fredfredfred这样的字符串，fred至少有一次
	print "(fred)matched\n";
}
if(/(vbs)*/){# *允许()内的字符串出现0次，所有*很难匹配失败
	print("(vbs)* mached\n");
}
#反向引用捕获组: \num ，捕获组指( )内的内容
$_ = 'abba';
if(/(.)\1/){#表示引用第一个捕获组的内容
	print("(.)\\1 it oko\n");
}
#(.)\1表明需要匹配连续出现的两个同样的字符具体为: (.)首先会匹配a，但是在查看反向引用
#的时候就会发现下一个字符不是a，导致匹配失败。Perl会跳过这个字符，用(.)来匹配
#下一个字符b，在查看反向引用的时候会发现下一个字符也是b，这样就达成了成功的匹配。

$_  = 'yabba dabba doo';
if(/y(....) d\1/){ #引用不必根紧跟在捕获组后面，：d后面是否还会有(....)这四个字符串
	print "y(....) d\\1 matched\n";
}
#多个捕获组都有自己的引用，\num的num根据左括号所处的序号来决定，初始是从 1开始的序号，不是0
$_ = 'yabba dabba doo';
if(/y(.)(.)\2\1/){ #匹配：yabba
	print "y(.)(.)\\2\\1matched\n";
}
if(/y((.)(.)\3\2) d\1/){
	printf "y((.)(.)\\3\\2)d\\1 matched\n";
}

#从perl 5.010后开始的反向引用的\num支持用\g{num}, num可以为负数
$_ = "aa11bb";
if(/(.)\g{1}11/){
	print "(.)\\g{1}11 matched\n";
}
$_ = 'xaa11bb';
if(/(.)\g{-1}11/){#负数
	print "(.)\\g{-1}11 matched\n";
}
# | 择一匹配,两边至少出现一次
$_ = 'fred	barney';
if(/fred(|\t)+barney/){#在匹配在之间是否有空和制表符至少出现过一次
	print "fred(|\\t)+barney matched\n";
}
if(/fred( +|\t+)barney/){#在匹配在之间的空格和制表符至少有一个
	print "fred( +|\\t)+barney matched\n";
}
$_ = 'fredorbarney';
if(/fred(and|or)barney/){ #在括号内and or 不是关键字了
	print "fred(and|or)barney matched\n";
}

#匹配字符集中的一个字符。字符集：[]
#比如字符集[abcwxyz] ([a])可以匹配a是否存在，使用连字符- ([a-c])可以匹配 abc是否存在
#([a-zA-Z])可以匹配52个字母
# 字符集也可以使用ASCII写：[\000-\177] 转移后的字符集合
$_  = "The HAL-9000 requires authorization to continue.";
if(/HAL-[0-9]+/){
	print "HAL-[0-9] matched \n";
}
#脱字符：^ 字符集通常不能定义的很完备，所以可以用^匹配除了字符集以外的字符
# [^def]会匹配除了def以外的字符
# [^n\-z]会匹配n-z以外的字符
$_  = "The HAL-cc9000 requires authorization to continue.";
if(/HAL-[^0-9]+/){ #匹配除了0-9这10个数字意外字符
	print "HAL-[^0\-9] matched \n";
}

# 字符集的简写：略