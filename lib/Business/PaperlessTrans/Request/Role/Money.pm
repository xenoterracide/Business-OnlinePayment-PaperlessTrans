package Business::PaperlessTrans::Request::Role::Money;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;
use MooseX::Types::Common::Numeric  qw( PositiveOrZeroNum );
use MooseX::Types::Locale::Currency qw( CurrencyCode      );

has amount => (
	remote_name => 'Amount',
	isa         => PositiveOrZeroNum,
	is          => 'ro',
	required    => 1,
);

has currency => (
	remote_name => 'Currency',
	isa         => CurrencyCode,
	is          => 'ro',
	required    => 1,
);

1;
# ABSTRACT: Money Attributes
