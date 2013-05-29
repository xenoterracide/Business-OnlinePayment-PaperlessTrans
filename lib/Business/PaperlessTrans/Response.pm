package Business::PaperlessTrans::Response;
use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '0.001003'; # VERSION

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

__END__

=pod

=head1 NAME

Business::PaperlessTrans::Response - Base Response

=head1 VERSION

version 0.001003

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
