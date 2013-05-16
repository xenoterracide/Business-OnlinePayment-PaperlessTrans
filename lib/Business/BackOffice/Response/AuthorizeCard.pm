package Business::BackOffice::Response::AuthorizeCard;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
extends 'Business::BackOffice::Response';

use MooseX::Types::Common::String qw( NonEmptySimpleStr );

has is_approved => (
	remote_name => 'IsApproved',
	isa         => NonEmptySimpleStr,
	is          => 'ro',
);

has authorization => (
	remote_name => 'Authorization',
	isa         => NonEmptySimpleStr,
	is          => 'ro',
);
	
__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Authorized Card Response
