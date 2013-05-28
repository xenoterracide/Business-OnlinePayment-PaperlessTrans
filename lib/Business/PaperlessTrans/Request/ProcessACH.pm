package Business::PaperlessTrans::Request::ProcessACH;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;

extends 'Business::PaperlessTrans::Request';

with qw(
	Business::PaperlessTrans::Request::Role::Profile
	Business::PaperlessTrans::Request::Role::Money
);

sub _build_type {
	return 'ProcessACH';
}

has check => (
	remote_name => 'Check',
	isa         => 'Business::PaperlessTrans::RequestPart::Check',
	is          => 'ro',
);

has check_number => (
	remote_name => 'CheckNumber',
	isa         => 'Str',
	is          => 'ro',
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: AuthorizeCard Request
