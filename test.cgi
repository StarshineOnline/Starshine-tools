#!/usr/bin/perl

use JSON;
use CGI;

my $q = new CGI;
my $json_text = $q->param('payload');

#open FILE, ">>", "/tmp/git.log" or die $!;
#print FILE "\n---\n", $json_text, "\n***\n";

my $json = new JSON;
my $perl_scalar = $json->jsonToObj( $json_text );

print $q->header(-type  =>  'text/plain');

#print FILE $json->objToJson($perl_scalar, {pretty => 1, indent => 2}), "\n----\n";
#close FILE;

my %o = %$perl_scalar;
my $rep = $o{repository};
my $repo_name = $$rep{name};
my $com = $o{commits};
my @commits = @$com;

if ($repo_name eq 'Starshine-images') {
    chdir '/srv/starshine-data/starshine/image';
    system ("git pull");
}
if ($repo_name eq 'Starshine-Online') {
    chdir "/srv/starshine-data/git_repo/Starshine-Online";
    system ("git fetch");
    system ("git reset --soft refs/remotes/origin/master");
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
	system ("git archive master css | tar -x -C /srv/starshine-data/starshine/starshine071");
	system ("git archive master admin | tar -x -C /srv/starshine-data/starshine/starshine071");
    }
}
if ($repo_name eq 'Starshine-tools') {
    print "tools !\n";
    chdir '/srv/starshine-data/git_repo/Starshine-tools';
    system ("git pull");
}

print "Done !";
