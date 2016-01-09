#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    plan skip_all => "JavaScript::V8x::TestMoreish not available" unless eval { require JavaScript::V8x::TestMoreish };
}

plan qw/no_plan/;

use Lemplate;
use Lemplate::Runtime;

use JavaScript::V8x::TestMoreish;

my $jemplate = Lemplate->new;
my @js;

push @js, $jemplate->compile_template_content( <<_END_, 't0' );
[% BLOCK t1 %]
[% FOREACH a = empty %]
[% END %]
1
[% END %]
_END_

test_js_eval( Lemplate::Runtime->kernel );
test_js_eval( join "\n", @js, "1;" );
test_js <<'_END_';
result = Lemplate.process( 't1', { empty: [] } )
areEqual( result, 1 );
_END_