package Business::BackOffice::Role::State;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;
use MooseX::Types::Common::String qw( NonEmptySimpleStr );

has state => (
	isa         => NonEmptySimpleStr,
	is          => 'ro',
	remote_name => 'State',
);

1;
# ABSTRACT: State
