package Business::PaperlessTrans::RequestPart::Phone;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;

extends 'Business::PaperlessTrans::MessagePart';

has number => (
	remote_name => 'Number',
	isa         => 'Str',
	is          => 'ro',
);

has type => (
	remote_name => 'Type',
	isa         => 'Str',
	is          => 'ro',
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Phone
