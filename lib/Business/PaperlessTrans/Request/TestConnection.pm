package Business::PaperlessTrans::Request::TestConnection;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;

extends 'Business::PaperlessTrans::MessagePart';

with qw(
	MooseX::RemoteHelper::CompositeSerialization
);

sub _build_type {
	return 'TestConnection';
}

has type => (
	isa     => 'Str',
	is      => 'ro',
	lazy    => 1,
	builder => '_build_type',
);

has token => (
	remote_name => 'token',
	isa         => 'Business::PaperlessTrans::RequestPart::AuthenticationToken',
	is          => 'rw',
	required    => 1,
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Test Connection

=head1 DESCRIPTION

The Test Connection Request has a different API from other requests and
therefore does not inherit from Request, but conforms to the same external
interfaces.
