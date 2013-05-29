package Business::PaperlessTrans::RequestPart::CustomFields;
use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '0.001003'; # VERSION

use Moose;
extends 'Business::PaperlessTrans::MessagePart';
with 'MooseX::RemoteHelper::CompositeSerialization';

foreach my $i ( 1..30 ) {
	has "field_$i" => (
		remote_name => "Field_$i",
		isa         => 'Str',
		is          => 'ro',
	);
}

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: CustomFields

__END__

=pod

=head1 NAME

Business::PaperlessTrans::RequestPart::CustomFields - CustomFields

=head1 VERSION

version 0.001003

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
