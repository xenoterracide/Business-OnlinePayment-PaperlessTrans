package Business::BackOffice::Role::EmailAddress;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;
use MooseX::Types::Email          qw( EmailAddress      );

has email_address => (
	remote_name => 'EmailAddress',
	isa         => EmailAddress,
	is          => 'ro',
);

1;
# ABSTRACT: Email address used with Custom Mailers
