use strict;
use warnings;
use Test::More;
use Class::Load 0.20 'load_class';

plan skip_all => 'PERL_BUSINESS_BACKOFFICE_USERNAME and/or'
	. 'PERL_BUSINESS_BACKOFFICE_PASSWORD not defined in ENV'
	unless defined $ENV{PERL_BUSINESS_BACKOFFICE_USERNAME}
	&& defined $ENV{PERL_BUSINESS_BACKOFFICE_PASSWORD};

my $req_prefix = 'Business::PaperlessTrans::Request';
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
	= new_ok( load_class('Business::PaperlessTrans::Client') => [{
		debug => 1,
	}]);

my $res = $client->submit( $req );

isa_ok $res, 'Business::PaperlessTrans::Response::TestConnection';

done_testing;
