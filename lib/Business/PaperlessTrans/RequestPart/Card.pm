package Business::PaperlessTrans::RequestPart::Card;
use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '0.001002'; # VERSION

use Moose;

extends 'Business::PaperlessTrans::MessagePart';
with qw(
	MooseX::RemoteHelper::CompositeSerialization
	Business::PaperlessTrans::Role::Address
	Business::PaperlessTrans::Role::NameOnAccount
	Business::PaperlessTrans::Role::Identification
	Business::PaperlessTrans::Role::EmailAddress
);

has number => (
	isa         => 'Str',
	is          => 'ro',
	required    => 1,
	remote_name => 'CardNumber',
);

has security_code => (
    isa         => 'Str',
    remote_name => 'SecurityCode',
    predicate   => 'has_security_code',
    is          => 'ro',
);

has track_data => (
	isa         => 'Str',
	is          => 'ro',
	remote_name => 'TrackData',
);

has expiration_month => (
	isa         => 'Int',
	remote_name => 'ExpirationMonth',
	is          => 'ro',
	required    => 1,
);

has expiration_year => (
	remote_name => 'ExpirationYear',
	isa         => 'Int',
	is          => 'ro',
	required    => 1,
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Card

__END__

=pod

=head1 NAME

Business::PaperlessTrans::RequestPart::Card - Card

=head1 VERSION

version 0.001002

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
