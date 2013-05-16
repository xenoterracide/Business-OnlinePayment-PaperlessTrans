package Business::BackOffice::RequestPart::AuthenticationToken;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;

extends 'Business::BackOffice::MessagePart';
with qw( MooseX::RemoteHelper::CompositeSerialization );

use MooseX::Types::Common::String qw( NumericCode );
use MooseX::Types::UUID qw( UUID );

has terminal_id => (
	isa         => UUID,
	is          => 'ro',
	remote_name => 'TerminalID',
);

has terminal_key => (
	isa         => NumericCode,
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
