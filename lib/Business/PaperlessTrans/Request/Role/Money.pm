package Business::PaperlessTrans::Request::Role::Money;
use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '0.001002'; # VERSION

use Moose::Role;
use MooseX::RemoteHelper;

has amount => (
	remote_name => 'Amount',
	isa         => 'Num',
	is          => 'ro',
	required    => 1,
);

has currency => (
	remote_name => 'Currency',
	isa         => 'Str',
	is          => 'ro',
	required    => 1,
);

1;
# ABSTRACT: Money Attributes

__END__

=pod

=head1 NAME

Business::PaperlessTrans::Request::Role::Money - Money Attributes

=head1 VERSION

version 0.001002

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
