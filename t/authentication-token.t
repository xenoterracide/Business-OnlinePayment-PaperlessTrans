use strict;
use warnings;
use Test::More;
use Class::Load 0.20 'load_class';

my $prefix = 'Business::PaperlessTrans::RequestPart::';

my $auth
	= new_ok( load_class( $prefix . 'AuthenticationToken' ) => [{
		terminal_id  => '00000000-0000-0000-0000-000000000000',
		terminal_key => '000000000',
	}]);

can_ok $auth, 'serialize';

is_deeply $auth->serialize, {
	TerminalID  => '00000000-0000-0000-0000-000000000000',
	TerminalKey => '000000000',
};

done_testing;
