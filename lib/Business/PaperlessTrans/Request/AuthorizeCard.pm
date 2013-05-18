package Business::PaperlessTrans::Request::AuthorizeCard;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
extends 'Business::PaperlessTrans::Request';

with qw(
	Business::PaperlessTrans::Request::Role::Authorization
);

sub _build_type {
	return 'AuthorizeCard';
}

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: AuthorizeCard Request
