package Business::PaperlessTrans::Response::AuthorizeCard;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
extends 'Business::PaperlessTrans::Response';

with qw(
	Business::PaperlessTrans::Response::Role::Authorization
	Business::PaperlessTrans::Response::Role::IsApproved
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Authorized Card Response
