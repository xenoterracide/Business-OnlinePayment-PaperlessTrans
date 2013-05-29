package Business::PaperlessTrans::Client;
use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '0.001003'; # VERSION

use Moose;
use Class::Load 0.20 'load_class';
use Module::Load 'load';
use Carp;

use File::Spec;

use XML::Compile::WSDL11;
use XML::Compile::SOAP11;
use XML::Compile::Transport::SOAPHTTP;

sub submit {
	my ( $self, $request ) = @_;

	my %request;
	if ( $request->type eq 'TestConnection' ) {
		%request = ( %{ $request->serialize });
	}
	else {
		%request = ( req => $request->serialize );
	}

	if ($self->debug >= 1 ) {
		load 'Data::Dumper', 'Dumper';
		carp Dumper( \%request );
	}

	my ( $answer, $trace ) = $self->_get_call( $request->type )->( %request );

	carp "REQUEST >\n"  . $trace->request->as_string  if $self->debug > 1;
	carp "RESPONSE <\n" . $trace->response->as_string if $self->debug > 1;

	if ( $self->debug >= 1 ) {
		carp Dumper( $answer );
	}

	my $res = $answer->{parameters}{$request->type . 'Result'};

	my $res_c = 'Business::PaperlessTrans::Response::' . $request->type;

	return load_class( $res_c )->new( $res );
}

sub _build_calls {
	my $self = shift;

	my @calls = qw( TestConnection AuthorizeCard ProcessCard ProcessACH );

	my %calls;
	foreach my $call ( @calls ) {
		$calls{$call} = $self->_wsdl->compileClient( $call );
	}
	return \%calls;
}

sub _build_wsdl {
	my $self = shift;

	my $wsdl
		= XML::Compile::WSDL11->new(
			$self->_wsdl_file,
		);

	foreach my $xsd ( $self->_list_xsd_files ) {
		$wsdl->importDefinitions( $xsd );
	}

	return $wsdl;
}

my $dist = 'Business-OnlinePayment-PaperlessTrans';

sub _dist_dir_new {
## no critic
	my $dist = shift;

	## dev environment
	my $dev = File::Spec->catdir('share');
	return $dev if -d $dev;

	# Create the subpath
	my $path = File::Spec->catdir(
		'auto', 'share', 'dist', $dist,
	);

	# Find the full dir withing @INC
	foreach my $inc ( @INC ) {
		next unless defined $inc and ! ref $inc;
		my $dir = File::Spec->catdir( $inc, $path );
		next unless -d $dir;
		unless ( -r $dir ) {
			Carp::croak("Found directory '$dir', but no read permissions");
		}
		return $dir;
	}

	return undef;
}

sub _dist_dir_old { ## no critic
## no critic
	my $dist = shift;

	# Create the subpath
	my $path = File::Spec->catdir(
		'auto', split( /-/, $dist ),
	);

	# Find the full dir within @INC
	foreach my $inc ( @INC ) {
		next unless defined $inc and ! ref $inc;
		my $dir = File::Spec->catdir( $inc, $path );
		next unless -d $dir;
		unless ( -r $dir ) {
			Carp::croak("Found directory '$dir', but no read permissions");
		}
		return $dir;
	}

	return undef;
}

sub _build_wsdl_file {
	my $dir = _dist_dir_new( $dist );
	$dir  ||= _dist_dir_old( $dist );

	my $path = File::Spec->catfile( $dir, 'svc.paperlesstrans.wsdl' );

	return $path;
}

sub _build_xsd_files {
	my $dir = _dist_dir_new( $dist );
	$dir  ||= _dist_dir_old( $dist );

	my @xsd;
	foreach ( 0..6 ) {
		my $file = File::Spec->catfile( $dir, "svc.paperlesstrans.$_.xsd" );

		push @xsd, $file;
	}
	return \@xsd;
}

has debug => (
	isa      => 'Int',
	is       => 'ro',
	lazy     => 1,
	default  => 0,
);

has _calls => (
	isa     => 'HashRef',
	traits  => ['Hash'],
	is      => 'rw',
	lazy    => 1,
	builder => '_build_calls',
	handles => {
		_get_call => 'get',
	},
);

has _wsdl => (
	isa     => 'XML::Compile::WSDL11',
	is      => 'ro',
	lazy    => 1,
	builder => '_build_wsdl'
);

has _wsdl_file => (
	isa     => 'Str',
	lazy    => 1,
	is      => 'ro',
	builder => '_build_wsdl_file',
);

has _xsd_files => (
	isa     => 'ArrayRef[Str]',
	traits  => ['Array'],
	lazy    => 1,
	is      => 'ro',
	builder => '_build_xsd_files',
	handles => {
		_list_xsd_files => 'elements',
	},
);

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: PaperlessTrans Client object

__END__

=pod

=head1 NAME

Business::PaperlessTrans::Client - PaperlessTrans Client object

=head1 VERSION

version 0.001003

=head1 DESCRIPTION

PaperlessTrans is a secure and seamless bridge between your IT infrastructure and
the Paperless Transactions cloud. This service enables your organization to
connect directly and securely for processing credit card and ACH transactions.

=head1 METHODS

=head2 submit

	my $response = $client->submit( $request );

=head1 ACKNOWLEDGMENTS

This code contains pieces of L<File::ShareDir> that were directly copied and
pasted. Thanks ot Adam Kennedy for creating it.

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
