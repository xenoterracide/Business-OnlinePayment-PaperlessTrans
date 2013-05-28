package Business::PaperlessTrans::RequestPart::AuthenticationToken;
use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '0.001002'; # VERSION

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

__END__

=pod

=head1 NAME

Business::PaperlessTrans::RequestPart::AuthenticationToken - Authentication Token

=head1 VERSION

version 0.001002

=head1 ATTRIBUTES

=head2 terminal_id

Unique identifier for terminal ( assigned by Paperless Transaction
Corporation )

=head2 terminal_key

Unique identifier for terminal ( assigned by Paperless Transaction
Corporation )

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
