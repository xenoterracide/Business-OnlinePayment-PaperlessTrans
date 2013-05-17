package Business::BackOffice::Response;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
extends 'Business::BackOffice::MessagePart';

use MooseX::Types::Common::String qw( SimpleStr NonEmptySimpleStr );
use Moose::Util::TypeConstraints  qw( enum                        );
use MooseX::Types::UUID           qw( UUID                        );

has transaction_id => (
	remote_name => 'TransactionID',
	isa         => UUID|SimpleStr,
	is          => 'ro',
);

has code => (
	remote_name => 'ResponseCode',
	isa         => enum( [qw( 0 1 2 )] ),
	is          => 'ro',
);

has message => (
	remote_name => 'Message',
	isa         => SimpleStr,
	is          => 'ro',
);

has timestamp => (
	remote_name => 'DateTimeStamp',
	isa         => SimpleStr,
	is          => 'ro',
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Base Response
