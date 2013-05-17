package Business::BackOffice::Response::ProcessCard;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
extends 'Business::BackOffice::Response';

with qw(
	Business::BackOffice::Response::Role::Authorization
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Process Card Response
