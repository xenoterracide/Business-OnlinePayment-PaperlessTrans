package Business::PaperlessTrans::Request;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
extends 'Business::PaperlessTrans::MessagePart';

with qw(
	MooseX::RemoteHelper::CompositeSerialization
);

has type => (
	isa     => 'Str',
	is      => 'ro',
	lazy    => 1,
	builder => '_build_type',
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: AuthorizeCard Request
