package Business::PaperlessTrans::Role::EmailAddress;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;

has email_address => (
	remote_name => 'EmailAddress',
	isa         => 'Str',
	is          => 'ro',
);

1;
# ABSTRACT: Email address used with Custom Mailers
