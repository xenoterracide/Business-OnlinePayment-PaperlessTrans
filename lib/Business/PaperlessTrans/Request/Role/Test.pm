package Business::PaperlessTrans::Request::Role::Test;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;

has test => (
	remote_name => 'TestMode',
	isa         => 'Bool',
	is          => 'ro',
	lazy        => 1,
	default     => 1,
	serializer  => sub {
		my ( $attr, $instance ) = @_;

		return $attr->get_value( $instance ) ? 'True' : 'False';
	},
);

1;
# ABSTRACT: Test Mode
