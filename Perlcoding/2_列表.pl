#超出索引不会报错，会认为是未定义的空：undef
$a[0] = 'sds';
$a[1] = 'rbf';
$a[2] = 'tyr';
$a[100] = 'wsfer'; #3-99中间会创建97个变量，值是undef
#得到列表的最后一个元素的 索引值
print("$#a\n");
print("$a[-1]\n");
#列表定义：()
(1..100);	#100个数构成的列表，..范围操作符
();	#空列表
('ferd',4.5);	#两个元素
print($a[0].$a[1], 4.5);print("\n");	#支持表达式
#特殊的字典列表 qw,空格、制表符、空白当作分割，不计算多少个空白。定界符只要是左右匹配就可以
@string1 = qw(fredQQ 
				barney 
				betty 
				wilma 
				dino );
print($string1[0]);	
qw< fred barney betty wilma dino >;	#字典里表内含使用分界符就需要转义
qw{ fred barney betty wilma dino };
qw[ fred barney betty wilma dino ];
#常被用来构造文件路径：
@a=qw{
/usr/dict/words
/home/rootbeer/.ispell_english
};
print("$a\n"); #没有指定索引，不会被打印
print $a[1],"\n";
#列表的赋值：
($fred, $barney, $betty ,$wilma, $dino ) = ( 'fred', 'barney','betty', 'wilma','dino' );
#交换：
($fred, $barney) = ($barney,$fred,$betty); #多出来的值会被忽略
#构建字符串列表：
($a[0],$a[1],$a[2]) = qw/sdfs dds gerf/;
print($a[0],$a[1],$a[2],"\n");
#列表复制：
@a = qw/a s b c f/;
@li = 1..1e2;
@c = ();
@lili = (@a,@c,@li); #空值会被略过
print("@a\n"); 
print(@lili,"\n"); # print "@lili" 打印出来有空格，！
@a = @lili; #列表的复制
print("@a\n");

#pop，删除栈顶元素，如果数组是空的，直接返回undef
@array = 5..9;
$var = pop @array;	#返回弹出的值
print $var,"\n";
# push( )
push(@array,0);
push(@array,@a);
print @array,"\n";
#shift,unshift操作符,在队列的头部
@array = qw# dina fred barney#;
$var = shift @array;	#出队列
unshift @array,"Asdcd";
print @array,"\n";
#######切片splice(@array,start,size,@new_array),后面两个是可选的参数， Py中的切片是slice():
@array = qw# dina fred barney pebbles#;
@removed = splice @array,2;	#开始位置
print "@array",'--',"@removed","\n";
@array = qw# dina fred barney pebbles#;
@removed = splice(@array,2,1);	#指定长度
print "@array",'--',"@removed","\n";
@array = qw# dina fred barney pebbles#;
@removed = splice(@array,1,2,qw/KK/);#要插入的内容,是插入原先的@array中，长度不一定相同
print "@array",'--',"@removed","\n";
##################字符串中插入数组：
@ro = qw/ f s r/;
print "this is @ro oo\n";	#插入到双引号中，在数组的各个元素之间会被添加空格进行隔开，并在首尾不i会添加空格
print "there`s nothing in the(@empty)here.\n";
#若要使用整个数组内的字符串，不进行分割要使用转义字符\,邮箱中含有 @ 
$email = "fred@qq.com";
print "$email\n";
$email = "fred\@qq.com";
print "$email\n";	#或者是 $email = 'fred@qq.com'
#索引表达式内插并不会被当作表达式处理：
@fred = qw(hello dolly world tks fds sdv);
$y = 3*2;
$x = "this is $fred[1]";
print "$x\n";
$x = "this is $fred[$y-1]";	#$y没有引号,能够处理表达式，是先把$y计算出来，在插入字符串
print "$x\n";
$y = '3*2';
$x = "this is $fred[$y-1]";	#不会被当作表达式，相当于数字3
print "$x\n";
$y = "3*2";	#不管是单引号还是双引号，在插入到字符串中都被处理成字符串，最终的$x是看外层引号
$x = "this is $fred[$y-1]";
print "this is $fred[$y-1]\n";
print 'this is $fred[$y-1]\n'."\n";
#数组索引的转义：
@fred = qw(erating a kfc dada);
$fred = "wow";
print "$fred[3]\n";		#打印数组的变量
print "$fred\[3]\n";	#下面是打印变量的形式,都进行了转义
print "${fred}[3]\n";
print "$fred"."[3]\n";
###############	foreach:
$var = "init";
@rocks = qw/ byte dance wow/; 
foreach $var (@rocks){
	$var = "\t$var"."\n";	# $var并不是@rocks元素的复制品，就是元素本身：$var被修改了，$rocks元素也就别修改了 
	print "$var";
}
print @rocks;	#已经被修改了
print $var,"\n";	#但是 $var变量在循环结束后会返回初始的值，但在foreach内，变量的值会被改变。
#如果之前没被赋值，就是undef	!! 在foreach中创建已经定义的变量并不影响他的同名变量值
# foreach默认的循环变量值: $_ 
foreach (1..10){
	print $_,' ';
}
print "\n";
$_ = "YYY";
print;	#没有参数，就会打印默认变量：$_的值。
print "\n";
#列表反转reverse:
@rock = 1..10;
@re = reverse(@rock);
print "@re","\n","@rock\n";
#sort排序：
@rocks  = qw'A C B L';
@ssort = reverse sort @rocks;	#reverse(sort(@rocks))
print "@ssort\n";
#each取键值对：
use 5.012;
my @rocks  = qw'A C B L';
while(my($index, $var) = each @rocks){
	say "$index,$var";	#say使用前：5.012版本以上的有say; 而且say有自动换行
}
# 强制 标量(英文:scalar)上下文
use 5.012;
my @rocks = qw'K K L';	#my 局部变量
say scalar @rocks;	#强制使用标量上下文，不使用则打印例表内容，也能够用来获取个数
#	<STDIN>
#在标量上下文中返回一行输入的；在列表上下文中返回列表，一直读取到文件结尾
#如果读取的数据来自键盘，ctrl+D结束
chomp(@lines = <STDIN>);	#能去除所有的行的换行符,读入所有行，除了换行符

