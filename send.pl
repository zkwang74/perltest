#!/usr/bin/perl
# use Encode;

my $url;
my $pid;
$url = <STDIN>;
if ($url=~/\/1\/1\/[1,2]\/(.*).htm/)
{ $pid = $1; }
elsif ($url=~/new/)
{ $pid = "/1234567890"; }


my $mess;
$mess = <STDIN>;
chomp ($mess);

#$mess = decode("gb2312",$mess);
#$mess = encode("utf8",$mess);


my $run;

$run = qq(curl --socks5-hostname 127.0.0.1:9050  -A "User-Agent: Mozilla/5.0 compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0;" -d "parentId=$pid&bid=1&titleText=$mess" http://bbs1.people.com.cn/postAction.do --cookie "wdcid=2c0c70d4f0f82ec7; sfr=1; Hm_lvt_856125158c5af6972b8b184c5c3bfa7b=1530415086; wdses=50b8941f6a1ada7e; sso_u=bgv+AgLEAXP8JlHfI7dyFVbnZTYKZFs6; sso_s=fb3aae39837d48c780e7daa6c89cd7e2Z4EDekwc; sso_l=GKPyFVPEilZ+; sso_c=1; wdlast=1538549064");


# socks5proxy
# $run = qq(curl --socks5-hostname 192.168.0.3:7070  -d "parentId=$pid&bid=1&titleText=$mess" http://bbs1.people.com.cn/postAction.do --cookie "sso_c=1; sso_l=GKPyFVPEilZ+; __utma=259091912.61095731.1506853563.1506853563.1506853563.1; __utmb=259091912.3.10.1506853563; __utmc=259091912; __utmz=259091912.1506853563.1.1.utmcsr=blog.people.com.cn|utmccn=(referral)|utmcmd=referral|utmcct=/jump.do; __utmt=1; JSESSIONID=3B8BFF06C98D7E95E92ED9D71FBD83B2; sso_s=893c1a8ec2624844946be13bbe4e410aRBi9BBZF; sso_u=bgv+AgLEAXP8JlHfI7dyFVbnZTYKZFs6");


system ("$run");
print "\n $pid $mess \n";

open (f1,">>/tmp/mess.txt");
print f1 "\n$pid:$mess";
close f1;
