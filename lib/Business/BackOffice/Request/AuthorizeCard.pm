package Business::BackOffice::Request::AuthorizeCard;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;

extends 'Business::BackOffice::Request';

with qw(
	Business::BackOffice::Role::Token
);

use MooseX::Types::Common::Numeric  qw( PositiveOrZeroNum );
use MooseX::Types::Locale::Currency qw( CurrencyCode      );

sub _build_type {
	return 'AuthorizeCard';
}

has test => (
	remote_name => 'TestMode',
	isa         => 'Bool',
	is          => 'ro',
	lazy        => 1,
	default     => 1,
	serializer  => sub {
		my ( $attr, $instance ) = @_;

		return $attr->get_value( $instance ) ? 'True' : 'False';
	},
);

has amount => (
	remote_name => 'Amount',
	isa         => PositiveOrZeroNum,
	is          => 'ro',
	required    => 1,
);

has currency => (
	remote_name => 'Currency',
	isa         => CurrencyCode,
	is          => 'ro',
	required    => 1,
);

has card_present => (
	remote_name => 'CardPresent',
	isa         => 'Bool',
	is          => 'ro',
);

has card => (
	remote_name => 'Card',
	isa         => 'Business::BackOffice::RequestPart::Card',
	is          => 'ro',
	required    => 1,
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: AuthorizeCard Request
