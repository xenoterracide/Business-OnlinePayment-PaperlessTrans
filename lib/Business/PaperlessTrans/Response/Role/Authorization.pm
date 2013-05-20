package Business::PaperlessTrans::Response::Role::Authorization;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;
use MooseX::Types::Common::String qw( NonEmptySimpleStr );

has authorization => (
	remote_name => 'Authorization',
	isa         => NonEmptySimpleStr,
	is          => 'ro',
);

1;
# ABSTRACT: Authorized Card Response
