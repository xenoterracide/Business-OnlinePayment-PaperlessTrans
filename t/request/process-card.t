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
my $dtc        = load_class('DateTime');

my $address
	= new_ok( load_class( $prefix . 'Address' ) => [{
		street  => '400 E. Royal Lane #201',
		city    => 'Irving',
		state   => 'TX',
		zip     => '75039-2291',
		country => 'US',
	}]);

my $id
	= new_ok( load_class( $prefix . 'Identification' ) => [{
		id_type    => 1,
		state      => 'TX',
		number     => '12345678',
		address    => $address,
		expiration => $dtc->new(
			day   => 12,
			month => 12,
			year  => 2009,
		),
		date_of_birth => $dtc->new(
			day   => 12,
			month => 12,
			year  => 1965,
		),
	}]);

my $card
	= new_ok( load_class( $prefix . 'Card' ) => [{
		number           => '4012888888881881',
		security_code    => '999',
		name_on_account  => 'John Doe and Associates',
		email_address    => 'JohnDoe@TestDomain.com',
		address          => $address,
		identification   => $id,
		expiration_month => '12',
		expiration_year  => '2015',
	}]);

my $token
	= new_ok( load_class( $prefix . 'AuthenticationToken' ) => [{
		terminal_id  => $ENV{PERL_BUSINESS_BACKOFFICE_USERNAME},
		terminal_key => $ENV{PERL_BUSINESS_BACKOFFICE_PASSWORD},
	}]);

my $req
	= new_ok( load_class( $req_prefix . '::ProcessCard' ) => [{
		amount       => 4.32,
		currency     => 'USD',
		card         => $card,
		card_present => 0,
		test         => 1,
		token        => $token,
	}]);


my $client
	= new_ok( load_class('Business::PaperlessTrans::Client') => [{
		debug => $ENV{PERL_BUSINESS_BACKOFFICE_DEBUG},
	}]);

my $res = $client->submit( $req );

isa_ok $res, 'Business::PaperlessTrans::Response::ProcessCard';

ok $res->is_approved;
is $res->code,     0;
is $res->message, '';

done_testing;
