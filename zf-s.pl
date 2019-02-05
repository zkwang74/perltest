#!/usr/bin/perl 

# use Crypt::RC4;
  
$auth_enabled = 0; 
$auth_login = "google"; 
$auth_pass = "google"; 
$port = 60024; 
$host_s = '45.78.18.176';
$port_s = 8888;
$passphrase = 'abcdefghijklmn';
  
use IO::Socket::INET; 
  
$SIG{'CHLD'} = 'IGNORE'; 
$bind = IO::Socket::INET->new(Listen=>30, Reuse=>1, LocalPort=>$port) or die "cannot listen $port\n"; 
  
while($client = $bind->accept()) { 
$client->autoflush(); 
  
if(fork()){ $client->close(); } 
else { $bind->close(); socks_connect($client); exit(); } 
} 
  
  

sub socks_connect { 
my $target = IO::Socket::INET->new(PeerAddr => $host_s, PeerPort => $port_s, Proto => 'tcp', Type => SOCK_STREAM); 
  
unless($target) { return; } 
  
$target->autoflush(); 
while($client || $target) { 
 my $rin = ""; 
 vec($rin, fileno($client), 1) = 1 if $client; 
 vec($rin, fileno($target), 1) = 1 if $target; 
 my($rout, $eout); 
 select($rout = $rin, undef, $eout = $rin, 120); 
 if (!$rout && !$eout) { return; } 
 my $cbuffer = ""; 
 my $tbuffer = ""; 
  
 if ($client && (vec($eout, fileno($client), 1) || vec($rout, fileno($client), 1))) { 
 my $result = sysread($client, $tbuffer, 1024); 

# crypt code
# $tbuffer = RC4( $passphrase, $tbuffer ); 


$o = unpack ('H*',$tbuffer);
$o =~tr/0/Q/d;
$o =~tr/5/W/d;
$o =~tr/1/L/d;
$o =~tr/3/M/d;
$o =~tr/M/1/d;
$o =~tr/L/3/d;
$o =~tr/Q/5/d;
$o =~tr/W/0/d;
$tbuffer = pack ('H*',$o);




 if (!defined($result) || !$result) { return; } 
 } 
  
 if ($target && (vec($eout, fileno($target), 1) || vec($rout, fileno($target), 1))) { 
 my $result = sysread($target, $cbuffer, 1024); 

# $cbuffer = RC4( $passphrase, $cbuffer ); 
$o = unpack ('H*',$cbuffer);
$o =~tr/0/Q/d;
$o =~tr/5/W/d;
$o =~tr/1/L/d;
$o =~tr/3/M/d;
$o =~tr/M/1/d;
$o =~tr/L/3/d;
$o =~tr/Q/5/d;
$o =~tr/W/0/d;
$cbuffer = pack ('H*',$o);


 if (!defined($result) || !$result) { return; } 
 } 
  
 if ($fh && $tbuffer) { print $fh $tbuffer; } 
  
 while (my $len = length($tbuffer)) { 

 my $res = syswrite($target, $tbuffer, $len); 
 if ($res > 0) { $tbuffer = substr($tbuffer, $res); } else { return; } 
 } 
  
 while (my $len = length($cbuffer)) { 
 my $res = syswrite($client, $cbuffer, $len); 
 if ($res > 0) { $cbuffer = substr($cbuffer, $res); } else { return; } 
 } 
} 
} 
  