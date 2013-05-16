package Business::BackOffice::Request::TestConnection;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
use MooseX::RemoteHelper;

with qw(
	MooseX::RemoteHelper::CompositeSerialization
);

sub _build_type {
	return 'TestConnection';
}

has token => (
	remote_name => 'token',
	isa         => 'Business::BackOffice::RequestPart::AuthenticationToken',
	is          => 'rw',
	required    => 1,
);

has type => (
	isa     => 'Str',
	is      => 'ro',
	lazy    => 1,
	builder => '_build_type',
);

__PACKAGE__->meta->make_immutable;
