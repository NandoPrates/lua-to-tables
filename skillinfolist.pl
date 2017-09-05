#!perl
package skillinfolist;

use strict;
use warnings;
use autodie qw(:filesys :file);

no warnings qw(uninitialized once);

my $targetFile = shift;
my (@handle,@name,@spamount);

open(T, "<", $targetFile);

while (my $T = <T>) {
	if ($T =~ /^[ \t]*\[(\[)?.*(\])?\] = \{"(.*?)";[ \t]*SkillName[ \t]*=[ \t]*"(.*?)",/){
		push(@handle,$3);
		push(@name,$4);
	} elsif ($T =~ /^[ \t]*SpAmount[ \t]*=[ \t]*{(.*)}/) {
		push(@spamount,$1);
	}
}

open(O, ">:encoding(UTF-8)", "skillnametable.txt");

for (my $i;$i<@handle;$i++) {
	print O $handle[$i]."#".$name[$i]."#";
	print O "\n" unless ($handle[$i] eq $handle[-1]);
}

close O;
open(O, ">:encoding(UTF-8)", "skillssp.txt");

for (my $i;$i<@handle;$i++) {
	next if ($spamount[$i] =~ /^0,/);

	my @spCache = split(/, /, $spamount[$i]);
	
	print O $handle[$i]."#\n";
	for (my $i2;$i2<@spCache;$i2++) {
		print O $spCache[$i2]."#\n";
	}
	print O "@";
	print O "\n" unless ($handle[$i] eq $handle[-1]);
}

close O;