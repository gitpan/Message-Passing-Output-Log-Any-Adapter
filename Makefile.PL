
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "output messages via Log::Any::Adapter.",
  "AUTHOR" => "Alexander Hartmaier <abraxxa\@cpan.org>",
  "BUILD_REQUIRES" => {
    "File::Temp" => "0.22",
    "Test::Exception" => "0.31",
    "Test::More" => "0.98"
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Message-Passing-Output-Log-Any-Adapter",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Message::Passing::Output::Log::Any::Adapter",
  "PREREQ_PM" => {
    "Log::Any" => "0.14",
    "Log::Any::Adapter" => "0.09"
  },
  "VERSION" => "0.001",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


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



