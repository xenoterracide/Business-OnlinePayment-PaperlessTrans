package Business::OnlinePayment::BackOffice;
use 5.008;
use strict;
use warnings;

# VERSION

use parent 'Business::OnlinePayment';
use Class::Load 0.20 'load_class';
use Carp;

my $ns     = 'Business::BackOffice::';

sub submit {
	my ( $self ) = @_;

	my $card;
	my %content = $self->content;
	my $debug   = $content{debug} ? $content{debug} : 0;
	my $token   = $self->_content_to_token( %content );
	my $ident   = $self->_content_to_ident( %content );
	   $card    = $self->_content_to_card( %content, identification => $ident)
		if lc $self->transaction_type eq 'cc';

	my $request;
	if ( lc $content{action} eq 'authorization only'
			||  lc $content{action} eq 'normal authorization'
		) {
		my $request_class
			= lc $content{action} eq 'authorization only'
			? 'AuthorizeCard'
			: 'ProcessCard'
			;

		$request = load_class( $ns . 'Request::' . $request_class )->new({
			amount       => $content{amount},
			currency     => $content{currency},
			card         => $card,
			token        => $token,
			card_present => $content{track1} ? 1 : 0,
			test         => $self->test_transaction ? 1 : 0,
		});
	}

	$self->{_client}
		||= load_class( $ns . 'Client')
		->new({ debug => $debug })
		;

	my $response = $self->{_client}->submit( $request );

	# code != 0 is a transmission error
	if ( $response->code == 0 ) {
		if ( $response->is_approved ) {
			$self->is_success(1);
		}
		else {
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
		date_of_birth => $content{license_dob},
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

sub _content_to_card {
	my ( $self, %content ) = @_;

	# expiration api is bad but conforms to Business::OnlinePayment 3.02 Spec

	$content{expiration} =~ m/^(\d\d)(\d\d)$/xms;
	my ( $exp_month, $exp_year ) = ( $1, $2 ); ## no critic ( ProhibitCaptureWithoutTest )

	my %mapped = (
		name_on_account => $content{name},
		number          => $content{card_number},
		security_code   => $content{cvv2},
		identification  => $content{identification},
		expiration      => {
			month => $exp_month,
			year  => '20' . $exp_year,
		},
	);

	$mapped{track_data} = $content{track1} . $content{track2}
		if $content{track1} && $content{track2};

	return load_class( $ns . 'RequestPart::Card')->new( \%mapped );
}

1;

# ABSTRACT: Business::OnlinePayment::BackOffice
