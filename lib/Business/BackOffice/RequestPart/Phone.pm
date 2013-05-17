package Business::BackOffice::RequestPart::Phone;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;

extends 'Business::BackOffice::MessagePart';

use MooseX::Types::Common::String qw( NonEmptySimpleStr );

has number => (
	remote_name => 'Number',
	isa         => NonEmptySimpleStr,
	is          => 'ro',
);

has type => (
	remote_name => 'Type',
	isa         => NonEmptySimpleStr,
	is          => 'ro',
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Phone
