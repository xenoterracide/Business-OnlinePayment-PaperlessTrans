package Business::BackOffice::Request::AuthorizeCard;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
extends 'Business::BackOffice::Request';

with qw(
	Business::BackOffice::Request::Role::Authorization
);

sub _build_type {
	return 'AuthorizeCard';
}

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: AuthorizeCard Request
