use strict;
use warnings;

use Test::More;
use Test::Exception;
use Log::Any::Adapter::Util qw( cmp_deeply read_file );
use Message::Passing::Output::Log::Any::Adapter;
use Log::Any::Adapter;
use File::Temp qw( tempfile );

subtest 'missing adapter_name' => sub {
    dies_ok { Message::Passing::Output::Log::Any::Adapter->new() }
    'instantiation dies';
};

subtest 'without adapter_params' => sub {
    my $output = new_ok(
        'Message::Passing::Output::Log::Any::Adapter' =>
            [ adapter_name => 'Test::Memory' ],
        'instantiation ok'
    );

    ok( $output->consume('message'), 'consume ok' );

    my $log =
        Log::Any->get_logger(
        category => 'Message::Passing::Output::Log::Any::Adapter' );

    cmp_deeply(
        $log->{msgs},
        [   {   level    => 'info',
                category => 'Message::Passing::Output::Log::Any::Adapter',
                text     => 'message'
            }
        ],
        'message appeared in memory'
    );
};

subtest 'with adapter_params' => sub {
    my ( $fh, $filename ) = tempfile();

    my $output = new_ok(
        'Message::Passing::Output::Log::Any::Adapter' =>
            [ adapter_name => 'File', adapter_params => [$filename] ],
        'instantiation ok'
    );

    ok( $output->consume('message to file'), 'consume ok' );

    like( scalar read_file($filename),
        qr/message to file$/,
        'message appeared in file'
    );
};

done_testing;
