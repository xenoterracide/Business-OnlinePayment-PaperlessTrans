package Business::BackOffice::Response::Role::Authorization;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Role;
use MooseX::RemoteHelper;
use MooseX::Types::Common::String qw( NonEmptySimpleStr );
use MooseX::Types::Moose          qw( Bool              );
use MooseX::Types -declare => [qw( IsApproved )];

subtype IsApproved, as Bool;
coerce  IsApproved, from NonEmptySimpleStr,
	via {
		my $val = lc $_;
		if ( $val eq 'true' ) {
			return 1;
		}
		elsif ( $val eq 'false' ) {
			return 0;
		}
		return 0;
	};

has is_approved => (
	remote_name => 'IsApproved',
	isa         => IsApproved,
	is          => 'ro',
	coerce      => 1,
);

has authorization => (
	remote_name => 'Authorization',
	isa         => NonEmptySimpleStr,
	is          => 'ro',
);
	
1;
# ABSTRACT: Authorized Card Response
