package Business::BackOffice::Response::TestConnection;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
extends 'Business::BackOffice::Response';

has is_success => (
	remote_name => 'IsSuccess',
	isa         => 'Bool',
	is          => 'ro',
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Test Connection Response
