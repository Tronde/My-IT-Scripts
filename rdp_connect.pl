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
my $domain = 'ad.uni-bielefeld.de';
my $keyboard_layout = 'de';
my $cmd = 'rdesktop -d $domain -k $keyboard_layout -0 $host';

append_file($datei) unless -e $datei;
my @hosts = read_file($datei);
my @sorted_hosts = sort @hosts;
for my $nr (0 .. $#sorted_hosts)
	{ print "[$nr] ", $sorted_hosts[$nr] }
print "Was moechtest du tun? ($kommando{'eintragen'} Neuer Eintrag; $kommando{'verbinden'} Verbindung zu Host; $kommando{'loesche'} loescht Eintrag; $kommando{'bewege'} verschiebt Eintrag); $kommando{'beenden'} Exit: ";
my $input = <STDIN>;
if ( lc substr($input, 0, 1) eq $kommando{'verbinden'}) {
		continue if length($input) == 2;
		my $host = int substr($input, 1);
		system($cmd);
	}
elsif (lc substr($input, 0, 1) eq $kommando{'beenden'}) { }
elsif (lc substr($input, 0, 1) eq $kommando{'eintragen'}) {
	print "Gib den FQDN ein: ";
	$input = <STDIN>;
	append_file($datei, $input);
	} 
elsif (lc substr($input, 0, 1) eq $kommando{'loesche'}) {
		continue if length($input) == 2;
		my $nr = int substr($input, 1);
		splice(@sorted_hosts, $nr, 1) if $nr >= 0 and $nr <= $#sorted_hosts;
		write_file($datei, @sorted_hosts);
	}
elsif (lc substr($input, 0, 1) eq kommando{'bewege'}) {
		continue if length($input) == length($kommando{'bewege'})+1;
		my($von, $zu) = split ':',
			substr($input, length($kommando{'bewege'}));
		$von = int $von;
                 $zu = int $zu;
                 continue if $zu < 0 or $zu > $#sorted_hosts;
                 splice(@sorted_hosts, $zu, 0, splice(@sorted_hosts, $von, 1));
                 write_file($datei, @sorted_hosts);
	}
else {
	my $text="Hier wird mal ein Hilfe-Text stehen.";
	say $text;
}
