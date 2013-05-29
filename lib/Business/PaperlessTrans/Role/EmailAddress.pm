package Business::PaperlessTrans::Role::EmailAddress;
use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '0.001003'; # VERSION

use Moose::Role;
use MooseX::RemoteHelper;

has email_address => (
	remote_name => 'EmailAddress',
	isa         => 'Str',
	is          => 'ro',
);

1;
# ABSTRACT: Email address used with Custom Mailers

__END__

=pod

=head1 NAME

Business::PaperlessTrans::Role::EmailAddress - Email address used with Custom Mailers

=head1 VERSION

version 0.001003

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
