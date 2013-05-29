package Business::OnlinePayment::PaperlessTrans;
use 5.008;
use strict;
use warnings;

our $VERSION = '0.001003'; # VERSION

use parent 'Business::OnlinePayment';
use Class::Load 0.20 'load_class';
use Carp;

my $ns     = 'Business::PaperlessTrans::';

sub submit { ## no critic ( ProhibitExcessComplexity )
	my ( $self ) = @_;

	my %content = $self->content;
	my $action  = lc $content{action};
	my $trans_t = lc $self->transaction_type;
	my $debug   = $content{debug} ? $content{debug} : 0;
	my $token   = $self->_content_to_token( %content );
	my $ident   = $self->_content_to_ident( %content );
	my $address = $self->_content_to_address( %content );

	my %args = (
		amount       => $content{amount},
		currency     => $content{currency},
		token        => $token,
		test         => $self->test_transaction ? 1 : 0,
	);

	my %payment_content = (
		%content,
		identification => $ident,
		address        => $address,
	);

	if ( $trans_t eq 'cc' ) {
		$args{card_present} = $content{track1} ? 1 : 0;
	    $args{card} = $self->_content_to_card( %payment_content );
	}
	elsif ( $trans_t eq 'echeck' ) {
		$args{check_number} = $content{check_number};
		$args{check} = $self->_content_to_check( %payment_content );
	}

	## determine appropriate request class
	my $request_class;
	if ( $action eq 'authorization only' && $trans_t eq 'cc' ){
		$request_class = 'AuthorizeCard';
	}
	elsif ( $action eq 'normal authorization' && $trans_t eq 'cc' ) {
		$request_class = 'ProcessCard';
	}
	elsif ( $action eq 'normal authorization' && $trans_t eq 'echeck' ) {
		$request_class = 'ProcessACH';
	}


	my $request
		= load_class( $ns . 'Request::' . $request_class )
		->new( \%args )
		;

	$self->{_client}
		||= load_class( $ns . 'Client')
		->new({ debug => $debug })
		;

	my $response = $self->{_client}->submit( $request );

	# code != 0 is a transmission error
	if ( $response->code == 0 ) {
		# in future should consider making thse the same api?
		if (   ( $response->can('is_approved') && $response->is_approved )
			|| ( $response->can('is_accepted') && $response->is_accepted )
			) {
			$self->is_success(1);
		}
		else {
			$self->is_success(0);
			$self->error_message( $response->message );
		}
	}
	else {
		confess $response->message;
	}

	$self->authorization( $response->authorization )
		if $response->can('authorization');

	$self->order_number( $response->transaction_id )
		if $response->can('transaction_id');

	return;
}

sub _content_to_ident {
	my ( $self, %content ) = @_;

	return unless $content{license_num};

	my %mapped = (
		id_type       => 1, # B:OP 3.02 there is only drivers license
		number        => $content{license_num},
	);

	return load_class( $ns . 'RequestPart::Identification')->new( \%mapped );
}

sub _content_to_token {
	my ( $self, %content ) = @_;

	my %mapped = (
		terminal_id  => $content{login},
		terminal_key => $content{password},
	);

	return load_class( $ns . 'RequestPart::AuthenticationToken')
		->new( \%mapped )
		;
}

sub _content_to_address {
	my ( $self, %content ) = @_;

	my %mapped = (
		street  => $content{address},
		city    => $content{city},
		state   => $content{state},
		zip     => $content{zip},
		country => $content{country},
	);

	return load_class( $ns . 'RequestPart::Address')
		->new( \%mapped )
		;
}

sub _content_to_check {
	my ( $self, %content ) = @_;

	my %mapped = (
		name_on_account => $content{account_name},
		account_number  => $content{account_number},
		routing_number  => $content{routing_code},
		identification  => $content{identification},
		address         => $content{address},
		email_address   => $content{email},
	);

	return load_class( $ns . 'RequestPart::Check')
		->new( \%mapped )
		;
}

sub _content_to_card {
	my ( $self, %content ) = @_;

	# expiration api is bad but conforms to Business::OnlinePayment 3.02 Spec

	$content{expiration} =~ m/^(\d\d)(\d\d)$/xms;
	my ( $exp_month, $exp_year ) = ( $1, $2 ); ## no critic ( ProhibitCaptureWithoutTest )

	my %mapped = (
		name_on_account  => $content{name},
		number           => $content{card_number},
		security_code    => $content{cvv2},
		identification   => $content{identification},
		address          => $content{address},
		email_address    => $content{email},
		expiration_month => $exp_month,
		expiration_year  => '20' . $exp_year,
	);

	$mapped{track_data} = $content{track1} . $content{track2}
		if $content{track1} && $content{track2};

	return load_class( $ns . 'RequestPart::Card')->new( \%mapped );
}

1;

# ABSTRACT: Interface to Paperless Transaction Corporation BackOffice API

__END__

=pod

=head1 NAME

Business::OnlinePayment::PaperlessTrans - Interface to Paperless Transaction Corporation BackOffice API

=head1 VERSION

version 0.001003

=head1 SYNOPSIS

	use Try::Tiny;
	use Business::OnlinePayment;

	my $tx = Business::OnlinePayment->new('PaperlessTrans');

	$tx->test_transaction(1);

	$tx->content(
		login          => 'TerminalID',
		password       => 'TerminalKey',
		debug          => '1', # 0, 1, 2
		type           => 'ECHECK',
		action         => 'Normal Authorization',
		check_number   => '132',
		amount         => 1.32,
		routing_code   => 111111118,
		account_number => 12121214,
		name           => 'Caleb Cushing',
		address        => '400 E. Royal Lane #201',
		city           => 'Irving',
		state          => 'TX',
		zip            => '75039-2291',
		country        => 'US',
	);

	try {
		$tx->submit;
	}
	catch {
		# log errors
	};

	if ( $tx->is_success ) {
		# do stuff with
		$tx->order_number;
		$tx->authorization;
	}
	else {
		# log
		$tx->error_message;
	}

	# start all over again credit cards
	$tx->content(
		login          => 'TerminalID',
		password       => 'TerminalKey',
		debug          => '1', # 0, 1, 2
		type        => 'CC',
		action      => 'Authorization Only',
		amount      => 1.00,
		name        => 'Caleb Cushing',
		card_number => '5454545454545454',
		expiration  => '1215',
		cvv2        => '111',
	);

	## ...

=head1 SEE ALSO

=over

=item L<BackOffice API|http://support.paperlesstrans.com/api-overview.php>

=item L<Business::OnlinePayment>

=item L<Business::PaperlessTrans>

=back

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
