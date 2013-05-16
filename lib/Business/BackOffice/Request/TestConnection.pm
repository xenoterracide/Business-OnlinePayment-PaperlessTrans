package Business::BackOffice::Request::TestConnection;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;

extends 'Business::BackOffice::Request';

sub _build_type {
	return 'TestConnection';
}

has token => (
	remote_name => 'token',
	isa         => 'Business::BackOffice::RequestPart::AuthenticationToken',
	is          => 'rw',
	required    => 1,
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Test Connection
