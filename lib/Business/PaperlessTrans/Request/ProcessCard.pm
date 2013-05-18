package Business::PaperlessTrans::Request::ProcessCard;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
use MooseX::Types::Common::String qw( NumericCode );

extends 'Business::PaperlessTrans::Request';

with qw(
	Business::PaperlessTrans::Request::Role::Authorization
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
