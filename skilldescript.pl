#!perl
package skilldescript;

use strict;
use warnings;
use autodie qw(:filesys :file);

no warnings qw(uninitialized once);

my $targetFile = shift;
my (@handle,@desc);

open(T, "<", $targetFile);

while (my $T = <T>) {
	if ($T =~ /^[ \t]*\[SKID\.(.*)\][ \t]*=[ \t]*{(.*)}/){
		push(@handle,$1);
		push(@desc,$2);
	}
}

open(O, ">:encoding(UTF-8)", "skillsdescriptions.txt");

for (my $i;$i<@handle;$i++) {
	my @descCache = split(/", "/, $desc[$i]);
	
	print O $handle[$i]."#\n";
	for (my $i2;$i2<@descCache;$i2++) {
		$descCache[$i2] =~ s/^.// if ($descCache[$i2] eq $descCache[0]);
		$descCache[$i2] =~ s/.$// if ($descCache[$i2] eq $descCache[-1]);
		print O $descCache[$i2]."\n";
	}
	print O "#";
	print O "\n" unless ($handle[$i] eq $handle[-1]);
}

close O;