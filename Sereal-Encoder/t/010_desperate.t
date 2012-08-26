#!perl
use strict;
use warnings;
# most be loaded before Sereal::TestSet
use Sereal::Encoder qw(encode_sereal);
use Sereal::Encoder::Constants qw(:all);
use Data::Dumper;
use File::Spec;

use lib File::Spec->catdir(qw(t lib));
BEGIN {
  lib->import('lib')
    if !-d 't';
}

use Sereal::TestSet qw(:all);

# These tests are extraordinarily basic, badly-done and really just
# for basic sanity testing during development.

use Test::More;

run_tests("plain");
run_tests("no_shared_hk", {no_shared_hashkeys => 1});
done_testing();

sub run_tests {
  my ($extra_name, $opt_hash) = @_;
  foreach my $bt (@BasicTests) {
    my ($in, $exp, $name) = @$bt;
    $name="unnamed";
    #next unless $name=~/PAD/;

    $exp = "$Header$exp";
    my $enc = Sereal::Encoder->new($opt_hash ? $opt_hash : ());
    my $out = $enc->encode($bt->[0]); # must use bt here or we get a copy
    ok(defined $out, "($extra_name) defined: $name");
    #is(length($out), length($exp));
    is(Data::Dumper::qquote($out), Data::Dumper::qquote($exp), "($extra_name) correct: $name")
      or do {
        if ($ENV{DEBUG_SEREAL}) {
          print STDERR "\nEXPECTED:\n";
          hobodecode($exp);
          print STDERR "\nGOT:\n";
          hobodecode($out);
          print STDERR "\n";
        }
      };
  }
}

