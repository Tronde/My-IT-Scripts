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
if ( lc substr($notiz, 0, 1) eq $kommando{'verbinden'}) { }
elsif (lc substr($notiz, 0, 1) eq $kommando{'beenden'}) { }
elsif (lc substr($notiz, 0, 1) eq $kommando{'eintragen'}) {
	print "Gib den FQDN ein: ";
	$notiz = <STDIN>;
	append_file($datei, $notiz);
	} 
elsif (lc substr($notiz, 0, 1) eq $kommando{'loesche'}) {
		continue if length($notiz) == 2;
		my $nr = int substr($notiz, 1);
		splice(@notizen, $nr, 1) if $nr >= 0 and $nr <= $#notizen;
		write_file($datei, @notizen);
	}
elsif ($lc substr($notiz, 0, 1) eq kommando{'bewege'}) {
		continue if length($notiz) == length($kommando{'bewege'})+1;
		my($von, $zu) = split ':',
			substr($notiz, length($kommando{'bewege'}));
		$von = int $von;
                 $zu = int $zu;
                 continue if $zu < 0 or $zu > $#notizen;
                 splice(@notizen, $zu, 0, splice(@notizen, $von, 1));
                 write_file($datei, @notizen);
	}
else {
	say "Hier wird mal ein Hilfe-Text stehen.";
}