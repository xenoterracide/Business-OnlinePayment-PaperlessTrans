package Business::PaperlessTrans::RequestPart::Check;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;

extends 'Business::PaperlessTrans::MessagePart';
with qw(
	MooseX::RemoteHelper::CompositeSerialization
	Business::PaperlessTrans::Role::NameOnAccount
	Business::PaperlessTrans::Role::Address
	Business::PaperlessTrans::Role::Identification
	Business::PaperlessTrans::Role::EmailAddress
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
	isa         => 'Business::PaperlessTrans::RequestPart::Phone',
	is          => 'ro',
);

has phone_2 => (
	remote_name => 'Phone_2',
	isa         => 'Business::PaperlessTrans::RequestPart::Phone',
	is          => 'ro',
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Check
