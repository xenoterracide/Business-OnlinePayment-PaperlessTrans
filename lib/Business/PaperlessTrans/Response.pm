package Business::PaperlessTrans::Response;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
extends 'Business::PaperlessTrans::MessagePart';

use Moose::Util::TypeConstraints  qw( enum      );

has transaction_id => (
	remote_name => 'TransactionID',
	isa         => 'Str',
	is          => 'ro',
);

has code => (
	remote_name => 'ResponseCode',
	isa         => 'Int',
	is          => 'ro',
);

has message => (
	remote_name => 'Message',
	isa         => 'Str',
	is          => 'ro',
);

has timestamp => (
	remote_name => 'DateTimeStamp',
	isa         => 'Str',
	is          => 'ro',
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Base Response
