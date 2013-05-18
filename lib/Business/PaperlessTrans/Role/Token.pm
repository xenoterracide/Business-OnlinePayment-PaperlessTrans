package Business::PaperlessTrans::Role::Token;
use strict;
use  warnings;
use namespace::autoclean;

our $VERSION = '0.001000'; # VERSION

use Moose::Role;
use MooseX::RemoteHelper;

has token => (
	remote_name => 'Token',
	isa         => 'Business::PaperlessTrans::RequestPart::AuthenticationToken',
	is          => 'rw',
	required    => 1,
);

1;
# ABSTRACT: Provides AuthenticationToken Attribute

__END__

=pod

=head1 NAME

Business::PaperlessTrans::Role::Token - Provides AuthenticationToken Attribute

=head1 VERSION

version 0.001000

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
