#!/usr/bin/perl

use JSON;
use CGI;

$q = new CGI;
$json_text = $q->param('payload');

open FILE, ">>", "/tmp/git.log" or die $!;
print FILE "\n---\n", $json_text, "\n***\n";

$json = new JSON;
$perl_scalar = $json->jsonToObj( $json_text );

print $q->header(-type  =>  'text/plain');

for ($perl_scalar{'commits'}) {
    print "+ $_ \n";
}

#print FILE $perl_scalar, "\n+++\n";

print FILE $json->objToJson($perl_scalar, {pretty => 1, indent => 2}), "\n----\n";
close FILE;

%o = %$perl_scalar;
$rep = $o{repository};
$repo_name = $$rep{name};
@commits = @$o{commits};

if ($repo_name eq 'Starshine-images') {
    chdir '';
    `git pull`;
}
if ($repo_name eq 'Starshine-Online') {

}
if ($repo_name eq 'Starshine-tools') {
    print "tools !\n";
    chdir '/srv/starshine-data/git_repo/Starshine-tools';
    `git pull`;
}


