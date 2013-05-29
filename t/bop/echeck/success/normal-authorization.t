use strict;
use warnings;
use Test::More;
use Class::Load 0.20 'load_class';

plan skip_all => 'PERL_BUSINESS_BACKOFFICE_USERNAME and/or'
	. 'PERL_BUSINESS_BACKOFFICE_PASSWORD not defined in ENV'
	unless defined $ENV{PERL_BUSINESS_BACKOFFICE_USERNAME}
	&& defined $ENV{PERL_BUSINESS_BACKOFFICE_PASSWORD};

my $tx = new_ok( load_class('Business::OnlinePayment') => [ 'PaperlessTrans' ]);

isa_ok $tx, 'Business::OnlinePayment::PaperlessTrans';

$tx->test_transaction(1);

$tx->content(
	login          => $ENV{PERL_BUSINESS_BACKOFFICE_USERNAME},
	password       => $ENV{PERL_BUSINESS_BACKOFFICE_PASSWORD},
	debug          => $ENV{PERL_BUSINESS_BACKOFFICE_DEBUG},
	type           => 'ECHECK',
	action         => 'Normal Authorization',
	check_number   => '132',
	amount         => 1.32,
	routing_code   => 111111118,
	account_number => 12121214,
	name           => 'Caleb Cushing',
	address        => '400 E. Royal Lane #201',
	city           => 'Irving',
	state          => 'TX',
	zip            => '75039-2291',
	country        => 'US',
);

$tx->submit;

ok $tx->is_success;

done_testing;
