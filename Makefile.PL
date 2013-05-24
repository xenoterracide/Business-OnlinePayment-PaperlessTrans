
use strict;
use warnings;

use 5.008;

use ExtUtils::MakeMaker 6.30;

use File::ShareDir::Install;
install_share dist => "share";


my %WriteMakefileArgs = (
  "ABSTRACT" => "Interface to Paperless Transaction Corporation BackOffice API",
  "AUTHOR" => "Caleb Cushing <xenoterracide\@gmail.com>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "File::ShareDir::Install" => "0.03"
  },
  "DISTNAME" => "Business-OnlinePayment-PaperlessTrans",
  "EXE_FILES" => [],
  "LICENSE" => "artistic_2",
  "NAME" => "Business::OnlinePayment::PaperlessTrans",
  "PREREQ_PM" => {
    "Business::OnlinePayment" => 0,
    "Carp" => 0,
    "Class::Load" => "0.20",
    "Data::Printer" => 0,
    "File::ShareDir::ProjectDistDir" => 0,
    "LWP::Protocol::https" => 0,
    "Module::Load" => 0,
    "Moose" => 0,
    "Moose::Role" => 0,
    "Moose::Util::TypeConstraints" => 0,
    "MooseX::RemoteHelper" => 0,
    "MooseX::RemoteHelper::CompositeSerialization" => 0,
    "MooseX::RemoteHelper::Types" => 0,
    "MooseX::Types::Common::Numeric" => "0.001003",
    "MooseX::Types::Common::String" => 0,
    "MooseX::Types::CreditCard" => "0.002",
    "MooseX::Types::DateTime" => 0,
    "MooseX::Types::Email" => 0,
    "MooseX::Types::Locale::Currency" => 0,
    "MooseX::Types::Path::Class" => 0,
    "MooseX::Types::UUID" => 0,
    "MooseX::UndefTolerant" => 0,
    "XML::Compile::SOAP11" => 0,
    "XML::Compile::Transport::SOAPHTTP" => 0,
    "XML::Compile::WSDL11" => 0,
    "namespace::autoclean" => 0,
    "parent" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Test::Method" => 0,
    "Test::More" => "0.88",
    "Test::Requires::Env" => 0
  },
  "VERSION" => "0.001001",
  "test" => {
    "TESTS" => "t/*.t t/bop/cc/reject/*.t t/bop/cc/success/*.t t/bop/echeck/reject/*.t t/bop/echeck/success/*.t t/request/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

{
package
MY;
use File::ShareDir::Install qw(postamble);
}


