package Business::PaperlessTrans::Role::NameOnAccount;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;

has name_on_account => (
	remote_name => 'NameOnAccount',
	isa         => 'Str',
	is          => 'ro',
	required    => 1,
);

1;
# ABSTRACT: name associated with the account
