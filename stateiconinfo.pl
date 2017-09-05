#!perl
package stateiconinfo;

use strict;
use warnings;
use autodie qw(:filesys :file);

no warnings qw(uninitialized once);

my $targetFile = shift;
my (@handle,@name);
my $toggle = 0;

open(T, "<", $targetFile);

while (my $T = <T>) {
	if ($T =~ /^StateIconList\[EFST_IDs\.(.*)\].*/){
		if ($toggle != 0) {
			push(@name,"Desconhecido");
		}
		push(@handle,$1);
		$toggle = 1;
	} elsif ($T =~ /descript = \{/ && $toggle == 1) {
		$toggle = 2;
	} elsif ($T =~ /\{"(.*)",.*TITLE.*/ && $toggle == 2) {
		push(@name,$1);
		$toggle = 0;
	}
}

open(O, ">:encoding(UTF-8)", "statusnametable.txt");

for (my $i;$i<@handle;$i++) {
	next if $name[$i] eq "Desconhecido";
	print O $handle[$i]." ".$name[$i];
	print O "\n" unless ($handle[$i] eq $handle[-1]);
}

close O;
