package Business::PaperlessTrans::Role::State;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;

has state => (
	isa         => 'Str',
	is          => 'ro',
	remote_name => 'State',
);

1;
# ABSTRACT: State
