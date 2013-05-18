package Business::PaperlessTrans::Request::TestConnection;
use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '0.001000'; # VERSION

use Moose;

extends 'Business::PaperlessTrans::Request';

sub _build_type {
	return 'TestConnection';
}

has token => (
	remote_name => 'token',
	isa         => 'Business::PaperlessTrans::RequestPart::AuthenticationToken',
	is          => 'rw',
	required    => 1,
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Test Connection

__END__

=pod

=head1 NAME

Business::PaperlessTrans::Request::TestConnection - Test Connection

=head1 VERSION

version 0.001000

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
