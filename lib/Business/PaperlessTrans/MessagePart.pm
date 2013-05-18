package Business::PaperlessTrans::MessagePart;
use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '0.001000'; # VERSION

use Moose;
use MooseX::RemoteHelper;
use MooseX::UndefTolerant;

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: A base class for messages

__END__

=pod

=head1 NAME

Business::PaperlessTrans::MessagePart - A base class for messages

=head1 VERSION

version 0.001000

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
