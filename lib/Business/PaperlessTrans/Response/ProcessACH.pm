package Business::PaperlessTrans::Response::ProcessACH;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
extends 'Business::PaperlessTrans::Response';

with qw(
	Business::PaperlessTrans::Response::Role::Authorization
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Process ACH Response
