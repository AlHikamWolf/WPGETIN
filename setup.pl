#!/usr/bin/perl
#github:AlHikamWolf
use LWP::UserAgent;
use HTTP::Response;
use Term::ANSIColor;
use URI::URL;
my $ua = LWP::UserAgent->new;
$ua->timeout(10);
sub banner() {
if ($^O =~ /MSWin32/) {system("cls"); }else { system("clear"); }
print color('white');
print q(
	@@@  @@@  @@@  @@@@@@@    @@@@@@@@  @@@@@@@@  @@@@@@@  @@@  @@@  @@@  
	@@@  @@@  @@@  @@@@@@@@  @@@@@@@@@  @@@@@@@@  @@@@@@@  @@@  @@@@ @@@  
	@@!  @@!  @@!  @@!  @@@  !@@        @@!         @@!    @@!  @@!@!@@@  
	!@!  !@!  !@!  !@!  @!@  !@!        !@!         !@!    !@!  !@!!@!@!  
	@!!  !!@  @!@  @!@@!@!   !@! @!@!@  @!!!:!      @!!    !!@  @!@ !!@!  
	!@!  !!!  !@!  !!@!!!    !!! !!@!!  !!!!!:      !!!    !!!  !@!  !!!  
	!!:  !!:  !!:  !!:       :!!   !!:  !!:         !!:    !!:  !!:  !!!  
	:!:  :!:  :!:  :!:       :!:   !::  :!:         :!:    :!:  :!:  !:!  
	 :::: :: :::    ::        ::: ::::   :: ::::     ::     ::   ::   ::  
	  :: :  : :     :         :: :: :   : :: ::      :     :    ::    :   
			GitHub: AlHikamWolf
);}
banner();
unless ($list) { lulz(); }
sub lulz { print color('green'),"\n	Targets: ";
$list=<STDIN>;
open (THETARGET, "<$list"); @TARGETS = <THETARGET>; close THETARGET;
$link=$#TARGETS + 1; print color('reset');
OUTER: foreach $site(@TARGETS){ chomp($site); $a++; wp();}

#SCANNING
sub wp(){
$ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");
$ua->timeout (15);
my $wp = $ua->get("http://$site")->content;
if($wp =~/wp-content|wp-includes|wp-json/) {
print color('yellow'),"\n * ";print color('white'),"http://$site\n";
print color('reset');
	open(save, '>>check.txt');
	print save "\nURL : http://$site/\n";
	close(save);
	get_user();
	get_theme();
	get_plugin();
	get_version();
}else{ print color('red'),"\n X ";print color('white'),"http://$site\n";print color('reset');}}

sub get_user(){
$url = "http://$site/";
$user = $url . '/?author=1';
$getuser = $ua->get($user)->content;
if($getuser =~/author\/(.*?)\//){
	print " WP_USER : $1\n";
	open(save, '>>check.txt');
	print save " User : $1\n";
close(save);
}else{
	print color('yellow')," Scanning.. ";
	print color('red'),"USER NOT FOUND!\n";
	print color('reset');
}}

#get_theme
sub get_theme{
$url = "http://$site/";
$resp = $ua->request(HTTP::Request->new(GET => $url ));
$cont = $resp->content;
if($cont =~ /wp-content\/themes\/(.*?)\//){
	print " WP_THEME : $1\n";
	open(save, '>>check.txt');
	print save " Theme : $1\n";
close(save);
}else{
	print color('yellow')," Scanning.. ";
	print color('red'),"THEME NOT FOUND!\n";
	print color('reset');
}}

#get_plugin
sub get_plugin{
$url = "http://$site/";
$resp = $ua->request(HTTP::Request->new(GET => $url ));
$cont = $resp->content;
my %gets;
while($cont =~m/\/wp-content\/plugins\/(.*?)\//g){
$plugin=$1;
next if $gets{$plugin}++;
	print " WP_PLUGIN: $plugin \n";
	open(save, '>>check.txt');
	print save " Plugin : $1\n";
close(save);
}}

#get_version
sub get_version{
$url = "http://$site/";
$resp = $ua->request(HTTP::Request->new(GET => $url ));
$cont = $resp->content;
if($cont =~ /name="generator" content="(.*?)"/){
	print " WP_VERSION : $1\n";
	open(save, '>>check.txt');
	print save " Version : $1\n";
close(save);
}else{
	print color('yellow')," Scanning.. ";
	print color('red'),"VERSION NOT FOUND!\n";
	print color('reset');
}}}