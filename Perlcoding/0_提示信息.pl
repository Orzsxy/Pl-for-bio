#!/usr/bin/perl
#warnings比-w灵活，对文件中使用了编译指令的部分代码给出提示信息，-w对整个程序涉及的代码有警示信息作用
use warnings;
#使用-w的方式：
perl -w my_program	#在命令行中
#!usr/bin/perl-w
#如把字符当数字使用就会提示:Argument ’...‘ isn`t numeric
use diagnostics; #消除上面的提示，但会消耗内存，速度变慢
# %ENV哈希:返回系统的环境路径配置信息，PATH是os设置的变量名，不同操作系间有差异
printf("PATH is $ENV{PATH}\n");

