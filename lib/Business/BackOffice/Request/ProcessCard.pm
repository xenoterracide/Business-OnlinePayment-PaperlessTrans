package Business::BackOffice::Request::ProcessCard;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
use MooseX::Types::Common::String qw( NumericCode );

extends 'Business::BackOffice::Request';

with qw(
	Business::BackOffice::Request::Role::Authorization
);

sub _build_type {
	return 'ProcessCard';
}

has profile_number => (
	remote_name => 'ProfileNumber',
	isa         => NumericCode,
	is          => 'ro',
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: AuthorizeCard Request
