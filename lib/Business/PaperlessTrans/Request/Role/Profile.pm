package Business::PaperlessTrans::Request::Role::Profile;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;

has profile_number => (
	remote_name => 'ProfileNumber',
	isa         => 'Str',
	is          => 'ro',
);

1;
# ABSTRACT: Test Mode
