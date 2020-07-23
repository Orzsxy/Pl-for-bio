#数据类型
#与py差别，py中换行不用：;
$var = 61_298_283_768,print("$var\n");
#八进制
$var = 0377,print("$var\n");
#二进制
$var = 0b1111111111; print("$var\n");
#十六进制
$var = 0xff;print("$var\n");
#内置函数 bin() oct()
#在源代码中使用unicode编码:
use utf8;
#字符连接符： .
$var = "hello". ' '. "world";	print("$var\n");
$var .= 'KK'; print("$var\n");	#双目运算符
#字符串重复运算符: x
$var = 'feed'x 3;print("$var\n");
$var = 3x4;print("$var\n");
$var = 3x0.4;print("$var\n");	#小于1的取值为0，最后生成一个空字符
# *运算符，也会计算字符型的数字：
$var = '12'*'3'; print("$var\n");
$var = '12feed34'*'3';print("$var\n");	#会被后面第一个非数字字符截断
$var = 'feed'*3;print("$var\n");	#字符串中没有数字，会转化为0
$var = '0377'*2;print("$var\n");	#前置0只对直接变量有用，在字符串中不能自动转换
$var = 0377*'2';print("$var\n");	#0377转为十进制的255
$var = 'z'.'5'*'7';print("$var\n");	
#变量插在字符类型中：
$f = 'hello';
$var = "The name is $f\n";	print $var;
$var = "The name is $ff\n";	print $var;	#如果变量先前没有被赋值过，会用空字符串替换，
#在字符中检查变量名避免出现字符当作变量名的处理，常用处理.
$what = 'steak';
$var = "The name is ${what}s\n";print $var;
$var = "The name is $whats\n";print $var;
# 编码的转换 chr()、ord()
#$a = chr(0x03C9); print ("$a\n");
#$a = "\x{03C9}\x{03C9}"; print("$a\n");		#和上面一样，在没有预先创建变量时使用：\x{ }
#$var = ord($a); print("$var\n");
#字符串的比较：
#	eq	=
#	ne	!=
#	lt	<
#	gt	>
#	le	<=
#	ge	>=
#
#perl没有布尔变量，	可有：0为假、空字符串为假、字符串'0'和数字0是同一个标量，也被视为假
#字符串'0'是唯一被认为是假的空字符串
#通常1是真，undef是假，但是程序中这样不能用，并没有规定。只是语义上认可
$var = undef;
if($var == undef){
	 print("1\n");
}
#获取数据输入
$line = <STDIN>;
if($line eq "\n"){	
	print("That is a blank line\n");
	}
else{
print("has contest input\n");
}
#去除末尾的换行符，返回值是实际移除的字符个数, !!不是去除空格
chomp($test = <STDIN>); #若果有多个换行符只能去除一个，没有的话什么也不做。
#未定义 undef
#undef既不是数字也不是字符，是单独的一种数据格式
#但是在数字语境中会认为是0，在字符语境中认为是空串
$string.='more text' #string初始就被认为是undef,是空串
#defined 判断字符串是否为空，用在读取文件在最后一行时通常是空，
$string
if(defined($string)){ #如果是空undef，返回值是假，不为空返回值是真
	print("$string\n");
	}
else{
	print("this is a blank\n");
	}
