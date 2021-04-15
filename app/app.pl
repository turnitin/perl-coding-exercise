#!/usr/bin/env perl
use Mojolicious::Lite -signatures;
use Mojo::Pg;
use Cache::Redis;

helper pg => sub { state $pg = Mojo::Pg->new( 'postgresql://app:app@postgres/app' ) };
helper cache => sub { state $cache = Cache::Redis->new( server => 'redis:6379', namespace => 'app:' ) };

get '/' => sub ( $c ) {
    my $message = $c->cache->get( 'message' );
    unless ( defined $message ) {
        my $result = $c->pg->db->query( 'SELECT message FROM hello' )->hash;
        $message = $result->{message};
        $c->cache->set( 'message', $message, 600 );
    }
    $c->render( text => $message );
};

app->start( 'daemon', '-l', 'http://*:80' );

1;
