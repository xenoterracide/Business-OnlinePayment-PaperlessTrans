package Business::PaperlessTrans::Role::Token;
use strict;
use  warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;

has token => (
	remote_name => 'Token',
	isa         => 'Business::PaperlessTrans::RequestPart::AuthenticationToken',
	is          => 'rw',
	required    => 1,
);

1;
# ABSTRACT: Provides AuthenticationToken Attribute
