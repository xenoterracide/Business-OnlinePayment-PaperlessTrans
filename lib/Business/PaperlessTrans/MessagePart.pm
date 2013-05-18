package Business::PaperlessTrans::MessagePart;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
use MooseX::RemoteHelper;
use MooseX::UndefTolerant;

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: A base class for messages
