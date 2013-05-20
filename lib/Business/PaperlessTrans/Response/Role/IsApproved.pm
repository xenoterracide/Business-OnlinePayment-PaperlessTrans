package Business::PaperlessTrans::Response::Role::IsApproved;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;
use MooseX::RemoteHelper::Types qw( Bool );

has is_approved => (
	remote_name => 'IsApproved',
	isa         => Bool,
	is          => 'ro',
	coerce      => 1,
);

1;
# ABSTRACT: Cards are approved
