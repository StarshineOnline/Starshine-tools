#!/usr/bin/perl

use JSON;
use CGI;
use Config::Simple;

my $q = new CGI;
my $json_text = $q->param('payload');

#open FILE, ">>", "/tmp/git.log" or die $!;
#print FILE "\n---\n", $json_text, "\n***\n";

my $json = new JSON;
my $perl_scalar = $json->jsonToObj( $json_text );

print $q->header(-type  =>  'text/plain');

#print FILE $json->objToJson($perl_scalar, {pretty => 1, indent => 2}), "\n----\n";
#close FILE;

$cfg = new Config::Simple('/home/starshine/config.sh');

my %o = %$perl_scalar;
my $rep = $o{repository};
my $repo_name = $$rep{name};
my $com = $o{commits};
my @commits = @$com;

if ($repo_name eq 'Starshine-images') {
    chdir $cfg->param('PROD_IMG');
    system ("git pull");
		system ("chmod g+w cart carte cart/carte_roy_*");
}
if ($repo_name eq 'Starshine-Online') {
    chdir $cfg->param('REPO');
    system ("git fetch origin '+refs/heads/*:refs/heads/*'");
    system ("git reset --soft master");
    my $isActeon = 0;
    for (@commits) {
	my %c = %$_;
	my $author = $c{author};
	my $username = $$author{username}; print "$username\n";
	if ($username eq 'Acteon') {
		$isActeon = 1;
		last;
	}
    }
    if ($isActeon) {
	$prod = $cfg->param('PROD');
	system ("git archive master css | tar -x -C $prod");
	system ("git archive master admin | tar -x -C $prod");
    }
}
if ($repo_name eq 'Starshine-tools') {
    print "tools !\n";
    chdir $cfg->param('REPO_TOOLS');
    system ("git pull");
}

print "Done !";
