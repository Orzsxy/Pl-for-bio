# // 在匹配的时候其实省略了m, : m//
######################模式匹配修饰符：
# /i 不判断大小写
#chomp($_=<STDIN>);
$_ ='YEs';
if(m/yes/i){
	print"Case1:ok\n";
}
# /s 实现真正的匹配任意字符
#.只能匹配非换行符，/s修饰能匹配含有换行符的串
$_ = " I saw Barney\ndown at the bowling alley\nwith Fred\nlast night.\n";
if(m/Barney.*Fred/s){#不加修饰符会失败，因为不在同一行
	print"Case2:That string mentions Fred after Barney!\n";
}
# /x 表达式中忽略空格、制表符，而且#作为空白符，要是想匹配#，需进行转义 \#
$_ = '9';
if(m/-? [0-9]+ \.? [0-9]*/x){ 
	printf("Case3: okk\n");
}
if(m/
		-? 		#-可有可无
		[0-9]+ 	#至少一个数字
		\.? 	#.可有可无
		[0-9]*	#可有可无的数字
	/x){ 
	printf("Case4: okkL\n");
}
#在组合使用的时候不用考虑先后顺序，都一样
$_ = "Barney \n Fred";
if (/barney.*fred/is){#同时使用/i和/s
    print "Case5:That string mentions Fxed after Barney!\n";
}
# \i \z \x 注意结合着使用。

###############锚位---之前的模式匹配都是在字符串中的任意位置进行匹配，锚位是指在任意字符串的指定位置
# \A 开头位置
$_ = "http:// Barney \n Fred";
if (m{\Ahttps?://}is){#同时使用/i和/s
    print "Case6: https?:// at head\n";
}else{
	print "Case6: https?:// not at head\n";
}
# \z 在末尾位置匹配，\Z放在模式末尾。前提是字符串后面不能有换行\n
$_ = " Fred.jpg\n";
if (m{\.jpg\z}is){
    print "Case7:.jpg  at end postion\n";
}else{
	print "Case7: .jpg not at end postion \n";
}
# \Z 也是在末尾匹配，\Z放在模式末尾。但是字符串中可以有空格，\Z匹配的时候会自动忽略换行
$_ = " Fred.jpg\n";
if (m{\.jpg\Z}is){#同时使用/i和/s
    print "Case8: .jpg  at end postion\n";
}else{
	print "Case8: .jpg not at end postion\n";
}
#判断从终端输入的是不是以指定结尾:
#while(<STDIN>){
#	print if m{\.jpg\Z};	#自动去掉换行
#}
#while(<STDIN>){
#	chomp;	#先手动去掉换行 在用\z判断不含换行的串
#	print if m{\.jpg\z};	
#}
# \A \Z \z 注意结合着使用。这时在Perl5开始出现的特性，Perl4开始锚位是:^,末尾锚位:$,相当于\Z 

#多行处理：
# 对于行首和字符串首，对计算机$_的字符串并不关心具体内容，就是一堆字符串，即便里面有好多换行.
#但对人来讲换行符起到分割字符单元的作用，看起来就是多行文本。好像是堆废话
$_ = 'This is a wilma line
barney is on another line
but this ends in fred
and a final dino line';
#找出行末出现(对人)fred的字符串，(对人理解来说：不是在整个字符串的末尾出现fred的位置)
if(/fred$/m){ #使用的是perl4的末尾锚位$ ,m 保证了多行处理
	print"fred at line-end\n";
}
if(/^barney/m){ #使用的是perl4的末尾锚位$ ,m 保证了多行处理
	print"barney at line-start\n";
}
################单词锚位，提取完整单词，而不是部分片段
#锚位并不局限于字符串首尾。\b是单词边界锚位，匹配任何单词的首尾
#因此，/\bfred\b/ 可匹配fred，但无法匹配frederick, alfred或manfredmann。称为“整词匹配”。
#在图8-1中，每个词下方会出现灰色下划线，\b能匹配的位置以箭头标识。因为每个单词
#都会有开头与结尾，所以字符串中的单词边界一定是偶数个。此处所谓的“单词”，是指一连串英文字母、数字与下划线的组合，也就是匹配/\w+/
#模式的字符串。该句共有5个单词:丁hat, s, a, word以及boundary[注’3]。要注意的
#word两边的引号并不会改变单词边界:这些单词是由一组\w字符构成的。
#单词边界锚位\b只匹配每组\w字符的开头或结尾，所以每个箭头会指向灰色下划线的开头或者结尾。
#单词边界锚位保证不会意外地在delicatessen中找到cat，在boondoggle中找到dog。
#有时候，你只会用到一个单词边界锚位，像用/\bhunt/来匹配hunt, hunting排除了shunt
#或是用/stone\b/来匹配standstone或flintstone，但不包括capstones
#非单词边界锚位: \B，它能匹配\b不能匹配的位置。因此，模式/\bsearch\B/会匹配searches, searching与searched，但不匹配search或researching


# 绑定操作符 =~ 替换了$_ .除了模式其他也会有用到 =~
my $som = " I dream a of dream for rubble";
if($som =~/\brub/){
	print "wow\n";
}
#my $like = (<STDIN> =~ /\byes\b/i); #被赋值为布尔类型,只有在while条件表达式中有<STDIN>时，输入值会被自动存入$_
#if($like){
#	print"nice\n";
#}
# =~的优先级很高可以不加括号:
#my $like = <STDIN>=~/\yes\b/i;

#模式中的内插：
my $what = 'larry';
while(<>){ #<>是从数组@ARGV中得到的参数 如果@ARGV是空 就使用标准输入流中输入的内容
	if(/\A($what)/){ #括号带着好
		print"We saw $what in beginning of $_";
	}
}
#不管$what的内容是什么，模式都会由$what的值决定。在这等效于/\A(larry)/，也就是在每行的开头寻找larry
# $what的内容不一定写在直接量中，可以从@ARGV获取。
# my $what = shift @ARGV; 出队列

