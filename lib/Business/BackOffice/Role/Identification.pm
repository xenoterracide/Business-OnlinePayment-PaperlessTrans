package Business::BackOffice::Role::Identification;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;

has identification => (
	remote_name => 'Identification',
	isa         => 'Business::BackOffice::RequestPart::Identification',
	is          => 'ro',
);

1;
# ABSTRACT: Identification
