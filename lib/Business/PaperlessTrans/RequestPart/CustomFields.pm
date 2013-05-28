package Business::PaperlessTrans::RequestPart::CustomFields;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
extends 'Business::PaperlessTrans::MessagePart';
with 'MooseX::RemoteHelper::CompositeSerialization';

foreach my $i ( 1..30 ) {
	has "field_$i" => (
		remote_name => "Field_$i",
		isa         => 'Str',
		is          => 'ro',
	);
}

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: CustomFields
