use strict;
use warnings;
use Test::More;
use Test::Method;
use Class::Load 0.20 'load_class';
use Test::Requires::Env qw(
	PERL_BUSINESS_BACKOFFICE_USERNAME
	PERL_BUSINESS_BACKOFFICE_PASSWORD
);

my $req_prefix = 'Business::BackOffice::Request';
my $prefix     = $req_prefix . 'Part::';

my $token
	= new_ok( load_class( $prefix . 'AuthenticationToken' ) => [{
		terminal_id  => $ENV{PERL_BUSINESS_BACKOFFICE_USERNAME},
		terminal_key => $ENV{PERL_BUSINESS_BACKOFFICE_PASSWORD},
	}]);

my $req
	= new_ok( load_class( $req_prefix . '::TestConnection' ) => [{
		token => $token,
	}]);

my $client
	= new_ok( load_class('Business::BackOffice::Client') => [{
		debug => 1,
	}]);

$client->submit( $req );

done_testing;
