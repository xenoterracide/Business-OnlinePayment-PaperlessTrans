package Business::PaperlessTrans::RequestPart::AuthenticationToken;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;

extends 'Business::PaperlessTrans::MessagePart';
with qw( MooseX::RemoteHelper::CompositeSerialization );

has terminal_id => (
	isa         => 'Str',
	is          => 'ro',
	remote_name => 'TerminalID',
);

has terminal_key => (
	isa         => 'Num',
	is          => 'ro',
	remote_name => 'TerminalKey',
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Authentication Token

=attr terminal_id

Unique identifier for terminal ( assigned by Paperless Transaction
Corporation )

=attr terminal_key

Unique identifier for terminal ( assigned by Paperless Transaction
Corporation )
