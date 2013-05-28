package Business::PaperlessTrans::Request::Role::Money;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;

has amount => (
	remote_name => 'Amount',
	isa         => 'Num',
	is          => 'ro',
	required    => 1,
);

has currency => (
	remote_name => 'Currency',
	isa         => 'Str',
	is          => 'ro',
	required    => 1,
);

1;
# ABSTRACT: Money Attributes
