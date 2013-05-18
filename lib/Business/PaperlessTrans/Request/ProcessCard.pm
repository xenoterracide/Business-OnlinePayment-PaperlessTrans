package Business::PaperlessTrans::Request::ProcessCard;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;

extends 'Business::PaperlessTrans::Request';

with qw(
	Business::PaperlessTrans::Request::Role::Authorization
	Business::PaperlessTrans::Request::Role::Profile
);

sub _build_type {
	return 'ProcessCard';
}

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: AuthorizeCard Request
