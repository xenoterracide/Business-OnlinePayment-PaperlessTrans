package Business::BackOffice::RequestPart::Address;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
use MooseX::RemoteHelper;

with qw( MooseX::RemoteHelper::CompositeSerialization );

use MooseX::Types::Common::String qw( NonEmptySimpleStr );

has street => (
	isa         => NonEmptySimpleStr,
	is          => 'ro',
	remote_name => 'Street',
);

has city => (
	isa         => NonEmptySimpleStr,
	is          => 'ro',
	remote_name => 'City',
);

has state => (
	isa         => NonEmptySimpleStr,
	is          => 'ro',
	remote_name => 'State',
);

has country => (
	isa         => NonEmptySimpleStr,
	is          => 'ro',
	remote_name => 'Country',
);

has zip => (
	isa         => NonEmptySimpleStr,
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
