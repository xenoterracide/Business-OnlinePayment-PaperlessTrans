package Business::OnlinePayment::PaperlessTrans;
use 5.008;
use strict;
use warnings;

# VERSION

use parent 'Business::OnlinePayment';
use Class::Load 0.20 'load_class';
use Carp;

my $ns     = 'Business::PaperlessTrans::';

sub submit {
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
		name_on_account => $content{name},
		number          => $content{card_number},
		security_code   => $content{cvv2},
		identification  => $content{identification},
		address         => $content{address},
		email_address   => $content{email},
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

# ABSTRACT: Interface to Paperless Transaction Corporation BackOffice API

=head1 SEE ALSO

=over

=item L<Business::OnlinePayment>

=item L<Business::PaperlessTrans>

=back
