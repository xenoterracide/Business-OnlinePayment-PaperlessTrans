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
use MooseX::RemoteHelper::Types qw( Bool );

has is_accepted => (
	remote_name => 'IsAccepted',
	isa         => Bool,
	is          => 'ro',
	coerce      => 1,
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Process ACH Response
