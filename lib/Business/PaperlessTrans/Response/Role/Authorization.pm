package Business::PaperlessTrans::Response::Role::Authorization;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;

has authorization => (
	remote_name => 'Authorization',
	isa         => 'Str',
	is          => 'ro',
);

1;
# ABSTRACT: Authorized Card Response
