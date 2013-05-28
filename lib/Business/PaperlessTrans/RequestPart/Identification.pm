package Business::PaperlessTrans::RequestPart::Identification;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;

extends 'Business::PaperlessTrans::MessagePart';
with qw(
	MooseX::RemoteHelper::CompositeSerialization
	Business::PaperlessTrans::Role::State
	Business::PaperlessTrans::Role::Address
);

my $dt_fmt
	= sub {
		my ( $attr, $instance ) = @_;
		return $attr->get_value( $instance )->format_cldr('MM/dd/YYYY');
	};

has id_type => (
	isa         => 'Int',
	is          => 'ro',
	required    => 1,
	remote_name => 'IDType',
);

has number => (
	isa         => 'Str',
	is          => 'ro',
	remote_name => 'Number',
	required    => 1,
);

has expiration => (
	isa         => 'DateTime',
	is          => 'ro',
	remote_name => 'Expiration',
	serializer  => $dt_fmt,
);

has date_of_birth => (
	isa         => 'DateTime',
	is          => 'ro',
	remote_name => 'DOB',
	serializer  => $dt_fmt,
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Identification
