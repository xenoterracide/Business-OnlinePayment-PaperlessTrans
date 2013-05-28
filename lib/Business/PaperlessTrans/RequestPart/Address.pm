package Business::PaperlessTrans::RequestPart::Address;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;

extends 'Business::PaperlessTrans::MessagePart';

with qw(
	MooseX::RemoteHelper::CompositeSerialization
	Business::PaperlessTrans::Role::State
);

has street => (
	isa         => 'Str',
	is          => 'ro',
	remote_name => 'Street',
);

has city => (
	isa         => 'Str',
	is          => 'ro',
	remote_name => 'City',
);

has country => (
	isa         => 'Str',
	is          => 'ro',
	remote_name => 'Country',
);

has zip => (
	isa         => 'Str',
	is          => 'ro',
	remote_name => 'Zip',
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Address

=attr street

=attr city

=attr state

=attr zip

=attr country
