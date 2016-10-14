#!perl
package skillinfolist;

use strict;
use warnings;
use autodie qw(:filesys :file);

no warnings qw(uninitialized once);

my $targetFile = shift;
my (@handle,@name);

open(T, "<", $targetFile);

while (my $T = <T>) {
	if ($T =~ /^[ \t]*\[\[(.*)\]\],/){
		push(@handle,$1);
	} elsif ($T =~ /^[ \t]*SkillName \= \[\[(.*)\]\],/i) {
		push(@name,$1);
	}
	
	last if eof;
	next;
}

open(O, ">:encoding(UTF-8)", "output.txt");

for (my $i;$i<@handle;$i++) {
	print O $handle[$i]."#".$name[$i]."#";
	print O "\n" unless ($handle[$i] eq $handle[-1]);
}