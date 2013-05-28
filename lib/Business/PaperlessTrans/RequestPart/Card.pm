package Business::PaperlessTrans::RequestPart::Card;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;

extends 'Business::PaperlessTrans::MessagePart';
with qw(
	MooseX::RemoteHelper::CompositeSerialization
	Business::PaperlessTrans::Role::Address
	Business::PaperlessTrans::Role::NameOnAccount
	Business::PaperlessTrans::Role::Identification
	Business::PaperlessTrans::Role::EmailAddress
);

has number => (
	isa         => 'Str',
	is          => 'ro',
	required    => 1,
	remote_name => 'CardNumber',
);

has security_code => (
    isa         => 'Str',
    remote_name => 'SecurityCode',
    predicate   => 'has_security_code',
    is          => 'ro',
);

has track_data => (
	isa         => 'Str',
	is          => 'ro',
	remote_name => 'TrackData',
);

has expiration_month => (
	isa         => 'Int',
	remote_name => 'ExpirationMonth',
	is          => 'ro',
	required    => 1,
);

has expiration_year => (
	remote_name => 'ExpirationYear',
	isa         => 'Int',
	is          => 'ro',
	required    => 1,
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Card
