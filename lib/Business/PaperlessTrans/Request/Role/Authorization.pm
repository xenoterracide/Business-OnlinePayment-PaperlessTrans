package Business::PaperlessTrans::Request::Role::Authorization;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;

with qw(
	Business::PaperlessTrans::Request::Role::Token
	Business::PaperlessTrans::Request::Role::Test
	Business::PaperlessTrans::Request::Role::Money
);

has card_present => (
	remote_name => 'CardPresent',
	isa         => 'Bool',
	is          => 'ro',
);

has card => (
	remote_name => 'Card',
	isa         => 'Business::PaperlessTrans::RequestPart::Card',
	is          => 'ro',
	required    => 1,
);

1;
# ABSTRACT: Request does Authorization
