package Business::BackOffice::Role::NameOnAccount;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;
use MooseX::Types::Common::String qw( NonEmptySimpleStr );

has name_on_account => (
	remote_name => 'NameOnAccount',
	isa         => NonEmptySimpleStr,
	is          => 'ro',
	required    => 1,
);

1;
# ABSTRACT: name associated with the account
