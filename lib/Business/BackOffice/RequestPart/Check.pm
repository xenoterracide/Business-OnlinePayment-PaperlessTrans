package Business::BackOffice::RequestPart::Check;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;

extends 'Business::BackOffice::MessagePart';
with qw(
	MooseX::RemoteHelper::CompositeSerialization
	Business::BackOffice::Role::NameOnAccount
	Business::BackOffice::Role::Address
	Business::BackOffice::Role::Identification
	Business::BackOffice::Role::EmailAddress
);

use MooseX::Types::Common::String qw( NumericCode );

has routing_number => (
	remote_name => 'RoutingNumber',
	isa         => NumericCode,
	is          => 'ro',
	required    => 1,
);

has account_number => (
	remote_name => 'AccountNumber',
	isa         => NumericCode,
	is          => 'ro',
	required    => 1,
);

has phone_1 => (
	remote_name => 'Phone_1',
	isa         => 'Business::BackOffice::RequestPart::Phone',
	is          => 'ro',
);

has phone_2 => (
	remote_name => 'Phone_2',
	isa         => 'Business::BackOffice::RequestPart::Phone',
	is          => 'ro',
);
	

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Check
