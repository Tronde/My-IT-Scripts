#!/usr/bin/perl
# rdp_connect.pl is a small program to connect to windows hosts via rdesktop.
# Author: Joerg Kastning
# Organisation: Bielefeld University
# Date created: 2015-04-25
use strict; # Hilft Tippfehler zu finden. ;-)
use warnings; # Gibt ausführlichere Fehlermeldungen aus.
# use diagnostics; # Gibt noch ausführliche Meldungen aus.
use FindBin;
use File::Slurp;

chdir $FindBin::Bin;

my $datei = 'hosts.txt';
my %kommando = ( verbinden => 'v', eintragen => 'n', bewege => 'm', loesche => 'd', beenden => 'e' );

append_file($datei) unless -e $datei;
my @notizen = read_file($datei);
my @sorted_notizen = @notizen;
for my $nr (0 .. $#sorted_notizen)
	{ print "[$nr] ", $sorted_notizen[$nr] }
print "Was moechtest du tun? ($kommando{'eintragen'} Neuer Eintrag; $kommando{'verbinden'} Verbindung zu Host; $kommando{'loesche'} loescht Eintrag; $kommando{'bewege'} verschiebt Eintrag); $kommando{'beenden'} Exit: ";
my $notiz = <STDIN>;
given ( lc substr($notiz, 0, 1) ) {
	when ($kommando{'verbinden'}) {}
	when ($kommando{'beenden'}) { }
	when ($kommando{'eintragen'}) {print "Gib den FQDN ein: ";
			$notiz = <STDIN>;
			append_file($datei, $notiz);
	} 
	when ($kommando{'loesche'}) {
		continue if length($notiz) == 2;
		my $nr = int substr($notiz, 1);
		splice(@notizen, $nr, 1) if $nr >= 0 and $nr <= $#notizen;
		write_file($datei, @notizen);
	}
	when ($kommando{'bewege'}) {
		continue if length($notiz) == length($kommando{'bewege'})+1;
		my($von, $zu) = split ':',
			substr($notiz, length($kommando{'bewege'}));
	}
}
