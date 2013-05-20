package Business::PaperlessTrans::RequestPart::CustomFields;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
extends 'Business::PaperlessTrans::MessagePart';
with 'MooseX::RemoteHelper::CompositeSerialization';

use MooseX::Types::Common::String qw( NonEmptySimpleStr );

foreach my $i ( 1..30 ) {
	has "field_$i" => (
		remote_name => "Field_$i",
		isa         => NonEmptySimpleStr,
		is          => 'ro',
	);
}

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: CustomFields
