package Business::PaperlessTrans::Request::Role::Profile;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;
use MooseX::Types::Common::String qw( NumericCode );

has profile_number => (
	remote_name => 'ProfileNumber',
	isa         => NumericCode,
	is          => 'ro',
);

1;
# ABSTRACT: Test Mode
