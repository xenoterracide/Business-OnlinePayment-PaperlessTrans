package Business::PaperlessTrans::Role::State;
use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '0.001003'; # VERSION

use Moose::Role;
use MooseX::RemoteHelper;

has state => (
	isa         => 'Str',
	is          => 'ro',
	remote_name => 'State',
);

1;
# ABSTRACT: State

__END__

=pod

=head1 NAME

Business::PaperlessTrans::Role::State - State

=head1 VERSION

version 0.001003

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
