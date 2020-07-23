#hash的引用 { }.	键值不存在的时候，返回undef
$name = 10;
$name[0] = 'QQ';	#不受影响，hash有自己命名空间
$name{'fred'} = 'flintstone';
$name{'barney'} = 'rubble';
foreach my $var (qw'barney fred'){
	printf("$var : $name{$var}\n");
}
#{}内可以是表达式
$n = 'bar';
printf("$name{$n.'ney'}\n");
#用 % ( )创建hash，	%得到整个hash
%hs = ('foo',35,'bar',12.4,1,'1_',3,'1_');
printf("$hs{1}\n"); #键1，值1_
# % () => 创建hash: 键 => 值
my %last_name=('fred'=>'flintstone',
				'dino'=>undef,
				 barney=>'rubble',
				 betty=>'rubble'	#键可以不加引号（不加引号的键的序列称为-裸字）：只能是字母、数字、下划线组成，并不以数字开头
			#	+ => 'KKL'	
);
#检索时也可使用裸字：(只要是裸字就会当成表达式先求值后在作为键,双引号内也会当成表达式
$hs{"bar.foo"} = 1;
print("## $hs{barfoo}\n");

#展开hash,但是得到的键值对的顺序不是和原先一样的，hash在存储的时候做了处理
@ararry = %hs;	
print "@ararry\n";
#hash的复制：(具体把old展开为键值对列表，然后又重新构造了每个键值对
my %new_hash = %old_hash;
#reverse可以反转hash: 键-值 变成 值-键。
#键值对中不同键的值有会相同的，先反转的值键会被覆盖。但不能指定反转的顺序，所以原先的键值对的值最好唯一
#如：ip-主机 主机-ip
my %inverse_hash = reverse %any_hash;

#hash中的 keys 、values 可以分别返回键和值的列表
my %hash = ( a=>1,
			b=>2,
			c=>3
);
my @k = keys %hash;
my @v = values %hash;
printf("@k\n@v\n");	#k 和v的各自的索引处都是原先的键值，
#后hash在插入键值对时，仍能保持键值对的匹配，但是可能不在原先kv的地方，内存会重新排序
#标量语境：
my $count = keys %hash;	#得到键的个数
print("$count\n");
if(%hash){	#只要有键值对就不时空，标量语境
	print("hash is not empty\n");
}
#each哈希：
while(($key,$value) = each %hash){ #结果实际是返回的键值对列表。
#注：这个while是一个标量上下问，while实际判断的是键值对的个数。最后为0假的时候就结束了
	printf("$key => $value\n");
}
#对键值对进行排序，按照键、值都可以实现：
foreach $key (sort keys %hash){
	$value = $hash{$key};
	printf("fe: $key => $value\n");
}
#判断键是否存在
$hash{k} = undef;
if(!exists $hash{k}){ #只判断键，不管对应的值是0还是undef
	printf("not empty\n");
}else{
	print("empty\n");
}
#删除一个键值对,键和值都删除
delete $hash{k};