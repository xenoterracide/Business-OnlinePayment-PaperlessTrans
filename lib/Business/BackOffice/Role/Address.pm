package Business::BackOffice::Role::Address;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;

has address => (
	isa         => 'Business::BackOffice::RequestPart::Address',
	is          => 'ro',
	remote_name => 'Address',
);

1;
# ABSTRACT: State
