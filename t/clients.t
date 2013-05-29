use strict;
use warnings;
use Test::More;
use Class::Load 0.20 'load_class';

my $client0 = new_ok load_class('Business::PaperlessTrans::Client');

my $client1 = load_class('Business::OnlinePayment')->new( 'PaperlessTrans' );

isa_ok $client1, 'Business::OnlinePayment::PaperlessTrans';

can_ok $client0, 'submit';
can_ok $client1, 'submit';
can_ok $client1, 'content';

done_testing;
