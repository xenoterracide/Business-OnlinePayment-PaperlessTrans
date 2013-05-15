package Business::BackOffice::Role::Token;
use strict;
use  warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;

has token => (
	isa      => 'Business::BackOffice::RequestPart::AuthenticationToken',
	is       => 'rw',
	required => 1,
);

1;
# ABSTRACT: Provides AuthenticationToken Attribute
